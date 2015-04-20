if(JULIA_FOUND)
    return()
endif()
    
# Find julia executable
find_program(JULIA_EXECUTABLE julia DOC "Julia executable")

if(NOT JULIA_EXECUTABLE)
    return()
endif()


#
# Julia version
#
execute_process(
    COMMAND ${JULIA_EXECUTABLE} --version
    OUTPUT_VARIABLE JULIA_VERSION_STRING
    RESULT_VARIABLE RESULT
)
if(RESULT EQUAL 0)
  string(REGEX REPLACE ".*([0-9]+\\.[0-9]+\\.[0-9]+).*" "\\1"
      JULIA_VERSION_STRING ${JULIA_VERSION_STRING})
endif()


#
# Julia Home
#
execute_process(
    COMMAND ${JULIA_EXECUTABLE} -E "JULIA_HOME"
    OUTPUT_VARIABLE JULIA_HOME
    RESULT_VARIABLE RESULT
)
if(RESULT EQUAL 0)
  # string(REGEX REPLACE "\"" "" JULIA_HOME ${JULIA_HOME})
  string(STRIP ${JULIA_HOME} JULIA_HOME)
  set(JULIA_HOME ${JULIA_HOME}
      CACHE PATH "Julia executable directory")
endif()


#
# Julia includes
#
execute_process(
    COMMAND ${JULIA_EXECUTABLE} -E "joinpath(match(r\"(.*)(bin)\",JULIA_HOME).captures[1],\"include\",\"julia\")"
    OUTPUT_VARIABLE JULIA_INCLUDE_DIRS
    RESULT_VARIABLE RESULT
)
if(RESULT EQUAL 0)
    string(REGEX REPLACE "\"" "" JULIA_INCLUDE_DIRS ${JULIA_INCLUDE_DIRS})
    set(JULIA_INCLUDE_DIRS ${JULIA_INCLUDE_DIRS}
        CACHE PATH "Location of Julia include files")
endif()


#
# Julia library location
#
execute_process(
    COMMAND ${JULIA_EXECUTABLE} -E "abspath(dirname(Sys.dlpath(\"libjulia\")))"
    OUTPUT_VARIABLE JULIA_LIBRARY_DIR
    RESULT_VARIABLE RESULT
)
if(RESULT EQUAL 0)
    string(REGEX REPLACE "\"" "" JULIA_LIBRARY_DIR ${JULIA_LIBRARY_DIR})
    string(STRIP ${JULIA_LIBRARY_DIR} JULIA_LIBRARY_DIR)
    set(JULIA_LIBRARY_DIR ${JULIA_LIBRARY_DIR}
        CACHE PATH "Julia library directory")
endif()

find_library( JULIA_LIBRARY
    NAMES julia
    PATHS ${JULIA_LIBRARY_DIR}
)


include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
    Julia
    REQUIRED_VARS   JULIA_LIBRARY JULIA_LIBRARY_DIR JULIA_INCLUDE_DIRS JULIA_HOME
    VERSION_VAR     JULIA_VERSION_STRING
    FAIL_MESSAGE    "Julia not found"
)