if(NOT Julia_FOUND)
    # Find julia executable
    find_program(Julia_EXECUTABLE julia DOC "Julia executable")

    if(Julia_EXECUTABLE)
        #
        # Julia version
        #
        execute_process(
            COMMAND ${Julia_EXECUTABLE} --version
            OUTPUT_VARIABLE Julia_VERSION_STRING
            RESULT_VARIABLE RESULT
        )
        if(RESULT EQUAL 0)
          string(REGEX REPLACE ".*([0-9]+\\.[0-9]+\\.[0-9]+).*" "\\1"
              Julia_VERSION_STRING ${Julia_VERSION_STRING})
        endif()


        #
        # Julia includes
        #
        execute_process(
	        COMMAND ${Julia_EXECUTABLE} -E "joinpath(match(r\"(.*)(bin)\",JULIA_HOME).captures[1],\"include\",\"julia\")"
            OUTPUT_VARIABLE Julia_INCLUDE_DIRS
            # COMMAND ${Julia_EXECUTABLE} -E "abspath(joinpath(JULIA_HOME, \"../..\", \"src\"))"
            # OUTPUT_VARIABLE Julia_INCLUDE_DIRS
            RESULT_VARIABLE RESULT
        )
        if(RESULT EQUAL 0)
            string(REGEX REPLACE "\"" "" Julia_INCLUDE_DIRS ${Julia_INCLUDE_DIRS})
            set(Julia_INCLUDE_DIRS ${Julia_INCLUDE_DIRS}
                CACHE PATH "Location of Julia include files")
        endif()

        #
        # sysimg.jl
        #
        execute_process(
	        COMMAND ${Julia_EXECUTABLE} -E "joinpath(match(r\"(.*)(bin)\",JULIA_HOME).captures[1],\"share\",\"julia\",\"base\",\"sysimg.jl\")"
            OUTPUT_VARIABLE Julia_SYSIMG
            RESULT_VARIABLE RESULT
        )
        if(RESULT EQUAL 0)
            set(Julia_SYSIMG ${Julia_SYSIMG}
                CACHE PATH "Julia sysimg location")            
        endif()
        
        #
        # Julia library location
        #
        execute_process(
            COMMAND ${Julia_EXECUTABLE} -E "abspath(dirname(Sys.dlpath(\"libjulia\")))"
            OUTPUT_VARIABLE Julia_LIBRARY_DIRS
            RESULT_VARIABLE RESULT
        )
        if(RESULT EQUAL 0)
            string(REGEX REPLACE "\"" "" Julia_LIBRARY_DIRS ${Julia_LIBRARY_DIRS})
            set(Julia_LIBRARY_DIRS ${Julia_LIBRARY_DIRS}
                CACHE PATH "Julia library location")
        endif()

        #
        # Julia library
        #
        execute_process(
            COMMAND ${Julia_EXECUTABLE} -E "abspath(Sys.dlpath(\"libjulia\"))"
            OUTPUT_VARIABLE Julia_LIBRARIES
            RESULT_VARIABLE RESULT
        )
        if(RESULT EQUAL 0)
            string(REGEX REPLACE "\"" "" Julia_LIBRARIES ${Julia_LIBRARIES})
            string(REGEX REPLACE " " "" Julia_LIBRARIES ${Julia_LIBRARIES})
            set(Julia_LIBRARIES ${Julia_LIBRARIES}
                CACHE PATH "Julia library")
        endif()

        set(Julia_FOUND TRUE CACHE INTERNAL "Julia found")
    endif()

    include(FindPackageHandleStandardArgs)
    find_package_handle_standard_args(
        Julia
        REQUIRED_VARS   Julia_INCLUDE_DIRS Julia_LIBRARY_DIRS Julia_LIBRARIES Julia_SYSIMG
        VERSION_VAR     Julia_VERSION_STRING
        FAIL_MESSAGE    "Julia not found"
    )
endif()
