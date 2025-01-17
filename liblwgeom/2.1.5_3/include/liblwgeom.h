/**********************************************************************
 * $Id: liblwgeom.h.in 12990 2014-09-19 21:23:22Z pramsey $
 *
 * PostGIS - Spatial Types for PostgreSQL
 *
 * Copyright 2011 Sandro Santilli <strk@keybit.net>
 * Copyright 2011 Paul Ramsey <pramsey@cleverelephant.ca>
 * Copyright 2007-2008 Mark Cave-Ayland
 * Copyright 2001-2006 Refractions Research Inc.
 *
 * This is free software; you can redistribute and/or modify it under
 * the terms of the GNU General Public Licence. See the COPYING file.
 *
 **********************************************************************/

#ifndef _LIBLWGEOM_H
#define _LIBLWGEOM_H 1

#include <stdarg.h>
#include <stdio.h>
#include <stdint.h>
#include "proj_api.h"

/**
* @file liblwgeom.h
*
* This library is the generic geometry handling section of PostGIS. The geometry
* objects, constructors, destructors, and a set of spatial processing functions,
* are implemented here.
*
* The library is designed for use in non-PostGIS applications if necessary. The
* units tests at cunit/cu_tester.c and the loader/dumper programs at
* ../loader/shp2pgsql.c are examples of non-PostGIS applications using liblwgeom.
*
* Programs using this library can install their custom memory managers and error
* handlers by calling the lwgeom_set_handlers() function, otherwise the default 
* ones will be used.
*/

/**
 * liblwgeom versions
 */
#define LIBLWGEOM_VERSION "2.1.5"
#define LIBLWGEOM_VERSION_MAJOR "2"
#define LIBLWGEOM_VERSION_MINOR "1"
#define LIBLWGEOM_GEOS_VERSION "36"

/**
* Return types for functions with status returns.
*/
#define LW_TRUE 1
#define LW_FALSE 0
#define LW_UNKNOWN 2
#define LW_FAILURE 0
#define LW_SUCCESS 1

/**
* LWTYPE numbers, used internally by PostGIS
*/
#define	POINTTYPE                1
#define	LINETYPE                 2
#define	POLYGONTYPE              3
#define	MULTIPOINTTYPE           4
#define	MULTILINETYPE            5
#define	MULTIPOLYGONTYPE         6
#define	COLLECTIONTYPE           7
#define CIRCSTRINGTYPE           8
#define COMPOUNDTYPE             9
#define CURVEPOLYTYPE           10
#define MULTICURVETYPE          11
#define MULTISURFACETYPE        12
#define POLYHEDRALSURFACETYPE   13
#define TRIANGLETYPE            14
#define TINTYPE                 15

#define NUMTYPES                16

/**
* Flags applied in EWKB to indicate Z/M dimensions and
* presence/absence of SRID and bounding boxes
*/
#define WKBZOFFSET  0x80000000
#define WKBMOFFSET  0x40000000
#define WKBSRIDFLAG 0x20000000
#define WKBBBOXFLAG 0x10000000

/**********************************************************************
** Spherical radius.
** Moritz, H. (1980). Geodetic Reference System 1980, by resolution of 
** the XVII General Assembly of the IUGG in Canberra.
** http://en.wikipedia.org/wiki/Earth_radius
** http://en.wikipedia.org/wiki/World_Geodetic_System
*/

#define WGS84_MAJOR_AXIS 6378137.0
#define WGS84_INVERSE_FLATTENING 298.257223563
#define WGS84_MINOR_AXIS (WGS84_MAJOR_AXIS - WGS84_MAJOR_AXIS / WGS84_INVERSE_FLATTENING)
#define WGS84_RADIUS ((2.0 * WGS84_MAJOR_AXIS + WGS84_MINOR_AXIS ) / 3.0)


/**
* Macros for manipulating the 'flags' byte. A uint8_t used as follows: 
* ---RGBMZ
* Three unused bits, followed by ReadOnly, Geodetic, HasBBox, HasM and HasZ flags.
*/
#define FLAGS_GET_Z(flags) ((flags) & 0x01)
#define FLAGS_GET_M(flags) (((flags) & 0x02)>>1)
#define FLAGS_GET_BBOX(flags) (((flags) & 0x04)>>2)
#define FLAGS_GET_GEODETIC(flags) (((flags) & 0x08)>>3)
#define FLAGS_GET_READONLY(flags) (((flags) & 0x10)>>4)
#define FLAGS_GET_SOLID(flags) (((flags) & 0x20)>>5)
#define FLAGS_SET_Z(flags, value) ((flags) = (value) ? ((flags) | 0x01) : ((flags) & 0xFE))
#define FLAGS_SET_M(flags, value) ((flags) = (value) ? ((flags) | 0x02) : ((flags) & 0xFD))
#define FLAGS_SET_BBOX(flags, value) ((flags) = (value) ? ((flags) | 0x04) : ((flags) & 0xFB))
#define FLAGS_SET_GEODETIC(flags, value) ((flags) = (value) ? ((flags) | 0x08) : ((flags) & 0xF7))
#define FLAGS_SET_READONLY(flags, value) ((flags) = (value) ? ((flags) | 0x10) : ((flags) & 0xEF))
#define FLAGS_SET_SOLID(flags, value) ((flags) = (value) ? ((flags) | 0x20) : ((flags) & 0xDF))
#define FLAGS_NDIMS(flags) (2 + FLAGS_GET_Z(flags) + FLAGS_GET_M(flags))
#define FLAGS_GET_ZM(flags) (FLAGS_GET_M(flags) + FLAGS_GET_Z(flags) * 2)
#define FLAGS_NDIMS_BOX(flags) (FLAGS_GET_GEODETIC(flags) ? 3 : FLAGS_NDIMS(flags))

/**
* Macros for manipulating the 'typemod' int. An int32_t used as follows:
* Plus/minus = Top bit.
* Spare bits = Next 2 bits.
* SRID = Next 21 bits.
* TYPE = Next 6 bits.
* ZM Flags = Bottom 2 bits.
*/

#define TYPMOD_GET_SRID(typmod) ((((typmod) & 0x1FFFFF00)<<3)>>11)
#define TYPMOD_SET_SRID(typmod, srid) ((typmod) = (((typmod) & 0xE00000FF) | ((srid & 0x001FFFFF)<<8)))
#define TYPMOD_GET_TYPE(typmod) ((typmod & 0x000000FC)>>2)
#define TYPMOD_SET_TYPE(typmod, type) ((typmod) = (typmod & 0xFFFFFF03) | ((type & 0x0000003F)<<2))
#define TYPMOD_GET_Z(typmod) ((typmod & 0x00000002)>>1)
#define TYPMOD_SET_Z(typmod) ((typmod) = typmod | 0x00000002)
#define TYPMOD_GET_M(typmod) (typmod & 0x00000001)
#define TYPMOD_SET_M(typmod) ((typmod) = typmod | 0x00000001)
#define TYPMOD_GET_NDIMS(typmod) (2+TYPMOD_GET_Z(typmod)+TYPMOD_GET_M(typmod))

/**
* Maximum allowed SRID value in serialized geometry.
* Currently we are using 21 bits (2097152) of storage for SRID.
*/
#define SRID_MAXIMUM 999999

/**
 * Maximum valid SRID value for the user
 * We reserve 1000 values for internal use
 */
#define SRID_USER_MAXIMUM 998999

/** Unknown SRID value */
#define SRID_UNKNOWN 0
#define SRID_IS_UNKNOWN(x) ((int)x<=0)

/* 
** EPSG WGS84 geographics, OGC standard default SRS, better be in 
** the SPATIAL_REF_SYS table!
*/
#define SRID_DEFAULT 4326

/**
* Return a valid SRID from an arbitrary integer
* Raises a notice if what comes out is different from
* what went in.
* Raises an error if SRID value is out of bounds.
*/
extern int clamp_srid(int srid);


/**
 * Global functions for memory/logging handlers.
 */
typedef void* (*lwallocator)(size_t size);
typedef void* (*lwreallocator)(void *mem, size_t size);
typedef void (*lwfreeor)(void* mem);
typedef void (*lwreporter)(const char* fmt, va_list ap);

/**
* Install custom memory management and error handling functions you want your
* application to use.
* @ingroup system
* @todo take a structure ?
*/
extern void lwgeom_set_handlers(lwallocator allocator, 
        lwreallocator reallocator, lwfreeor freeor, lwreporter errorreporter,
        lwreporter noticereporter);

/**
 * Write a notice out to the notice handler.
 *
 * Uses standard printf() substitutions.
 * Use for messages you always want output.
 * For debugging, use LWDEBUG() or LWDEBUGF().
 * @ingroup logging
 */
void lwnotice(const char *fmt, ...);

/**
 * Write a notice out to the error handler.
 *
 * Uses standard printf() substitutions.
 * Use for errors you always want output.
 * For debugging, use LWDEBUG() or LWDEBUGF().
 * @ingroup logging
 */
void lwerror(const char *fmt, ...);


/* TODO: move these elsewhere */
extern int lw_vasprintf (char **result, const char *format, va_list args);
extern int lw_asprintf
#if __STDC__
(char **result, const char *format, ...);
#else
(result, va_alist);
char **result;
va_dcl
#endif


/******************************************************************/

typedef struct {
	double afac, bfac, cfac, dfac, efac, ffac, gfac, hfac, ifac, xoff, yoff, zoff;
} AFFINE;

