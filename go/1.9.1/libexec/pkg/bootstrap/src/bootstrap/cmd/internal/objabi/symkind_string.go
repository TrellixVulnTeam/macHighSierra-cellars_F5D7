// Do not edit. Bootstrap copy of /private/tmp/go-20171004-32030-1lwkjbw/go/src/cmd/internal/objabi/symkind_string.go

//line /private/tmp/go-20171004-32030-1lwkjbw/go/src/cmd/internal/objabi/symkind_string.go:1
// Code generated by "stringer -type=SymKind"; DO NOT EDIT.

package objabi

import "fmt"

const _SymKind_name = "SxxxSTEXTSRODATASNOPTRDATASDATASBSSSNOPTRBSSSTLSBSSSDWARFINFOSDWARFRANGE"

var _SymKind_index = [...]uint8{0, 4, 9, 16, 26, 31, 35, 44, 51, 61, 72}

func (i SymKind) String() string {
	if i >= SymKind(len(_SymKind_index)-1) {
		return fmt.Sprintf("SymKind(%d)", i)
	}
	return _SymKind_name[_SymKind_index[i]:_SymKind_index[i+1]]
}
