# bitcoin_msvc

## Build
### Prerequistes
 - CMake > 3.11
 - vcpkg (https://github.com/Microsoft/vcpkg)

 
Clone your bitcoin repo (currently tested against master branch only)
```
git clone https://github.com/bitcoin/bitcoin.git
```

Get build deps with vcpkg
```
vcpkg install leveldb libevent openssl berkeleydb boost-system boost-filesystem \ 
boost-chrono boost-program-options boost-test boost-thread boost-signals \
boost-signals2 boost-multi-index boost-interprocess
```

Run the `build.cmd` script to copy the `CMakeLists.txt` & configs into each project (also runs `cmake` inside the `build/` dir)

Open the solution file `build/bitcoin.sln` and build all.

### secp256k1
In order to build secp256k1 you need to open `build/bitcoin.sln` and compile the project `secp256k1_gen_context` 

This will create an executable in `build/bitcoin/src/secp256k1/[Debug|Release]/secp256k1_gen_context.exe`

You need to create `src/ecmult_static_context.h` relative to this to run the exe.

Once this file is generated copy it back into the bitcoin repo `bitcoin/src/secp256k1/src`

PS. I know is this nasty i will fix it later.
 