/******************************************************************/

typedef struct
{
	double xmin, ymin, zmin;
	double xmax, ymax, zmax;
	int32_t srid;
}
BOX3D;

/******************************************************************
* GBOX structure. 
* We include the flags (information about dimensinality), 
* so we don't have to constantly pass them
* into functions that use the GBOX.
*/
typedef struct
{
	uint8_t flags;
	double xmin;
	double xmax;
	double ymin;
	double ymax;
	double zmin;
	double zmax;
	double mmin;
	double mmax;
} GBOX;


/******************************************************************
* SPHEROID
*
*  Standard definition of an ellipsoid (what wkt calls a spheroid)
*    f = (a-b)/a
*    e_sq = (a*a - b*b)/(a*a)
*    b = a - fa
*/
typedef struct
{
	double	a;	/* semimajor axis */
	double	b; 	/* semiminor axis b = (a - fa) */
	double	f;	/* flattening f = (a-b)/a */
	double	e;	/* eccentricity (first) */
	double	e_sq;	/* eccentricity squared (first) e_sq = (a*a-b*b)/(a*a) */
	double  radius;  /* spherical average radius = (2*a+b)/3 */
	char	name[20];  /* name of ellipse */
}
SPHEROID;

/******************************************************************
* POINT2D, POINT3D, POINT3DM, POINT4D
*/
typedef struct
{
	double x, y;
}
POINT2D;

typedef struct
{
	double x, y, z;
}
POINT3DZ;

typedef struct
{
	double x, y, z;
}
POINT3D;

typedef struct
{
	double x, y, m;
}
POINT3DM;

typedef struct
{
	double x, y, z, m;
}
POINT4D;

/******************************************************************
*  POINTARRAY
*  Point array abstracts a lot of the complexity of points and point lists.
*  It handles 2d/3d translation
*    (2d points converted to 3d will have z=0 or NaN)
*  DO NOT MIX 2D and 3D POINTS! EVERYTHING* is either one or the other
*/
typedef struct
{
	/* Array of POINT 2D, 3D or 4D, possibly missaligned. */
	uint8_t *serialized_pointlist;

	/* Use FLAGS_* macros to handle */
	uint8_t  flags;

	int npoints;   /* how many points we are currently storing */
	int maxpoints; /* how many points we have space for in serialized_pointlist */
}
POINTARRAY;

/******************************************************************
* GSERIALIZED
*/
typedef struct
{
	uint32_t size; /* For PgSQL use only, use VAR* macros to manipulate. */
	uint8_t srid[3]; /* 24 bits of SRID */
	uint8_t flags; /* HasZ, HasM, HasBBox, IsGeodetic, IsReadOnly */
	uint8_t data[1]; /* See gserialized.txt */
} GSERIALIZED;


/******************************************************************
* LWGEOM (any geometry type)
*
* Abstract type, note that 'type', 'bbox' and 'srid' are available in 
* all geometry variants.
*/
typedef struct
{
	uint8_t type;
	uint8_t flags;
	GBOX *bbox;
	int32_t srid;
	void *data;
}
LWGEOM;

/* POINTYPE */
typedef struct
{
	uint8_t type; /* POINTTYPE */
	uint8_t flags;
	GBOX *bbox;
	int32_t srid;
	POINTARRAY *point;  /* hide 2d/3d (this will be an array of 1 point) */
}
LWPOINT; /* "light-weight point" */

/* LINETYPE */
typedef struct
{
	uint8_t type; /* LINETYPE */
	uint8_t flags;
	GBOX *bbox;
	int32_t srid;
	POINTARRAY *points; /* array of POINT3D */
}
LWLINE; /* "light-weight line" */

/* TRIANGLE */
typedef struct
{
	uint8_t type;
	uint8_t flags;
	GBOX *bbox;
	int32_t srid;
	POINTARRAY *points;
}
LWTRIANGLE;

/* CIRCSTRINGTYPE */
typedef struct
{
	uint8_t type; /* CIRCSTRINGTYPE */
	uint8_t flags;
	GBOX *bbox;
	int32_t srid;
	POINTARRAY *points; /* array of POINT(3D/3DM) */
}
LWCIRCSTRING; /* "light-weight circularstring" */

/* POLYGONTYPE */
typedef struct
{
	uint8_t type; /* POLYGONTYPE */
	uint8_t flags;
	GBOX *bbox;
	int32_t srid;
	int nrings;   /* how many rings we are currently storing */
	int maxrings; /* how many rings we have space for in **rings */
	POINTARRAY **rings; /* list of rings (list of points) */
}
LWPOLY; /* "light-weight polygon" */

/* MULTIPOINTTYPE */
typedef struct
{
	uint8_t type;
	uint8_t flags;
	GBOX *bbox;
	int32_t srid;
	int ngeoms;   /* how many geometries we are currently storing */
	int maxgeoms; /* how many geometries we have space for in **geoms */
	LWPOINT **geoms;
}
LWMPOINT;

/* MULTILINETYPE */
typedef struct
{
	uint8_t type;
	uint8_t flags;
	GBOX *bbox;
	int32_t srid;
	int ngeoms;   /* how many geometries we are currently storing */
	int maxgeoms; /* how many geometries we have space for in **geoms */
	LWLINE **geoms;
}
LWMLINE;

/* MULTIPOLYGONTYPE */
typedef struct
{
	uint8_t type;
	uint8_t flags;
	GBOX *bbox;
	int32_t srid;
	int ngeoms;   /* how many geometries we are currently storing */
	int maxgeoms; /* how many geometries we have space for in **geoms */
	LWPOLY **geoms;
}
LWMPOLY;

/* COLLECTIONTYPE */
typedef struct
{
	uint8_t type;
	uint8_t flags;
	GBOX *bbox;
	int32_t srid;
	int ngeoms;   /* how many geometries we are currently storing */
	int maxgeoms; /* how many geometries we have space for in **geoms */
	LWGEOM **geoms;
}
LWCOLLECTION;

/* COMPOUNDTYPE */
typedef struct
{
	uint8_t type; /* COMPOUNDTYPE */
	uint8_t flags;
	GBOX *bbox;
	int32_t srid;
	int ngeoms;   /* how many geometries we are currently storing */
	int maxgeoms; /* how many geometries we have space for in **geoms */
	LWGEOM **geoms;
}
LWCOMPOUND; /* "light-weight compound line" */

/* CURVEPOLYTYPE */
typedef struct
{
	uint8_t type; /* CURVEPOLYTYPE */
	uint8_t flags;
	GBOX *bbox;
	int32_t srid;
	int nrings;    /* how many rings we are currently storing */
	int maxrings;  /* how many rings we have space for in **rings */
	LWGEOM **rings; /* list of rings (list of points) */
}
LWCURVEPOLY; /* "light-weight polygon" */

/* MULTICURVE */
typedef struct
{
	uint8_t type;
	uint8_t flags;
	GBOX *bbox;
	int32_t srid;
	int ngeoms;   /* how many geometries we are currently storing */
	int maxgeoms; /* how many geometries we have space for in **geoms */
	LWGEOM **geoms;
}
LWMCURVE;

/* MULTISURFACETYPE */
typedef struct
{
	uint8_t type;
	uint8_t flags;
	GBOX *bbox;
	int32_t srid;
	int ngeoms;   /* how many geometries we are currently storing */
	int maxgeoms; /* how many geometries we have space for in **geoms */
	LWGEOM **geoms;
}
LWMSURFACE;

/* POLYHEDRALSURFACETYPE */
typedef struct
{
	uint8_t type;
	uint8_t flags;
	GBOX *bbox;
	int32_t srid;
	int ngeoms;   /* how many geometries we are currently storing */
	int maxgeoms; /* how many geometries we have space for in **geoms */
	LWPOLY **geoms;
}
LWPSURFACE;

/* TINTYPE */
typedef struct
{
	uint8_t type;
	uint8_t flags;
	GBOX *bbox;
	int32_t srid;
	int ngeoms;   /* how many geometries we are currently storing */
	int maxgeoms; /* how many geometries we have space for in **geoms */
	LWTRIANGLE **geoms;
}
LWTIN;

/* Casts LWGEOM->LW* (return NULL if cast is illegal) */
extern LWMPOLY *lwgeom_as_lwmpoly(const LWGEOM *lwgeom);
extern LWMLINE *lwgeom_as_lwmline(const LWGEOM *lwgeom);
extern LWMPOINT *lwgeom_as_lwmpoint(const LWGEOM *lwgeom);
extern LWCOLLECTION *lwgeom_as_lwcollection(const LWGEOM *lwgeom);
extern LWPOLY *lwgeom_as_lwpoly(const LWGEOM *lwgeom);
extern LWLINE *lwgeom_as_lwline(const LWGEOM *lwgeom);
extern LWPOINT *lwgeom_as_lwpoint(const LWGEOM *lwgeom);
extern LWCIRCSTRING *lwgeom_as_lwcircstring(const LWGEOM *lwgeom);
extern LWCURVEPOLY *lwgeom_as_lwcurvepoly(const LWGEOM *lwgeom);
extern LWCOMPOUND *lwgeom_as_lwcompound(const LWGEOM *lwgeom);
extern LWPSURFACE *lwgeom_as_lwpsurface(const LWGEOM *lwgeom);
extern LWTRIANGLE *lwgeom_as_lwtriangle(const LWGEOM *lwgeom);
extern LWTIN *lwgeom_as_lwtin(const LWGEOM *lwgeom);
extern LWGEOM *lwgeom_as_multi(const LWGEOM *lwgeom);

