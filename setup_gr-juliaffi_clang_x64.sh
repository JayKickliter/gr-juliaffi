#!/usr/bin/env bash
rm -rf build
mkdir -p build
cd build

# sed s/c++0x/c++11/ < ../CMakeLists.txt > ../CMakeLists_new.txt 

# export CC_PRINT_OPTIONS='YES'
# export CC_PRINT_OPTIONS_FILE='../.CC_PRINT_OPTIONS'
# export CPATH='/opt/local/include'
# export LIBRARY_PATH='/opt/local/lib'
# export MACOSX_DEPLOYMENT_TARGET='10.10'
# export CC='/usr/bin/clang'
# export CC_PRINT_OPTIONS='YES'
# export CC_PRINT_OPTIONS_FILE='/opt/local/var/macports/build/_opt_local_var_macports_sources_rsync.macports.org_release_tarballs_ports_science_gr-ieee802-15-4/gr-ieee802-15-4/work/.CC_PRINT_OPTIONS'
# export CFLAGS='-pipe -Os -arch x86_64'
# export CPATH='/opt/local/include'
# export CPPFLAGS='-I/opt/local/include'
# export CXX='/usr/bin/clang++'
# export CXXFLAGS='-pipe -Os -arch x86_64 -stdlib=libc++'
# export F77FLAGS='-m64'
# export F90FLAGS='-pipe -Os -m64'
# export FCFLAGS='-pipe -Os -m64'
# export FFLAGS='-pipe -Os'
# export INSTALL='/usr/bin/install -c'
# export LDFLAGS='-Wl,-headerpad_max_install_names -arch x86_64'
# export LIBRARY_PATH='/opt/local/lib'
# export MACOSX_DEPLOYMENT_TARGET='10.10'
# export OBJC='/usr/bin/clang'
# export OBJCFLAGS='-pipe -Os -arch x86_64'
# export OBJCXX='/usr/bin/clang++'
# export OBJCXXFLAGS='-pipe -Os -arch x86_64 -stdlib=libc++'
# -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON \
# -DCMAKE_INSTALL_RPATH=/opt/local/lib \
# -DCMAKE_INSTALL_NAME_DIR=/opt/local/lib \

cmake \
-DCMAKE_CXX_COMPILER="/usr/bin/clang++" \
-DCMAKE_INSTALL_PREFIX=/opt/local \
-DCMAKE_VERBOSE_MAKEFILE=ON \
-DCMAKE_COLOR_MAKEFILE=ON \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_SYSTEM_PREFIX_PATH="/opt/local;/usr" \
-DCMAKE_INSTALL_RPATH_USE_LINK_PATH=TRUE \
-DCMAKE_MODULE_PATH=/opt/local/share/cmake/Modules \
-DCMAKE_FIND_FRAMEWORK=LAST \
-Wno-dev \
-DPYTHON_EXECUTABLE=/opt/local/bin/python2.7 \
-DPYTHON_INCLUDE_DIR=/opt/local/Library/Frameworks/Python.framework/Versions/2.7/Headers \
-DPYTHON_LIBRARY=/opt/local/Library/Frameworks/Python.framework/Versions/2.7/Python \
-DGR_PYTHON_DIR=/opt/local/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages \
-DCMAKE_C_FLAGS_RELEASE="-DNDEBUG" \
-DCMAKE_CXX_FLAGS_RELEASE="-DNDEBUG" \
-DCMAKE_OSX_ARCHITECTURES="x86_64" \
-DCMAKE_OSX_DEPLOYMENT_TARGET="10.10" \
-DCMAKE_OSX_SYSROOT="/" \
../

# set CC_PRINT_OPTIONS='YES'
# set CC_PRINT_OPTIONS_FILE='/opt/local/var/macports/build/_opt_local_var_macports_sources_rsync.macports.org_release_tarballs_ports_science_gr-ieee802-15-4/gr-ieee802-15-4/work/.CC_PRINT_OPTIONS'
# set CPATH='/opt/local/include'
# set LIBRARY_PATH='/opt/local/lib'
# set MACOSX_DEPLOYMENT_TARGET='10.10'
# /usr/bin/make -j8 -w all VERBOSE=ON
# make -j2 VERBOSE=ON > m_j2_o.txt 2>&1