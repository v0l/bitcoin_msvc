@echo off

cd libevent && md build && cd build
cmake .. -G "Visual Studio 15 2017 Win64"
msbuild libevent.sln /p:Configuration=Release

cd ../../

copy /Y "CMakeLists_leveldb.txt" "bitcoin/src/leveldb/CMakeLists.txt"
copy /Y "CMakeLists_secp256k1.txt" "bitcoin/src/secp256k1/CMakeLists.txt"
copy /Y "CMakeLists_univalue.txt" "bitcoin/src/univalue/CMakeLists.txt"

md build && cd build

cmake .. -G "Visual Studio 15 2017 Win64"

msbuild bitcoin.sln /p:Configuration=Release