/* Casts LW*->LWGEOM (always cast) */
extern LWGEOM *lwtin_as_lwgeom(const LWTIN *obj);
extern LWGEOM *lwtriangle_as_lwgeom(const LWTRIANGLE *obj);
extern LWGEOM *lwpsurface_as_lwgeom(const LWPSURFACE *obj);
extern LWGEOM *lwmpoly_as_lwgeom(const LWMPOLY *obj);
extern LWGEOM *lwmline_as_lwgeom(const LWMLINE *obj);
extern LWGEOM *lwmpoint_as_lwgeom(const LWMPOINT *obj);
extern LWGEOM *lwcollection_as_lwgeom(const LWCOLLECTION *obj);
extern LWGEOM *lwcircstring_as_lwgeom(const LWCIRCSTRING *obj);
extern LWGEOM *lwcompound_as_lwgeom(const LWCOMPOUND *obj);
extern LWGEOM *lwcurvepoly_as_lwgeom(const LWCURVEPOLY *obj);
extern LWGEOM *lwpoly_as_lwgeom(const LWPOLY *obj);
extern LWGEOM *lwline_as_lwgeom(const LWLINE *obj);
extern LWGEOM *lwpoint_as_lwgeom(const LWPOINT *obj);


extern LWCOLLECTION* lwcollection_add_lwgeom(LWCOLLECTION *col, const LWGEOM *geom);
extern LWMPOINT* lwmpoint_add_lwpoint(LWMPOINT *mobj, const LWPOINT *obj);
extern LWMLINE* lwmline_add_lwline(LWMLINE *mobj, const LWLINE *obj);
extern LWMPOLY* lwmpoly_add_lwpoly(LWMPOLY *mobj, const LWPOLY *obj);
extern LWPSURFACE* lwpsurface_add_lwpoly(LWPSURFACE *mobj, const LWPOLY *obj);
extern LWTIN* lwtin_add_lwtriangle(LWTIN *mobj, const LWTRIANGLE *obj);



/***********************************************************************
** Utility functions for flag byte and srid_flag integer.
*/

/**
* Construct a new flags char.
*/
extern uint8_t gflags(int hasz, int hasm, int geodetic);

/**
* Extract the geometry type from the serialized form (it hides in 
* the anonymous data area, so this is a handy function).
*/
extern uint32_t gserialized_get_type(const GSERIALIZED *g);

/**
* Extract the SRID from the serialized form (it is packed into
* three bytes so this is a handy function).
*/
extern int32_t gserialized_get_srid(const GSERIALIZED *g);

/**
* Write the SRID into the serialized form (it is packed into
* three bytes so this is a handy function).
*/
extern void gserialized_set_srid(GSERIALIZED *g, int32_t srid);

/**
* Check if a #GSERIALIZED is empty without deserializing first.
* Only checks if the number of elements of the parent geometry
* is zero, will not catch collections of empty, eg: 
* GEOMETRYCOLLECTION(POINT EMPTY) 
*/
extern int gserialized_is_empty(const GSERIALIZED *g);

/**
* Check if a #GSERIALIZED has a bounding box without deserializing first.
*/
extern int gserialized_has_bbox(const GSERIALIZED *gser);

/**
* Check if a #GSERIALIZED has a Z ordinate.
*/
extern int gserialized_has_z(const GSERIALIZED *gser);

/**
* Check if a #GSERIALIZED has an M ordinate.
*/
extern int gserialized_has_m(const GSERIALIZED *gser);

/**
* Return a number indicating presence of Z and M coordinates.
* 0 = None, 1 = M, 2 = Z, 3 = ZM
*/
extern int gserialized_get_zm(const GSERIALIZED *gser);

/**
* Return the number of dimensions (2, 3, 4) in a geometry
*/
extern int gserialized_ndims(const GSERIALIZED *gser);


/**
* Call this function to drop BBOX and SRID
* from LWGEOM. If LWGEOM type is *not* flagged
* with the HASBBOX flag and has a bbox, it
* will be released.
*/
extern void lwgeom_drop_bbox(LWGEOM *lwgeom);
extern void lwgeom_drop_srid(LWGEOM *lwgeom);

/** 
 * Compute a bbox if not already computed 
 *
 * After calling this function lwgeom->bbox is only
 * NULL if the geometry is empty.
 */
extern void lwgeom_add_bbox(LWGEOM *lwgeom);
/**
* Compute a box for geom and all sub-geometries, if not already computed
*/
extern void lwgeom_add_bbox_deep(LWGEOM *lwgeom, GBOX *gbox);

/** 
 * Get a non-empty geometry bounding box, computing and
 * caching it if not already there
 *
 * NOTE: empty geometries don't have a bounding box so
 *       you'd still get a NULL for them.
 */
extern const GBOX *lwgeom_get_bbox(const LWGEOM *lwgeom);

/** 
* Determine whether a LWGEOM can contain sub-geometries or not 
*/
extern int lwgeom_is_collection(const LWGEOM *lwgeom);

/******************************************************************/
/* Functions that work on type numbers */

/** 
* Determine whether a type number is a collection or not
*/
extern int lwtype_is_collection(uint8_t type);

/**
* Given an lwtype number, what homogeneous collection can hold it?
*/
extern int lwtype_get_collectiontype(uint8_t type);

/**
* Return the type name string associated with a type number 
* (e.g. Point, LineString, Polygon)
*/
extern const char *lwtype_name(uint8_t type);


/******************************************************************/

/*
 * copies a point from the point array into the parameter point
 * will set point's z=0 (or NaN) if pa is 2d
 * will set point's m=0 (or NaN) if pa is 3d or 2d
 * NOTE: point is a real POINT3D *not* a pointer
 */
extern POINT4D getPoint4d(const POINTARRAY *pa, int n);

/*
 * copies a point from the point array into the parameter point
 * will set point's z=0 (or NaN) if pa is 2d
 * will set point's m=0 (or NaN) if pa is 3d or 2d
 * NOTE: this will modify the point4d pointed to by 'point'.
 */
extern int getPoint4d_p(const POINTARRAY *pa, int n, POINT4D *point);

/*
 * copies a point from the point array into the parameter point
 * will set point's z=0 (or NaN) if pa is 2d
 * NOTE: point is a real POINT3D *not* a pointer
 */
extern POINT3DZ getPoint3dz(const POINTARRAY *pa, int n);
extern POINT3DM getPoint3dm(const POINTARRAY *pa, int n);

/*
 * copies a point from the point array into the parameter point
 * will set point's z=0 (or NaN) if pa is 2d
 * NOTE: this will modify the point3d pointed to by 'point'.
 */
extern int getPoint3dz_p(const POINTARRAY *pa, int n, POINT3DZ *point);
extern int getPoint3dm_p(const POINTARRAY *pa, int n, POINT3DM *point);


/*
 * copies a point from the point array into the parameter point
 * z value (if present is not returned)
 * NOTE: point is a real POINT3D *not* a pointer
 */
extern POINT2D getPoint2d(const POINTARRAY *pa, int n);

/*
 * copies a point from the point array into the parameter point
 * z value (if present is not returned)
 * NOTE: this will modify the point2d pointed to by 'point'.
 */
extern int getPoint2d_p(const POINTARRAY *pa, int n, POINT2D *point);

/**
* Returns a pointer into the POINTARRAY serialized_ptlist, 
* suitable for reading from. This is very high performance
* and declared const because you aren't allowed to muck with the 
* values, only read them.
*/
extern const POINT2D* getPoint2d_cp(const POINTARRAY *pa, int n);

/*
 * set point N to the given value
 * NOTE that the pointarray can be of any
 * dimension, the appropriate ordinate values
 * will be extracted from it
 *
 * N must be a valid point index 
 */
extern void ptarray_set_point4d(POINTARRAY *pa, int n, const POINT4D *p4d);

/*
 * get a pointer to nth point of a POINTARRAY
 * You'll need to cast it to appropriate dimensioned point.
 * Note that if you cast to a higher dimensional point you'll
 * possibly corrupt the POINTARRAY.
 *
 * WARNING: Don't cast this to a POINT !
 * it would not be reliable due to memory alignment constraints
 */
extern uint8_t *getPoint_internal(const POINTARRAY *pa, int n);

/*
 * size of point represeneted in the POINTARRAY
 * 16 for 2d, 24 for 3d, 32 for 4d
 */
extern int ptarray_point_size(const POINTARRAY *pa);


/** 
* Construct an empty pointarray, allocating storage and setting
* the npoints, but not filling in any information. Should be used in conjunction
* with ptarray_set_point4d to fill in the information in the array.
*/
extern POINTARRAY* ptarray_construct(char hasz, char hasm, uint32_t npoints);

/**
* Construct a new #POINTARRAY, <em>copying</em> in the data from ptlist 
*/
extern POINTARRAY* ptarray_construct_copy_data(char hasz, char hasm, uint32_t npoints, const uint8_t *ptlist);

/**
* Construct a new #POINTARRAY, <em>referencing</em> to the data from ptlist 
*/
extern POINTARRAY* ptarray_construct_reference_data(char hasz, char hasm, uint32_t npoints, uint8_t *ptlist);

