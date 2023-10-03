ExternalProject_Add(libssh
    DEPENDS
        zlib
        mbedtls
    GIT_REPOSITORY https://git.libssh.org/projects/libssh.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--filter=tree:0"
    UPDATE_COMMAND ""
    PATCH_COMMAND ${EXEC} git am --3way ${CMAKE_CURRENT_SOURCE_DIR}/libssh-*.patch
    CONFIGURE_COMMAND ${EXEC} cmake -H<SOURCE_DIR> -B<BINARY_DIR>
        -DCMAKE_BUILD_TYPE=Release
        -DCMAKE_INSTALL_PREFIX=${MINGW_INSTALL_PREFIX}
        -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE}
        -DWITH_ZLIB=ON
        -DWITH_MBEDTLS=ON
        -DMBEDTLS_INCLUDE_DIR=${MINGW_INSTALL_PREFIX}/include
        -DBUILD_STATIC_LIB=ON
        -DWITH_EXAMPLES=OFF
        -DBUILD_SHARED_LIBS=OFF
        -DCMAKE_C_FLAGS='${CMAKE_C_FLAGS} -DHAVE_COMPILER__FUNC__=1 -DMBEDTLS_ALLOW_PRIVATE_ACCESS -DMBEDTLS_THREADING_C -DMBEDTLS_THREADING_PTHREAD'
    BUILD_COMMAND ${MAKE} -C <BINARY_DIR>
    INSTALL_COMMAND ${MAKE} -C <BINARY_DIR> install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libssh)
cleanup(libssh install)
