cmake_minimum_required (VERSION 2.6)
project (bitcoin)

include_directories("${PROJECT_BINARY_DIR}" "$ENV{BOOST_DIR}" "$ENV{OPENSSL_ROOT_DIR}/include" "bitcoin/src" "bitcoin/src/leveldb/include" "bitcoin/src/leveldb/helpers/memenv" "bitcoin/src/univalue/include" "bitcoin/src/secp256k1/include" "libevent/include")
link_directories("$ENV{BOOST_DIR}/lib64-msvc-14.1" "libevent/build/lib/Release")

set(CLIENT_VERSION_MAJOR 0)
set(CLIENT_VERSION_MINOR 16)
set(CLIENT_VERSION_REVISION 99)
set(CLIENT_VERSION_BUILD 0)
set(CLIENT_VERSION_IS_RELEASE false)
set(COPYRIGHT_YEAR 2018)
set(PACKAGE_NAME "Bitcoin")
set(COPYRIGHT_HOLDERS "The %s developers")
set(COPYRIGHT_HOLDERS_SUBSTITUTION "Bitcoin Core")

configure_file("bitcoin-config.h.in" "${PROJECT_BINARY_DIR}/config/bitcoin-config.h")
add_definitions(
	-DHAVE_CONFIG_H
	-DHAVE_WORKING_BOOST_SLEEP_FOR
)

add_subdirectory("bitcoin/src/leveldb")
add_subdirectory("bitcoin/src/secp256k1")
add_subdirectory("bitcoin/src/univalue")

set(BITCOIN_SRC 
	bitcoin/src/arith_uint256.h
    bitcoin/src/chain.h
    bitcoin/src/chainparams.h
    bitcoin/src/checkpoints.h
    bitcoin/src/checkqueue.h
    bitcoin/src/consensus/consensus.h
    bitcoin/src/consensus/merkle.h
    bitcoin/src/consensus/tx_verify.h
    bitcoin/src/consensus/validation.h
    bitcoin/src/cuckoocache.h
    bitcoin/src/hash.h
    bitcoin/src/index/txindex.h
    bitcoin/src/init.h
    bitcoin/src/policy/fees.h
    bitcoin/src/policy/policy.h
    bitcoin/src/policy/rbf.h
    bitcoin/src/pow.h
    bitcoin/src/primitives/block.h
    bitcoin/src/primitives/transaction.h
    bitcoin/src/random.h
    bitcoin/src/reverse_iterator.h
    bitcoin/src/script/script.h
    bitcoin/src/script/sigcache.h
    bitcoin/src/script/standard.h
    bitcoin/src/timedata.h
    bitcoin/src/tinyformat.h
    bitcoin/src/txdb.h
    bitcoin/src/txmempool.h
    bitcoin/src/ui_interface.h
    bitcoin/src/undo.h
    bitcoin/src/util.h
    bitcoin/src/utilmoneystr.h
    bitcoin/src/utilstrencodings.h
    bitcoin/src/validationinterface.h
    bitcoin/src/warnings.h
	
	bitcoin/src/addrdb.cpp
    bitcoin/src/addrman.cpp
    bitcoin/src/arith_uint256.cpp
    bitcoin/src/base58.cpp
    bitcoin/src/bech32.cpp
    bitcoin/src/blockencodings.cpp
    bitcoin/src/bloom.cpp
    bitcoin/src/chain.cpp
    bitcoin/src/chainparams.cpp
    bitcoin/src/chainparamsbase.cpp
    bitcoin/src/checkpoints.cpp
    bitcoin/src/clientversion.cpp
    bitcoin/src/coins.cpp
    bitcoin/src/compressor.cpp
    bitcoin/src/core_read.cpp
    bitcoin/src/core_write.cpp
    bitcoin/src/dbwrapper.cpp
    bitcoin/src/fs.cpp
    bitcoin/src/hash.cpp
    bitcoin/src/httprpc.cpp
    bitcoin/src/httpserver.cpp
    bitcoin/src/init.cpp
    bitcoin/src/key.cpp
    bitcoin/src/key_io.cpp
    bitcoin/src/keystore.cpp
    bitcoin/src/logging.cpp
    bitcoin/src/merkleblock.cpp
    bitcoin/src/miner.cpp
	bitcoin/src/net.cpp
	bitcoin/src/net_processing.cpp
	bitcoin/src/netaddress.cpp
	bitcoin/src/netbase.cpp
	bitcoin/src/noui.cpp
	bitcoin/src/pow.cpp
	bitcoin/src/protocol.cpp
	bitcoin/src/pubkey.cpp
	bitcoin/src/random.cpp
	bitcoin/src/rest.cpp
	bitcoin/src/scheduler.cpp
	bitcoin/src/sync.cpp
	bitcoin/src/threadinterrupt.cpp
	bitcoin/src/timedata.cpp
	bitcoin/src/torcontrol.cpp
	bitcoin/src/txdb.cpp
	bitcoin/src/txmempool.cpp
	bitcoin/src/ui_interface.cpp
	bitcoin/src/uint256.cpp
	bitcoin/src/util.cpp
	bitcoin/src/utilmoneystr.cpp
	bitcoin/src/utilstrencodings.cpp
	bitcoin/src/utiltime.cpp
	bitcoin/src/validation.cpp
	bitcoin/src/validationinterface.cpp
	bitcoin/src/versionbits.cpp
	bitcoin/src/warnings.cpp
)

add_executable(bitcoind "bitcoin/src/bitcoind.cpp" "${BITCOIN_SRC}")
add_executable(bitcoin-cli "bitcoin/src/bitcoin-cli.cpp")
add_executable(bitcoin-tx "bitcoin/src/bitcoin-tx.cpp")