/**
* Create a new #POINTARRAY with no points. Allocate enough storage
* to hold maxpoints vertices before having to reallocate the storage
* area.
*/
extern POINTARRAY* ptarray_construct_empty(char hasz, char hasm, uint32_t maxpoints);

/**
* Append a point to the end of an existing #POINTARRAY 
* If allow_duplicate is LW_TRUE, then a duplicate point will
* not be added.
*/
extern int ptarray_append_point(POINTARRAY *pa, const POINT4D *pt, int allow_duplicates);

/**
 * Append a #POINTARRAY, pa2 to the end of an existing #POINTARRAY, pa1.
 *
 * If gap_tolerance is >= 0 then the end point of pa1 will be checked for
 * being within gap_tolerance 2d distance from start point of pa2 or an
 * error will be raised and LW_FAILURE returned.
 * A gap_tolerance < 0 disables the check.
 *
 * If end point of pa1 and start point of pa2 are 2d-equal, then pa2 first
 * point will not be appended.
 */
extern int ptarray_append_ptarray(POINTARRAY *pa1, POINTARRAY *pa2, double gap_tolerance);

/**
* Insert a point into an existing #POINTARRAY. Zero
* is the index of the start of the array.
*/
extern int ptarray_insert_point(POINTARRAY *pa, const POINT4D *p, int where);

/**
* Remove a point from an existing #POINTARRAY. Zero
* is the index of the start of the array.
*/
extern int ptarray_remove_point(POINTARRAY *pa, int where);

extern POINTARRAY *ptarray_addPoint(const POINTARRAY *pa, uint8_t *p, size_t pdims, uint32_t where);
extern POINTARRAY *ptarray_removePoint(POINTARRAY *pa, uint32_t where);
extern POINTARRAY *ptarray_merge(POINTARRAY *pa1, POINTARRAY *pa2);
extern int ptarray_is_closed(const POINTARRAY *pa);
extern int ptarray_is_closed_2d(const POINTARRAY *pa);
extern int ptarray_is_closed_3d(const POINTARRAY *pa);
extern int ptarray_is_closed_z(const POINTARRAY *pa);
extern void ptarray_longitude_shift(POINTARRAY *pa);
extern void ptarray_reverse(POINTARRAY *pa);
extern POINTARRAY* ptarray_flip_coordinates(POINTARRAY *pa);

/**
 * @d1 start location (distance from start / total distance)
 * @d2   end location (distance from start / total distance)
 * @param tolerance snap to vertices at locations < tolerance away from given ones
 */
extern POINTARRAY *ptarray_substring(POINTARRAY *pa, double d1, double d2,
                                                          double tolerance);


/**
* Strip out the Z/M components of an #LWGEOM
*/
extern LWGEOM* lwgeom_force_2d(const LWGEOM *geom);
extern LWGEOM* lwgeom_force_3dz(const LWGEOM *geom);
extern LWGEOM* lwgeom_force_3dm(const LWGEOM *geom);
extern LWGEOM* lwgeom_force_4d(const LWGEOM *geom);

extern LWGEOM* lwgeom_simplify(const LWGEOM *igeom, double dist);

/* 
 * Force to use SFS 1.1 geometry type
 * (rather than SFS 1.2 and/or SQL/MM)
 */
extern LWGEOM* lwgeom_force_sfs(LWGEOM *geom, int version);


/*--------------------------------------------------------
 * all the base types (point/line/polygon) will have a
 * basic constructor, basic de-serializer, basic serializer,
 * bounding box finder and (TODO) serialized form size finder.
 *--------------------------------------------------------*/

/*
 * convenience functions to hide the POINTARRAY
 */
extern int lwpoint_getPoint2d_p(const LWPOINT *point, POINT2D *out);
extern int lwpoint_getPoint3dz_p(const LWPOINT *point, POINT3DZ *out);
extern int lwpoint_getPoint3dm_p(const LWPOINT *point, POINT3DM *out);
extern int lwpoint_getPoint4d_p(const LWPOINT *point, POINT4D *out);

/******************************************************************
 * LWLINE functions
 ******************************************************************/

/**
 * Add a LWPOINT to an LWLINE
 */
extern int lwline_add_lwpoint(LWLINE *line, LWPOINT *point, int where);

/******************************************************************
 * LWPOLY functions
 ******************************************************************/

/**
* Add a ring, allocating extra space if necessary. The polygon takes
* ownership of the passed point array.
*/
extern int lwpoly_add_ring(LWPOLY *poly, POINTARRAY *pa);

/**
* Add a ring, allocating extra space if necessary. The curvepolygon takes
* ownership of the passed point array.
*/
extern int lwcurvepoly_add_ring(LWCURVEPOLY *poly, LWGEOM *ring);

/**
* Add a component, allocating extra space if necessary. The compoundcurve
* takes owership of the passed geometry.
*/
extern int lwcompound_add_lwgeom(LWCOMPOUND *comp, LWGEOM *geom);

/**
* Construct an equivalent curve polygon from a polygon. Curve polygons
* can have linear rings as their rings, so this works fine (in theory?)
*/
extern LWCURVEPOLY* lwcurvepoly_construct_from_lwpoly(LWPOLY *lwpoly);


/******************************************************************
 * LWGEOM functions
 ******************************************************************/

extern int lwcollection_ngeoms(const LWCOLLECTION *col);

/* Given a generic geometry/collection, return the "simplest" form. */
extern LWGEOM *lwgeom_homogenize(const LWGEOM *geom);


/******************************************************************
 * LWMULTIx and LWCOLLECTION functions
 ******************************************************************/

LWGEOM *lwcollection_getsubgeom(LWCOLLECTION *col, int gnum);
LWCOLLECTION* lwcollection_extract(LWCOLLECTION *col, int type);


/******************************************************************
 * SERIALIZED FORM functions
 ******************************************************************/

/**
* Set the SRID on an LWGEOM
* For collections, only the parent gets an SRID, all
* the children get SRID_UNKNOWN.
*/
extern void lwgeom_set_srid(LWGEOM *geom, int srid);

/*------------------------------------------------------
 * other stuff
 *
 * handle the double-to-float conversion.  The results of this
 * will usually be a slightly bigger box because of the difference
 * between float8 and float4 representations.
 */

extern BOX3D* box3d_from_gbox(const GBOX *gbox);
extern GBOX* box3d_to_gbox(const BOX3D *b3d);

void expand_box3d(BOX3D *box, double d);


/****************************************************************
 * MEMORY MANAGEMENT
 ****************************************************************/

/*
* The *_free family of functions frees *all* memory associated
* with the pointer. When the recursion gets to the level of the 
* POINTARRAY, the POINTARRAY is only freed if it is not flagged
* as "read only". LWGEOMs constructed on top of GSERIALIZED
* from PgSQL use read only point arrays.
*/

extern void ptarray_free(POINTARRAY *pa);
extern void lwpoint_free(LWPOINT *pt);
extern void lwline_free(LWLINE *line);
extern void lwpoly_free(LWPOLY *poly);
extern void lwtriangle_free(LWTRIANGLE *triangle);
extern void lwmpoint_free(LWMPOINT *mpt);
extern void lwmline_free(LWMLINE *mline);
extern void lwmpoly_free(LWMPOLY *mpoly);
extern void lwpsurface_free(LWPSURFACE *psurf);
extern void lwtin_free(LWTIN *tin);
extern void lwcollection_free(LWCOLLECTION *col);
extern void lwcircstring_free(LWCIRCSTRING *curve);
extern void lwgeom_free(LWGEOM *geom);

/*
* The *_release family of functions frees the LWGEOM structures
* surrounding the POINTARRAYs but leaves the POINTARRAYs
* intact. Useful when re-shaping geometries between types,
* or splicing geometries together.
*/

extern void lwpoint_release(LWPOINT *lwpoint);
extern void lwline_release(LWLINE *lwline);
extern void lwpoly_release(LWPOLY *lwpoly);
extern void lwtriangle_release(LWTRIANGLE *lwtriangle);
extern void lwcircstring_release(LWCIRCSTRING *lwcirc);
extern void lwmpoint_release(LWMPOINT *lwpoint);
extern void lwmline_release(LWMLINE *lwline);
extern void lwmpoly_release(LWMPOLY *lwpoly);
extern void lwpsurface_release(LWPSURFACE *lwpsurface);
extern void lwtin_release(LWTIN *lwtin);
extern void lwcollection_release(LWCOLLECTION *lwcollection);
extern void lwgeom_release(LWGEOM *lwgeom);


/****************************************************************
* Utility
****************************************************************/

extern void printBOX3D(BOX3D *b);
extern void printPA(POINTARRAY *pa);
extern void printLWPOINT(LWPOINT *point);
extern void printLWLINE(LWLINE *line);
extern void printLWPOLY(LWPOLY *poly);
extern void printLWTRIANGLE(LWTRIANGLE *triangle);
extern void printLWPSURFACE(LWPSURFACE *psurf);
extern void printLWTIN(LWTIN *tin);

extern float  next_float_down(double d);
extern float  next_float_up(double d);
extern double next_double_down(float d);
extern double next_double_up(float d);

/* general utilities
	2D*/
