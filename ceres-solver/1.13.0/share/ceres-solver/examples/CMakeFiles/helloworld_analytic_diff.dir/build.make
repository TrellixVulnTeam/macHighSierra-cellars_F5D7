# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.9

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Produce verbose output by default.
VERBOSE = 1

# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/Cellar/cmake/3.9.2/bin/cmake

# The command to remove a file.
RM = /usr/local/Cellar/cmake/3.9.2/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /tmp/ceres-solver-20170912-1210-a255xh/ceres-solver-1.13.0

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /tmp/ceres-solver-20170912-1210-a255xh/ceres-solver-1.13.0

# Include any dependencies generated for this target.
include examples/CMakeFiles/helloworld_analytic_diff.dir/depend.make

# Include the progress variables for this target.
include examples/CMakeFiles/helloworld_analytic_diff.dir/progress.make

# Include the compile flags for this target's objects.
include examples/CMakeFiles/helloworld_analytic_diff.dir/flags.make

examples/CMakeFiles/helloworld_analytic_diff.dir/helloworld_analytic_diff.cc.o: examples/CMakeFiles/helloworld_analytic_diff.dir/flags.make
examples/CMakeFiles/helloworld_analytic_diff.dir/helloworld_analytic_diff.cc.o: examples/helloworld_analytic_diff.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/tmp/ceres-solver-20170912-1210-a255xh/ceres-solver-1.13.0/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object examples/CMakeFiles/helloworld_analytic_diff.dir/helloworld_analytic_diff.cc.o"
	cd /tmp/ceres-solver-20170912-1210-a255xh/ceres-solver-1.13.0/examples && /usr/local/Homebrew/Library/Homebrew/shims/super/clang++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/helloworld_analytic_diff.dir/helloworld_analytic_diff.cc.o -c /tmp/ceres-solver-20170912-1210-a255xh/ceres-solver-1.13.0/examples/helloworld_analytic_diff.cc

examples/CMakeFiles/helloworld_analytic_diff.dir/helloworld_analytic_diff.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/helloworld_analytic_diff.dir/helloworld_analytic_diff.cc.i"
	cd /tmp/ceres-solver-20170912-1210-a255xh/ceres-solver-1.13.0/examples && /usr/local/Homebrew/Library/Homebrew/shims/super/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /tmp/ceres-solver-20170912-1210-a255xh/ceres-solver-1.13.0/examples/helloworld_analytic_diff.cc > CMakeFiles/helloworld_analytic_diff.dir/helloworld_analytic_diff.cc.i

examples/CMakeFiles/helloworld_analytic_diff.dir/helloworld_analytic_diff.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/helloworld_analytic_diff.dir/helloworld_analytic_diff.cc.s"
	cd /tmp/ceres-solver-20170912-1210-a255xh/ceres-solver-1.13.0/examples && /usr/local/Homebrew/Library/Homebrew/shims/super/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /tmp/ceres-solver-20170912-1210-a255xh/ceres-solver-1.13.0/examples/helloworld_analytic_diff.cc -o CMakeFiles/helloworld_analytic_diff.dir/helloworld_analytic_diff.cc.s

examples/CMakeFiles/helloworld_analytic_diff.dir/helloworld_analytic_diff.cc.o.requires:

.PHONY : examples/CMakeFiles/helloworld_analytic_diff.dir/helloworld_analytic_diff.cc.o.requires

examples/CMakeFiles/helloworld_analytic_diff.dir/helloworld_analytic_diff.cc.o.provides: examples/CMakeFiles/helloworld_analytic_diff.dir/helloworld_analytic_diff.cc.o.requires
	$(MAKE) -f examples/CMakeFiles/helloworld_analytic_diff.dir/build.make examples/CMakeFiles/helloworld_analytic_diff.dir/helloworld_analytic_diff.cc.o.provides.build
.PHONY : examples/CMakeFiles/helloworld_analytic_diff.dir/helloworld_analytic_diff.cc.o.provides

examples/CMakeFiles/helloworld_analytic_diff.dir/helloworld_analytic_diff.cc.o.provides.build: examples/CMakeFiles/helloworld_analytic_diff.dir/helloworld_analytic_diff.cc.o


# Object files for target helloworld_analytic_diff
helloworld_analytic_diff_OBJECTS = \
"CMakeFiles/helloworld_analytic_diff.dir/helloworld_analytic_diff.cc.o"

# External object files for target helloworld_analytic_diff
helloworld_analytic_diff_EXTERNAL_OBJECTS =

bin/helloworld_analytic_diff: examples/CMakeFiles/helloworld_analytic_diff.dir/helloworld_analytic_diff.cc.o
bin/helloworld_analytic_diff: examples/CMakeFiles/helloworld_analytic_diff.dir/build.make
bin/helloworld_analytic_diff: lib/libceres.1.13.0.dylib
bin/helloworld_analytic_diff: /usr/local/lib/libglog.dylib
bin/helloworld_analytic_diff: /usr/local/lib/libgflags.2.2.1.dylib
bin/helloworld_analytic_diff: examples/CMakeFiles/helloworld_analytic_diff.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/tmp/ceres-solver-20170912-1210-a255xh/ceres-solver-1.13.0/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ../bin/helloworld_analytic_diff"
	cd /tmp/ceres-solver-20170912-1210-a255xh/ceres-solver-1.13.0/examples && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/helloworld_analytic_diff.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
examples/CMakeFiles/helloworld_analytic_diff.dir/build: bin/helloworld_analytic_diff

.PHONY : examples/CMakeFiles/helloworld_analytic_diff.dir/build

examples/CMakeFiles/helloworld_analytic_diff.dir/requires: examples/CMakeFiles/helloworld_analytic_diff.dir/helloworld_analytic_diff.cc.o.requires

.PHONY : examples/CMakeFiles/helloworld_analytic_diff.dir/requires

examples/CMakeFiles/helloworld_analytic_diff.dir/clean:
	cd /tmp/ceres-solver-20170912-1210-a255xh/ceres-solver-1.13.0/examples && $(CMAKE_COMMAND) -P CMakeFiles/helloworld_analytic_diff.dir/cmake_clean.cmake
.PHONY : examples/CMakeFiles/helloworld_analytic_diff.dir/clean

examples/CMakeFiles/helloworld_analytic_diff.dir/depend:
	cd /tmp/ceres-solver-20170912-1210-a255xh/ceres-solver-1.13.0 && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /tmp/ceres-solver-20170912-1210-a255xh/ceres-solver-1.13.0 /tmp/ceres-solver-20170912-1210-a255xh/ceres-solver-1.13.0/examples /tmp/ceres-solver-20170912-1210-a255xh/ceres-solver-1.13.0 /tmp/ceres-solver-20170912-1210-a255xh/ceres-solver-1.13.0/examples /tmp/ceres-solver-20170912-1210-a255xh/ceres-solver-1.13.0/examples/CMakeFiles/helloworld_analytic_diff.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : examples/CMakeFiles/helloworld_analytic_diff.dir/depend

