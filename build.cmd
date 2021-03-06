@echo off

git clone https://github.com/bitcoin/bitcoin.git

vcpkg install leveldb libevent openssl berkeleydb boost-system boost-filesystem	boost-chrono boost-program-options boost-test boost-thread boost-signals boost-signals2 boost-multi-index boost-interprocess

copy /Y "CMakeLists_leveldb.txt" "bitcoin/src/leveldb/CMakeLists.txt"
copy /Y "CMakeLists_secp256k1.txt" "bitcoin/src/secp256k1/CMakeLists.txt"
copy /Y "CMakeLists_univalue.txt" "bitcoin/src/univalue/CMakeLists.txt"
copy /Y "libsecp256k1-config.h.in" "bitcoin/src/secp256k1/libsecp256k1-config.h.in"

mkdir build
cd build

cmake .. -G "Visual Studio 15 2017" -DCMAKE_TOOLCHAIN_FILE="%VCPKG_ROOT%\\scripts\\buildsystems\\vcpkg.cmake"