extern double distance2d_pt_pt(const POINT2D *p1, const POINT2D *p2);
extern double distance2d_pt_seg(const POINT2D *p, const POINT2D *A, const POINT2D *B);
extern LWGEOM *lw_dist2d_distancepoint(LWGEOM *lw1, LWGEOM *lw2,int srid,int mode);
extern LWGEOM *lw_dist2d_distanceline(LWGEOM *lw1, LWGEOM *lw2,int srid,int mode);
extern double lwgeom_mindistance2d(LWGEOM *lw1, LWGEOM *lw2);
extern double lwgeom_mindistance2d_tolerance(LWGEOM *lw1, LWGEOM *lw2, double tolerance);
extern double lwgeom_maxdistance2d(LWGEOM *lw1, LWGEOM *lw2);
extern double lwgeom_maxdistance2d_tolerance(LWGEOM *lw1, LWGEOM *lw2, double tolerance);
/*
	3D*/
extern double distance3d_pt_pt(const POINT3D *p1, const POINT3D *p2);
extern double distance3d_pt_seg(const POINT3D *p, const POINT3D *A, const POINT3D *B);
extern LWGEOM *lw_dist3d_distancepoint(LWGEOM *lw1, LWGEOM *lw2,int srid,int mode);
extern LWGEOM *lw_dist3d_distanceline(LWGEOM *lw1, LWGEOM *lw2,int srid,int mode);
extern double lwgeom_mindistance3d(LWGEOM *lw1, LWGEOM *lw2);
extern double lwgeom_mindistance3d_tolerance(LWGEOM *lw1, LWGEOM *lw2, double tolerance);
extern double lwgeom_maxdistance3d(LWGEOM *lw1, LWGEOM *lw2);
extern double lwgeom_maxdistance3d_tolerance(LWGEOM *lw1, LWGEOM *lw2, double tolerance);


extern double lwgeom_area(const LWGEOM *geom);
extern double lwgeom_length(const LWGEOM *geom);
extern double lwgeom_length_2d(const LWGEOM *geom);
extern double lwgeom_perimeter(const LWGEOM *geom);
extern double lwgeom_perimeter_2d(const LWGEOM *geom);
extern void lwgeom_affine(LWGEOM *geom, const AFFINE *affine);
extern int lwgeom_dimension(const LWGEOM *geom);

extern LWPOINT* lwline_get_lwpoint(LWLINE *line, int where);
extern LWPOINT* lwcircstring_get_lwpoint(LWCIRCSTRING *circ, int where);

extern double ptarray_length_2d(const POINTARRAY *pts);
extern double ptarray_length(const POINTARRAY *pts);
extern double ptarray_arc_length_2d(const POINTARRAY *pts);


extern int pt_in_ring_2d(const POINT2D *p, const POINTARRAY *ring);
extern int azimuth_pt_pt(const POINT2D *p1, const POINT2D *p2, double *ret);
extern int lwpoint_inside_circle(const LWPOINT *p, double cx, double cy, double rad);
extern void lwgeom_reverse(LWGEOM *lwgeom);
extern void lwline_reverse(LWLINE *line);
extern void lwpoly_reverse(LWPOLY *poly);
extern void lwtriangle_reverse(LWTRIANGLE *triangle);
extern char* lwgeom_summary(const LWGEOM *lwgeom, int offset);
extern char* lwpoint_to_latlon(const LWPOINT *p, const char *format);
extern int lwgeom_startpoint(const LWGEOM* lwgeom, POINT4D* pt);

/**
* Ensure the outer ring is clockwise oriented and all inner rings 
* are counter-clockwise.
*/
extern void lwgeom_force_clockwise(LWGEOM *lwgeom);
extern void lwpoly_force_clockwise(LWPOLY *poly);
extern void lwtriangle_force_clockwise(LWTRIANGLE *triangle);


extern void interpolate_point4d(POINT4D *A, POINT4D *B, POINT4D *I, double F);

void lwgeom_longitude_shift(LWGEOM *lwgeom);


/**
* @brief Check whether or not a lwgeom is big enough to warrant a bounding box.
*
* Check whether or not a lwgeom is big enough to warrant a bounding box
* when stored in the serialized form on disk. Currently only points are
* considered small enough to not require a bounding box, because the
* index operations can generate a large number of box-retrieval operations
* when scanning keys.
*/
extern int lwgeom_needs_bbox(const LWGEOM *geom);

/**
* Count the total number of vertices in any #LWGEOM.
*/
extern int lwgeom_count_vertices(const LWGEOM *geom);

/**
* Count the total number of rings in any #LWGEOM. Multipolygons
* and other collections get counted, not the same as OGC st_numrings.
*/
extern int lwgeom_count_rings(const LWGEOM *geom);

/**
* Return true or false depending on whether a geometry has
* a valid SRID set.
*/
extern int lwgeom_has_srid(const LWGEOM *geom);

/**
* Return true or false depending on whether a geometry is an "empty"
* geometry (no vertices members)
*/
extern int lwgeom_is_empty(const LWGEOM *geom);

/**
* Return true or false depending on whether a geometry is a linear
* feature that closes on itself.
*/
extern int lwgeom_is_closed(const LWGEOM *geom);

/**
* Return the dimensionality (relating to point/line/poly) of an lwgeom
*/
extern int lwgeom_dimensionality(LWGEOM *geom);

/* Is lwgeom1 geometrically equal to lwgeom2 ? */
char lwgeom_same(const LWGEOM *lwgeom1, const LWGEOM *lwgeom2);
char ptarray_same(const POINTARRAY *pa1, const POINTARRAY *pa2);
char lwpoint_same(const LWPOINT *p1, const LWPOINT *p2);
char lwline_same(const LWLINE *p1, const LWLINE *p2);
char lwpoly_same(const LWPOLY *p1, const LWPOLY *p2);
char lwtriangle_same(const LWTRIANGLE *p1, const LWTRIANGLE *p2);
char lwcollection_same(const LWCOLLECTION *p1, const LWCOLLECTION *p2);
char lwcircstring_same(const LWCIRCSTRING *p1, const LWCIRCSTRING *p2);


/**
 * @brief Clone LWGEOM object. Serialized point lists are not copied.
 *
 * #GBOX are copied
 *
 * @see ptarray_clone 
 */
extern LWGEOM *lwgeom_clone(const LWGEOM *lwgeom);

/**
* Deep clone an LWGEOM, everything is copied
*/
extern LWGEOM *lwgeom_clone_deep(const LWGEOM *lwgeom);

/* TODO Move to Internal */
LWPOINT *lwpoint_clone(const LWPOINT *lwgeom);
POINTARRAY *ptarray_clone_deep(const POINTARRAY *ptarray);


/*
* Geometry constructors. These constructors to not copy the point arrays
* passed to them, they just take references, so do not free them out
* from underneath the geometries.
*/
extern LWPOINT* lwpoint_construct(int srid, GBOX *bbox, POINTARRAY *point);
extern LWMPOINT *lwmpoint_construct(int srid, const POINTARRAY *pa);
extern LWLINE* lwline_construct(int srid, GBOX *bbox, POINTARRAY *points);
extern LWCIRCSTRING* lwcircstring_construct(int srid, GBOX *bbox, POINTARRAY *points);
extern LWPOLY* lwpoly_construct(int srid, GBOX *bbox, uint32_t nrings, POINTARRAY **points);
extern LWCURVEPOLY* lwcurvepoly_construct(int srid, GBOX *bbox, uint32_t nrings, LWGEOM **geoms);
extern LWTRIANGLE* lwtriangle_construct(int srid, GBOX *bbox, POINTARRAY *points);
extern LWCOLLECTION* lwcollection_construct(uint8_t type, int srid, GBOX *bbox, uint32_t ngeoms, LWGEOM **geoms); 
/*
* Empty geometry constructors.
*/
extern LWGEOM* lwgeom_construct_empty(uint8_t type, int srid, char hasz, char hasm);
extern LWPOINT* lwpoint_construct_empty(int srid, char hasz, char hasm);
extern LWLINE* lwline_construct_empty(int srid, char hasz, char hasm);
extern LWPOLY* lwpoly_construct_empty(int srid, char hasz, char hasm);
extern LWCURVEPOLY* lwcurvepoly_construct_empty(int srid, char hasz, char hasm);
extern LWCIRCSTRING* lwcircstring_construct_empty(int srid, char hasz, char hasm);
extern LWCOMPOUND* lwcompound_construct_empty(int srid, char hasz, char hasm);
extern LWTRIANGLE* lwtriangle_construct_empty(int srid, char hasz, char hasm);
extern LWMPOINT* lwmpoint_construct_empty(int srid, char hasz, char hasm);
extern LWMLINE* lwmline_construct_empty(int srid, char hasz, char hasm);
extern LWMPOLY* lwmpoly_construct_empty(int srid, char hasz, char hasm);
extern LWCOLLECTION* lwcollection_construct_empty(uint8_t type, int srid, char hasz, char hasm);


/* Other constructors */
extern LWPOINT *lwpoint_make2d(int srid, double x, double y);
extern LWPOINT *lwpoint_make3dz(int srid, double x, double y, double z);
extern LWPOINT *lwpoint_make3dm(int srid, double x, double y, double m);
extern LWPOINT *lwpoint_make4d(int srid, double x, double y, double z, double m);
extern LWPOINT *lwpoint_make(int srid, int hasz, int hasm, const POINT4D *p);
extern LWLINE *lwline_from_lwgeom_array(int srid, uint32_t ngeoms, LWGEOM **geoms);
extern LWLINE *lwline_from_ptarray(int srid, uint32_t npoints, LWPOINT **points); /* TODO: deprecate */
extern LWLINE *lwline_from_lwmpoint(int srid, LWMPOINT *mpoint);
extern LWLINE *lwline_addpoint(LWLINE *line, LWPOINT *point, uint32_t where);
extern LWLINE *lwline_removepoint(LWLINE *line, uint32_t which);
extern void lwline_setPoint4d(LWLINE *line, uint32_t which, POINT4D *newpoint);
extern LWPOLY *lwpoly_from_lwlines(const LWLINE *shell, uint32_t nholes, const LWLINE **holes);
extern LWTRIANGLE *lwtriangle_from_lwline(const LWLINE *shell);


