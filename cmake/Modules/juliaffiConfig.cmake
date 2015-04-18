INCLUDE(FindPkgConfig)
PKG_CHECK_MODULES(PC_JULIAFFI juliaffi)

FIND_PATH(
    JULIAFFI_INCLUDE_DIRS
    NAMES juliaffi/api.h
    HINTS $ENV{JULIAFFI_DIR}/include
        ${PC_JULIAFFI_INCLUDEDIR}
    PATHS ${CMAKE_INSTALL_PREFIX}/include
          /usr/local/include
          /usr/include
)

FIND_LIBRARY(
    JULIAFFI_LIBRARIES
    NAMES gnuradio-juliaffi
    HINTS $ENV{JULIAFFI_DIR}/lib
        ${PC_JULIAFFI_LIBDIR}
    PATHS ${CMAKE_INSTALL_PREFIX}/lib
          ${CMAKE_INSTALL_PREFIX}/lib64
          /usr/local/lib
          /usr/local/lib64
          /usr/lib
          /usr/lib64
)

INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(JULIAFFI DEFAULT_MSG JULIAFFI_LIBRARIES JULIAFFI_INCLUDE_DIRS)
MARK_AS_ADVANCED(JULIAFFI_LIBRARIES JULIAFFI_INCLUDE_DIRS)

