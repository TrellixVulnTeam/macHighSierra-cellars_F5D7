# Compute locations from <prefix>/@{LIBRARY_DIR@/cmake/lapacke-<v>/<self>.cmake
get_filename_component(_LAPACKE_SELF_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(_LAPACKE_PREFIX "${_LAPACKE_SELF_DIR}" PATH)
get_filename_component(_LAPACKE_PREFIX "${_LAPACKE_PREFIX}" PATH)
get_filename_component(_LAPACKE_PREFIX "${_LAPACKE_PREFIX}" PATH)

# Load the LAPACK package with which we were built.
set(LAPACK_DIR "${_LAPACKE_PREFIX}/@{LIBRARY_DIRLAPACK_VERSION@")
find_package(LAPACK NO_MODULE)

# Load lapacke targets from the install tree.
if(NOT TARGET lapacke)
  include(${_LAPACKE_SELF_DIR}/lapacke-targets.cmake)
endif()

# Report lapacke header search locations.
set(LAPACKE_INCLUDE_DIRS ${_LAPACKE_PREFIX}/include)

# Report lapacke libraries.
set(LAPACKE_LIBRARIES lapacke)

unset(_LAPACKE_PREFIX)
unset(_LAPACKE_SELF_DIR)