/* Some point accessors */
extern double lwpoint_get_x(const LWPOINT *point);
extern double lwpoint_get_y(const LWPOINT *point);
extern double lwpoint_get_z(const LWPOINT *point);
extern double lwpoint_get_m(const LWPOINT *point);

/**
* Return SRID number
*/
extern int32_t lwgeom_get_srid(const LWGEOM *geom);

/**
* Return LWTYPE number
*/
extern uint32_t lwgeom_get_type(const LWGEOM *geom);

/**
* Return #LW_TRUE if geometry has Z ordinates
*/
extern int lwgeom_has_z(const LWGEOM *geom);

/**
* Return #LW_TRUE if geometry has M ordinates.
*/
extern int lwgeom_has_m(const LWGEOM *geom);

/**
* Return the number of dimensions (2, 3, 4) in a geometry
*/
extern int lwgeom_ndims(const LWGEOM *geom);

/*
 * Given a point, returns the location of closest point on pointarray
 * as a fraction of total length (0: first point -- 1: last point).
 *
 * If not-null, the third argument will be set to the actual distance
 * of the point from the pointarray.
 */
extern double ptarray_locate_point(const POINTARRAY *pa, const POINT4D *pt, double *dist, POINT4D *p_located);

/**
* Add a measure dimension to a line, interpolating linearly from the start 
* to the end value.
*/
extern LWLINE *lwline_measured_from_lwline(const LWLINE *lwline, double m_start, double m_end);
extern LWMLINE* lwmline_measured_from_lwmline(const LWMLINE *lwmline, double m_start, double m_end);

/**
* Determine the location(s) along a measured line where m occurs and 
* return as a multipoint. Offset to left (positive) or right (negative).
*/
extern LWGEOM* lwgeom_locate_along(const LWGEOM *lwin, double m, double offset);

/**
* Determine the segments along a measured line that fall within the m-range
* given. Return as a multiline or geometrycollection.
* Offset to left (positive) or right (negative).
*/
extern LWCOLLECTION* lwgeom_locate_between(const LWGEOM *lwin, double from, double to, double offset);

/**
* Find the measure value at the location on the line closest to the point.
*/
extern double lwgeom_interpolate_point(const LWGEOM *lwin, const LWPOINT *lwpt);

/*
 * Ensure every segment is at most 'dist' long.
 * Returned LWGEOM might is unchanged if a POINT.
 */
extern LWGEOM *lwgeom_segmentize2d(LWGEOM *line, double dist);
extern POINTARRAY *ptarray_segmentize2d(const POINTARRAY *ipa, double dist);
extern LWLINE *lwline_segmentize2d(LWLINE *line, double dist);
extern LWPOLY *lwpoly_segmentize2d(LWPOLY *line, double dist);
extern LWCOLLECTION *lwcollection_segmentize2d(LWCOLLECTION *coll, double dist);

/**
* Calculate the GeoHash (http://geohash.org) string for a geometry. Caller must free.
*/
char *lwgeom_geohash(const LWGEOM *lwgeom, int precision);
unsigned int geohash_point_as_int(POINT2D *pt);


/**
* The return values of lwline_crossing_direction()
*/
enum CG_LINE_CROSS_TYPE {
    LINE_NO_CROSS = 0,
    LINE_CROSS_LEFT = -1,
    LINE_CROSS_RIGHT = 1,
    LINE_MULTICROSS_END_LEFT = -2,
    LINE_MULTICROSS_END_RIGHT = 2,
    LINE_MULTICROSS_END_SAME_FIRST_LEFT = -3,
    LINE_MULTICROSS_END_SAME_FIRST_RIGHT = 3
};

/**
* Given two lines, characterize how (and if) they cross each other
*/
int lwline_crossing_direction(const LWLINE *l1, const LWLINE *l2);

/**
* Given a geometry clip  based on the from/to range of one of its ordinates (x, y, z, m). Use for m- and z- clipping.
*/
LWCOLLECTION* lwgeom_clip_to_ordinate_range(const LWGEOM *lwin, char ordinate, double from, double to, double offset);

/**
 * Macros for specifying GML options. 
 * @{
 */
/** For GML3 only, include srsDimension attribute in output */
#define LW_GML_IS_DIMS     (1<<0)
/** For GML3 only, declare that datas are lat/lon. Swaps axis order */
#define LW_GML_IS_DEGREE   (1<<1)
/** For GML3, use <LineString> rather than <Curve> for lines */
#define LW_GML_SHORTLINE   (1<<2)
/** For GML2 and GML3, output only extent of geometry */
#define LW_GML_EXTENT      (1<<4)


#define IS_DIMS(x) ((x) & LW_GML_IS_DIMS)
#define IS_DEGREE(x) ((x) & LW_GML_IS_DEGREE)
/** @} */

extern char* lwgeom_to_gml2(const LWGEOM *geom, const char *srs, int precision, const char *prefix);
extern char* lwgeom_extent_to_gml2(const LWGEOM *geom, const char *srs, int precision, const char *prefix);
/**
 * @param opts output options bitfield, see LW_GML macros for meaning
 */
extern char* lwgeom_extent_to_gml3(const LWGEOM *geom, const char *srs, int precision, int opts, const char *prefix);
extern char* lwgeom_to_gml3(const LWGEOM *geom, const char *srs, int precision, int opts, const char *prefix, const char *id);
extern char* lwgeom_to_kml2(const LWGEOM *geom, int precision, const char *prefix);
extern char* lwgeom_to_geojson(const LWGEOM *geo, char *srs, int precision, int has_bbox);
extern char* lwgeom_to_svg(const LWGEOM *geom, int precision, int relative);
extern char* lwgeom_to_x3d3(const LWGEOM *geom, char *srs, int precision, int opts, const char *defid);

/**
 * Create an LWGEOM object from a GeoJSON representation
 *
 * @param geojson the GeoJSON input
 * @param srs output parameter. Will be set to a newly allocated
 *            string holding the spatial reference string, or NULL
 *            if no such parameter is found in input.
 *            If not null, the pointer must be freed with lwfree.
 */
extern LWGEOM* lwgeom_from_geojson(const char *geojson, char **srs);

/**
* Initialize a spheroid object for use in geodetic functions.
*/
extern void spheroid_init(SPHEROID *s, double a, double b);

/**
* Calculate the geodetic distance from lwgeom1 to lwgeom2 on the spheroid. 
* A spheroid with major axis == minor axis will be treated as a sphere.
* Pass in a tolerance in spheroid units.
*/
extern double lwgeom_distance_spheroid(const LWGEOM *lwgeom1, const LWGEOM *lwgeom2, const SPHEROID *spheroid, double tolerance);

/**
* Calculate the location of a point on a spheroid, give a start point, bearing and distance.
*/
extern LWPOINT* lwgeom_project_spheroid(const LWPOINT *r, const SPHEROID *spheroid, double distance, double azimuth);

/**
* Derive a new geometry with vertices added to ensure no vertex is more 
* than max_seg_length (in radians) from any other vertex.
*/
extern LWGEOM* lwgeom_segmentize_sphere(const LWGEOM *lwg_in, double max_seg_length);

/**
* Calculate the bearing between two points on a spheroid.
*/
extern double lwgeom_azumith_spheroid(const LWPOINT *r, const LWPOINT *s, const SPHEROID *spheroid);

/**
* Calculate the geodetic area of a lwgeom on the sphere. The result
* will be multiplied by the average radius of the supplied spheroid.
*/
extern double lwgeom_area_sphere(const LWGEOM *lwgeom, const SPHEROID *spheroid);

/**
* Calculate the geodetic area of a lwgeom on the spheroid. The result
* will have the squared units of the spheroid axes.
*/
extern double lwgeom_area_spheroid(const LWGEOM *lwgeom, const SPHEROID *spheroid);

/**
* Calculate the geodetic length of a lwgeom on the unit sphere. The result
* will have to by multiplied by the real radius to get the real length.
*/
extern double lwgeom_length_spheroid(const LWGEOM *geom, const SPHEROID *s);

/**
* Calculate covers predicate for two lwgeoms on the sphere. Currently
* only handles point-in-polygon.
*/
extern int lwgeom_covers_lwgeom_sphere(const LWGEOM *lwgeom1, const LWGEOM *lwgeom2);

/**
* Remove repeated points!
*/
extern LWGEOM* lwgeom_remove_repeated_points(LWGEOM *in);

extern char lwtriangle_is_repeated_points(LWTRIANGLE *triangle);

/**
* Reverse the X and Y coordinate order. Useful for geometries in lat/lon order
* than need to be converted to lon/lat order.
*/
extern LWGEOM* lwgeom_flip_coordinates(LWGEOM *in);

/**
* Convert a single hex digit into the corresponding char
*/
extern uint8_t parse_hex(char *str);

/**
* Convert a char into a human readable hex digit 
*/
extern void deparse_hex(uint8_t str, char *result);



/***********************************************************************
** Functions for managing serialized forms and bounding boxes.
*/

/**
* Calculate the geocentric bounding box directly from the serialized
* form of the geodetic coordinates. Only accepts serialized geographies
* flagged as geodetic. Caller is responsible for disposing of the GBOX.
*/
extern GBOX* gserialized_calculate_gbox_geocentric(const GSERIALIZED *g);

/**
* Calculate the geocentric bounding box directly from the serialized
* form of the geodetic coordinates. Only accepts serialized geographies
* flagged as geodetic.
*/
int gserialized_calculate_gbox_geocentric_p(const GSERIALIZED *g, GBOX *g_box);

/**
* Return a WKT representation of the gserialized geometry. 
* Caller is responsible for disposing of the char*.
*/
extern char* gserialized_to_string(const GSERIALIZED *g);

/**
* Return a copy of the input serialized geometry. 
*/ 
extern GSERIALIZED* gserialized_copy(const GSERIALIZED *g);

/**
* Check that coordinates of LWGEOM are all within the geodetic range (-180, -90, 180, 90)
*/
extern int lwgeom_check_geodetic(const LWGEOM *geom);

/**
* Gently move coordinates of LWGEOM if they are close enough into geodetic range.
*/
extern int lwgeom_nudge_geodetic(LWGEOM *geom);

/**
* Force coordinates of LWGEOM into geodetic range (-180, -90, 180, 90)
*/
extern int lwgeom_force_geodetic(LWGEOM *geom);

/**
* Set the FLAGS geodetic bit on geometry an all sub-geometries and pointlists
*/
extern void lwgeom_set_geodetic(LWGEOM *geom, int value);

/**
* Calculate the geodetic bounding box for an LWGEOM. Z/M coordinates are 
* ignored for this calculation. Pass in non-null, geodetic bounding box for function
* to fill out. LWGEOM must have been built from a GSERIALIZED to provide
* double aligned point arrays.
*/
extern int lwgeom_calculate_gbox_geodetic(const LWGEOM *geom, GBOX *gbox);

/**
* Calculate the 2-4D bounding box of a geometry. Z/M coordinates are honored 
* for this calculation, though for curves they are not included in calculations
* of curvature.
*/
extern int lwgeom_calculate_gbox_cartesian(const LWGEOM *lwgeom, GBOX *gbox);

/**
* Calculate bounding box of a geometry, automatically taking into account
* whether it is cartesian or geodetic.
*/
extern int lwgeom_calculate_gbox(const LWGEOM *lwgeom, GBOX *gbox);

/**
* New function to read doubles directly from the double* coordinate array
* of an aligned lwgeom #POINTARRAY (built by de-serializing a #GSERIALIZED).
*/
extern int getPoint2d_p_ro(const POINTARRAY *pa, int n, POINT2D **point);

/**
* Calculate geodetic (x/y/z) box and add values to gbox. Return #LW_SUCCESS on success.
*/
extern int ptarray_calculate_gbox_geodetic(const POINTARRAY *pa, GBOX *gbox);

/**
* Calculate box (x/y) and add values to gbox. Return #LW_SUCCESS on success.
*/
extern int ptarray_calculate_gbox_cartesian(const POINTARRAY *pa, GBOX *gbox );

/**
* Calculate a spherical point that falls outside the geocentric gbox
*/
void gbox_pt_outside(const GBOX *gbox, POINT2D *pt_outside);

/**
* Create a new gbox with the dimensionality indicated by the flags. Caller
* is responsible for freeing.
*/
extern GBOX* gbox_new(uint8_t flags);

/**
* Zero out all the entries in the #GBOX. Useful for cleaning
* statically allocated gboxes.
*/
extern void gbox_init(GBOX *gbox);

/**
* Update the merged #GBOX to be large enough to include itself and the new box.
*/
extern int gbox_merge(const GBOX *new_box, GBOX *merged_box);

/**
* Update the output #GBOX to be large enough to include both inputs.
*/
extern int gbox_union(const GBOX *g1, const GBOX *g2, GBOX *gout);

/**
* Move the box minimums down and the maximums up by the distance provided.
*/
extern void gbox_expand(GBOX *g, double d);

/**
* Initialize a #GBOX using the values of the point.
*/
extern int gbox_init_point3d(const POINT3D *p, GBOX *gbox);

/**
* Update the #GBOX to be large enough to include itself and the new point.
*/
extern int gbox_merge_point3d(const POINT3D *p, GBOX *gbox);

/**
* Return true if the point is inside the gbox
*/
extern int gbox_contains_point3d(const GBOX *gbox, const POINT3D *pt);

/**
* Allocate a string representation of the #GBOX, based on dimensionality of flags.
*/
extern char* gbox_to_string(const GBOX *gbox);

/**
* Return a copy of the #GBOX, based on dimensionality of flags.
*/
extern GBOX* gbox_copy(const GBOX *gbox);

/**
* Warning, do not use this function, it is very particular about inputs.
*/
extern GBOX* gbox_from_string(const char *str);

/**
* Return #LW_TRUE if the #GBOX overlaps, #LW_FALSE otherwise. 
*/
extern int gbox_overlaps(const GBOX *g1, const GBOX *g2);

/**
* Return #LW_TRUE if the #GBOX overlaps on the 2d plane, #LW_FALSE otherwise. 
*/
extern int gbox_overlaps_2d(const GBOX *g1, const GBOX *g2);

/**
* Copy the values of original #GBOX into duplicate.
*/
extern void gbox_duplicate(const GBOX *original, GBOX *duplicate);

/**
* Return the number of bytes necessary to hold a #GBOX of this dimension in 
* serialized form.
*/
extern size_t gbox_serialized_size(uint8_t flags);

/**
* Check if 2 given Gbox are the same
*/
extern int gbox_same(const GBOX *g1, const GBOX *g2);

/**
 * Round given GBOX to float boundaries
 *
 * This turns a GBOX into the version it would become
 * after a serialize/deserialize round trip.
 */
extern void gbox_float_round(GBOX *gbox);

/**
* Return false if any of the dimensions is NaN or infinite
*/
extern int gbox_is_valid(const GBOX *gbox);

/**
* Utility function to get type number from string. For example, a string 'POINTZ' 
* would return type of 1 and z of 1 and m of 0. Valid 
*/
extern int geometry_type_from_string(const char *str, uint8_t *type, int *z, int *m);

/**
* Calculate required memory segment to contain a serialized form of the LWGEOM.
* Primarily used internally by the serialization code. Exposed to allow the cunit
* tests to exercise it.
*/
extern size_t gserialized_from_lwgeom_size(const LWGEOM *geom);

/**
* Allocate a new #GSERIALIZED from an #LWGEOM. For all non-point types, a bounding
* box will be calculated and embedded in the serialization. The geodetic flag is used
* to control the box calculation (cartesian or geocentric). If set, the size pointer
* will contain the size of the final output, which is useful for setting the PgSQL 
* VARSIZE information.
*/
extern GSERIALIZED* gserialized_from_lwgeom(LWGEOM *geom, int is_geodetic, size_t *size);

/**
* Allocate a new #LWGEOM from a #GSERIALIZED. The resulting #LWGEOM will have coordinates
* that are double aligned and suitable for direct reading using getPoint2d_p_ro
*/
extern LWGEOM* lwgeom_from_gserialized(const GSERIALIZED *g);

/**
* Pull a #GBOX from the header of a #GSERIALIZED, if one is available. If
* it is not, calculate it from the geometry. If that doesn't work (null
* or empty) return LW_FAILURE.
*/
extern int gserialized_get_gbox_p(const GSERIALIZED *g, GBOX *gbox);


/**
 * Parser check flags
 * 
 *  @see lwgeom_from_wkb
 *  @see lwgeom_from_hexwkb
 *  @see lwgeom_parse_wkt
 */
#define LW_PARSER_CHECK_MINPOINTS  1
#define LW_PARSER_CHECK_ODD        2
#define LW_PARSER_CHECK_CLOSURE    4
#define LW_PARSER_CHECK_ZCLOSURE   8

#define LW_PARSER_CHECK_NONE   0
#define LW_PARSER_CHECK_ALL	(LW_PARSER_CHECK_MINPOINTS | LW_PARSER_CHECK_ODD | LW_PARSER_CHECK_CLOSURE)

/**
 * Parser result structure: returns the result of attempting to convert
 * (E)WKT/(E)WKB to LWGEOM
 */
typedef struct struct_lwgeom_parser_result
{
	const char *wkinput;        /* Copy of pointer to input WKT/WKB */
	uint8_t *serialized_lwgeom;   /* Pointer to serialized LWGEOM */
	int size;                   /* Size of serialized LWGEOM in bytes */
	LWGEOM *geom;               /* Pointer to LWGEOM struct */
	const char *message;        /* Error/warning message */
	int errcode;                /* Error/warning number */
	int errlocation;            /* Location of error */
	int parser_check_flags;     /* Bitmask of validity checks run during this parse */
}
LWGEOM_PARSER_RESULT;

/*
 * Parser error messages (these must match the message array in lwgparse.c)
 */
#define PARSER_ERROR_MOREPOINTS     1
#define PARSER_ERROR_ODDPOINTS      2
#define PARSER_ERROR_UNCLOSED       3
#define PARSER_ERROR_MIXDIMS        4
#define PARSER_ERROR_INVALIDGEOM    5
#define PARSER_ERROR_INVALIDWKBTYPE 6
#define PARSER_ERROR_INCONTINUOUS   7
#define PARSER_ERROR_TRIANGLEPOINTS 8
#define PARSER_ERROR_LESSPOINTS     9
#define PARSER_ERROR_OTHER          10



/*
 * Unparser result structure: returns the result of attempting to convert LWGEOM to (E)WKT/(E)WKB
 */
typedef struct struct_lwgeom_unparser_result
{
	uint8_t *serialized_lwgeom;	/* Copy of pointer to input serialized LWGEOM */
	char *wkoutput;			/* Pointer to WKT or WKB output */
	int size;			/* Size of serialized LWGEOM in bytes */
	const char *message;		/* Error/warning message */
	int errlocation;		/* Location of error */
}
LWGEOM_UNPARSER_RESULT;

/*
 * Unparser error messages (these must match the message array in lwgunparse.c)
 */
#define UNPARSER_ERROR_MOREPOINTS 	1
#define UNPARSER_ERROR_ODDPOINTS	2
#define UNPARSER_ERROR_UNCLOSED		3


/*
** Variants available for WKB and WKT output types
*/

#define WKB_ISO 0x01
#define WKB_SFSQL 0x02
#define WKB_EXTENDED 0x04
#define WKB_NDR 0x08
#define WKB_XDR 0x10
#define WKB_HEX 0x20
#define WKB_NO_NPOINTS 0x40 /* Internal use only */
#define WKB_NO_SRID 0x80 /* Internal use only */

#define WKT_ISO 0x01
#define WKT_SFSQL 0x02
#define WKT_EXTENDED 0x04

/*
** New parsing and unparsing functions.
*/

/**
* @param lwgeom geometry to convert to WKT
* @param variant output format to use (WKT_ISO, WKT_SFSQL, WKT_EXTENDED)
*/
extern char*   lwgeom_to_wkt(const LWGEOM *geom, uint8_t variant, int precision, size_t *size_out);

/**
* @param lwgeom geometry to convert to WKT
* @param variant output format to use
*                (WKB_ISO, WKB_SFSQL, WKB_EXTENDED, WKB_NDR, WKB_XDR)
*/
extern uint8_t*  lwgeom_to_wkb(const LWGEOM *geom, uint8_t variant, size_t *size_out);

/**
* @param lwgeom geometry to convert to HEXWKB
* @param variant output format to use
*                (WKB_ISO, WKB_SFSQL, WKB_EXTENDED, WKB_NDR, WKB_XDR)
*/
extern char*   lwgeom_to_hexwkb(const LWGEOM *geom, uint8_t variant, size_t *size_out);


/**
* @param lwgeom geometry to convert to EWKT
*/
extern char *lwgeom_to_ewkt(const LWGEOM *lwgeom);

/**
 * @param check parser check flags, see LW_PARSER_CHECK_* macros
 */
extern LWGEOM* lwgeom_from_wkb(const uint8_t *wkb, const size_t wkb_size, const char check);

/**
 * @param check parser check flags, see LW_PARSER_CHECK_* macros
 */
extern LWGEOM* lwgeom_from_wkt(const char *wkt, const char check);

/**
 * @param check parser check flags, see LW_PARSER_CHECK_* macros
 */
extern LWGEOM* lwgeom_from_hexwkb(const char *hexwkb, const char check);

extern uint8_t*  bytes_from_hexbytes(const char *hexbuf, size_t hexsize);

extern char*   hexbytes_from_bytes(uint8_t *bytes, size_t size);

/*
* WKT detailed parsing support
*/
extern int lwgeom_parse_wkt(LWGEOM_PARSER_RESULT *parser_result, char *wktstr, int parse_flags);
void lwgeom_parser_result_init(LWGEOM_PARSER_RESULT *parser_result);
void lwgeom_parser_result_free(LWGEOM_PARSER_RESULT *parser_result);


/* Memory management */
extern void *lwalloc(size_t size);
extern void *lwrealloc(void *mem, size_t size);
extern void lwfree(void *mem);

/* Utilities */
extern char *lwmessage_truncate(char *str, int startpos, int endpos, int maxlength, int truncdirection);

#ifndef HAVE_STRCASESTR
extern char *strcasestr(const char *s, const char *find);
#endif

/*******************************************************************************
 * SQLMM internal functions - TODO: Move into separate header files
 ******************************************************************************/

int lwgeom_has_arc(const LWGEOM *geom);
LWGEOM *lwgeom_segmentize(LWGEOM *geom, uint32_t perQuad);
LWGEOM *lwgeom_desegmentize(LWGEOM *geom);

/*******************************************************************************
 * GEOS proxy functions on LWGEOM
 ******************************************************************************/

/** Return GEOS version string (not to be freed) */
const char* lwgeom_geos_version(void);

/** Convert an LWGEOM to a GEOS Geometry and convert back -- for debug only */
LWGEOM* lwgeom_geos_noop(const LWGEOM *geom) ;

LWGEOM *lwgeom_normalize(const LWGEOM *geom);
LWGEOM *lwgeom_intersection(const LWGEOM *geom1, const LWGEOM *geom2);
LWGEOM *lwgeom_difference(const LWGEOM *geom1, const LWGEOM *geom2);
LWGEOM *lwgeom_symdifference(const LWGEOM* geom1, const LWGEOM* geom2);
LWGEOM *lwgeom_union(const LWGEOM *geom1, const LWGEOM *geom2);

/**
 * Snap vertices and segments of a geometry to another using a given tolerance.
 *
 * @param geom1 the geometry to snap
 * @param geom2 the geometry to snap to
 * @param tolerance the distance under which vertices and segments are snapped
 * 
 * Requires GEOS-3.3.0+
 */
LWGEOM* lwgeom_snap(const LWGEOM* geom1, const LWGEOM* geom2, double tolerance);

/*
 * Return the set of paths shared between two linear geometries,
 * and their direction (same or opposite).
 *
 * @param geom1 a lineal geometry
 * @param geom2 another lineal geometry
 *
 * Requires GEOS-3.3.0+
 */
LWGEOM* lwgeom_sharedpaths(const LWGEOM* geom1, const LWGEOM* geom2);

/*
 * An offset curve against the input line.
 *
 * @param lwline a lineal geometry
 * @param size offset distance. Offset left if negative and right if positive
 * @param quadsegs number of quadrature segments in curves (try 8)
 * @param joinStyle (1 = round, 2 = mitre, 3 = bevel)
 * @param mitreLimit (try 5.0)
 * @return derived geometry (linestring or multilinestring)
 *
 * Requires GEOS-3.2.0+
 */
LWGEOM* lwgeom_offsetcurve(const LWLINE *lwline, double size, int quadsegs, int joinStyle, double mitreLimit);


/*******************************************************************************
 * PROJ4-dependent extra functions on LWGEOM
 ******************************************************************************/

/**
 * Get a projection from a string representation
 *
 * Eg: "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"
 */
projPJ lwproj_from_string(const char* txt);

/**
 * Transform (reproject) a geometry in-place.
 * @param geom the geometry to transform
 * @param inpj the input (or current, or source) projection
 * @param outpj the output (or destination) projection
 */
int lwgeom_transform(LWGEOM *geom, projPJ inpj, projPJ outpj) ;
int ptarray_transform(POINTARRAY *geom, projPJ inpj, projPJ outpj) ;
int point4d_transform(POINT4D *pt, projPJ srcpj, projPJ dstpj) ;


/*******************************************************************************
 * GEOS-dependent extra functions on LWGEOM
 ******************************************************************************/

/**
 * Take a geometry and return an areal geometry
 * (Polygon or MultiPolygon).
 * Actually a wrapper around GEOSpolygonize,
 * transforming the resulting collection into
 * a valid polygon Geometry.
 */
LWGEOM* lwgeom_buildarea(const LWGEOM *geom) ;


/**
 * Attempts to make an invalid geometries valid w/out losing points.
 *
 * NOTE: this is only available when liblwgeom is built against
 *       GEOS 3.3.0 or higher
 */
LWGEOM* lwgeom_make_valid(LWGEOM* geom);

/*
 * Split polygon by line, line by line, line by point.
 *
 * Returns all components as a collection.
 * First element of the collection is always the part which
 * remains after the cut, while the second element is the
 * part which has been cut out. We arbitrarely take the part
 * on the *right* of cut lines as the part which has been cut out.
 * For a line cut by a point the part which remains is the one
 * from start of the line to the cut point.
 */
LWGEOM* lwgeom_split(const LWGEOM* lwgeom_in, const LWGEOM* blade_in);

/*
 * Fully node a set of linestrings, using the least nodes preserving
 * all the input ones.
 *
 * Requires GEOS-3.3.0 or higher
 */
LWGEOM* lwgeom_node(const LWGEOM* lwgeom_in);

/**
 * Take vertices of a geometry and build a delaunay
 * triangulation on them.
 *
 * @param geom the input geometry
 * @param tolerance an optional snapping tolerance for improved tolerance
 * @param edgeOnly if non-zero the result will be a MULTILINESTRING,
 *                 otherwise it'll be a COLLECTION of polygons.
 */
LWGEOM* lwgeom_delaunay_triangulation(const LWGEOM *geom, double tolerance, int edgeOnly);

#endif /* !defined _LIBLWGEOM_H  */

