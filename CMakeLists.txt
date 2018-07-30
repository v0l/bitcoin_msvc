cmake_minimum_required (VERSION 3.11)
project (bitcoin)

exec_program("git" "bitcoin/" ARGS "describe" "--always" OUTPUT_VARIABLE GIT_COMMIT_ID)
	
find_package(Libevent REQUIRED)
find_package(Openssl REQUIRED)
find_package(Boost COMPONENTS system filesystem chrono program_options unit_test_framework thread signals REQUIRED)

#find a file from one of the pacakges, this will be the /installed/ dir for vcpkg
find_path(VCPKG_DIR "event2/buffer.h")
include_directories(
	"${PROJECT_BINARY_DIR}" 
	"${VCPKG_DIR}" 
	"patch" 
	"bitcoin/src" 
	"bitcoin/src/leveldb/include"
	"bitcoin/src/leveldb/helpers/memenv"
	"bitcoin/src/univalue/include" 
	"bitcoin/src/secp256k1/include" 
	"libevent/include"
)

set(CLIENT_VERSION_MAJOR 0)
set(CLIENT_VERSION_MINOR 16)
set(CLIENT_VERSION_REVISION 2)
set(CLIENT_VERSION_BUILD 0)
set(CLIENT_VERSION_IS_RELEASE true)
set(COPYRIGHT_YEAR 2018)
set(PACKAGE_NAME "Bitcoin")
set(COPYRIGHT_HOLDERS "The %s developers")
set(COPYRIGHT_HOLDERS_SUBSTITUTION "Bitcoin Core")
string(REPLACE "%s" ${COPYRIGHT_HOLDERS_SUBSTITUTION} COPYRIGHT_HOLDERS_FINAL ${COPYRIGHT_HOLDERS})

configure_file("bitcoin-config.h.in" "${PROJECT_BINARY_DIR}/config/bitcoin-config.h")
add_definitions(
	-DHAVE_CONFIG_H
	-DHAVE_WORKING_BOOST_SLEEP_FOR
)

add_subdirectory("bitcoin/src/leveldb")
add_subdirectory("bitcoin/src/secp256k1")
add_subdirectory("bitcoin/src/univalue")

option(opt_enable_zmq "Enable ZMQ support" OFF)
option(opt_enable_wallet "Enable wallet support" ON)

set(bitcoin_core_h 
	bitcoin/src/addrdb.h 
	bitcoin/src/addrman.h 
	bitcoin/src/base58.h 
	bitcoin/src/bech32.h 
	bitcoin/src/bloom.h 
	bitcoin/src/blockencodings.h 
	bitcoin/src/chain.h 
	bitcoin/src/chainparams.h 
	bitcoin/src/chainparamsbase.h 
	bitcoin/src/chainparamsseeds.h 
	bitcoin/src/checkpoints.h 
	bitcoin/src/checkqueue.h 
	bitcoin/src/clientversion.h 
	bitcoin/src/coins.h 
	bitcoin/src/compat.h 
	bitcoin/src/compat/byteswap.h 
	bitcoin/src/compat/endian.h 
	bitcoin/src/compat/sanity.h 
	bitcoin/src/compressor.h 
	bitcoin/src/consensus/consensus.h 
	bitcoin/src/consensus/tx_verify.h 
	bitcoin/src/core_io.h 
	bitcoin/src/core_memusage.h 
	bitcoin/src/cuckoocache.h 
	bitcoin/src/fs.h 
	bitcoin/src/httprpc.h 
	bitcoin/src/httpserver.h 
	bitcoin/src/indirectmap.h 
	bitcoin/src/init.h 
	bitcoin/src/key.h 
	bitcoin/src/keystore.h 
	bitcoin/src/dbwrapper.h 
	bitcoin/src/limitedmap.h 
	bitcoin/src/memusage.h 
	bitcoin/src/merkleblock.h 
	bitcoin/src/miner.h 
	bitcoin/src/net.h 
	bitcoin/src/net_processing.h 
	bitcoin/src/netaddress.h 
	bitcoin/src/netbase.h 
	bitcoin/src/netmessagemaker.h 
	bitcoin/src/noui.h 
	bitcoin/src/policy/feerate.h 
	bitcoin/src/policy/fees.h 
	bitcoin/src/policy/policy.h 
	bitcoin/src/policy/rbf.h 
	bitcoin/src/pow.h 
	bitcoin/src/protocol.h 
	bitcoin/src/random.h 
	bitcoin/src/reverse_iterator.h 
	bitcoin/src/reverselock.h 
	bitcoin/src/rpc/blockchain.h 
	bitcoin/src/rpc/client.h 
	bitcoin/src/rpc/mining.h 
	bitcoin/src/rpc/protocol.h 
	bitcoin/src/rpc/safemode.h 
	bitcoin/src/rpc/server.h 
	bitcoin/src/rpc/register.h 
	bitcoin/src/rpc/util.h 
	bitcoin/src/scheduler.h 
	bitcoin/src/script/sigcache.h 
	bitcoin/src/script/sign.h 
	bitcoin/src/script/standard.h 
	bitcoin/src/script/ismine.h 
	bitcoin/src/streams.h 
	bitcoin/src/support/allocators/secure.h 
	bitcoin/src/support/allocators/zeroafterfree.h 
	bitcoin/src/support/cleanse.h 
	bitcoin/src/support/events.h 
	bitcoin/src/support/lockedpool.h 
	bitcoin/src/sync.h 
	bitcoin/src/threadsafety.h 
	bitcoin/src/threadinterrupt.h 
	bitcoin/src/timedata.h 
	bitcoin/src/torcontrol.h 
	bitcoin/src/txdb.h 
	bitcoin/src/txmempool.h 
	bitcoin/src/ui_interface.h 
	bitcoin/src/undo.h 
	bitcoin/src/util.h 
	bitcoin/src/utilmoneystr.h 
	bitcoin/src/utiltime.h 
	bitcoin/src/validation.h 
	bitcoin/src/validationinterface.h 
	bitcoin/src/versionbits.h 
	bitcoin/src/wallet/coincontrol.h 
	bitcoin/src/wallet/crypter.h 
	bitcoin/src/wallet/db.h 
	bitcoin/src/wallet/feebumper.h 
	bitcoin/src/wallet/fees.h 
	bitcoin/src/wallet/init.h 
	bitcoin/src/wallet/rpcwallet.h 
	bitcoin/src/wallet/wallet.h 
	bitcoin/src/wallet/walletdb.h 
	bitcoin/src/wallet/walletutil.h 
	bitcoin/src/warnings.h 
	bitcoin/src/zmq/zmqabstractnotifier.h 
	bitcoin/src/zmq/zmqconfig.h
	bitcoin/src/zmq/zmqnotificationinterface.h 
	bitcoin/src/zmq/zmqpublishnotifier.h
)

add_library(libbitcoin_server STATIC
	bitcoin/src/addrdb.cpp 
	bitcoin/src/addrman.cpp 
	bitcoin/src/bloom.cpp 
	bitcoin/src/blockencodings.cpp 
	bitcoin/src/chain.cpp 
	bitcoin/src/checkpoints.cpp 
	bitcoin/src/consensus/tx_verify.cpp 
	bitcoin/src/httprpc.cpp 
	bitcoin/src/httpserver.cpp 
	bitcoin/src/init.cpp 
	bitcoin/src/dbwrapper.cpp 
	bitcoin/src/merkleblock.cpp 
	bitcoin/src/miner.cpp 
	bitcoin/src/net.cpp 
	bitcoin/src/net_processing.cpp 
	bitcoin/src/noui.cpp 
	bitcoin/src/policy/fees.cpp 
	bitcoin/src/policy/policy.cpp 
	bitcoin/src/policy/rbf.cpp 
	bitcoin/src/pow.cpp 
	bitcoin/src/rest.cpp 
	bitcoin/src/rpc/blockchain.cpp 
	bitcoin/src/rpc/mining.cpp 
	bitcoin/src/rpc/misc.cpp 
	bitcoin/src/rpc/net.cpp 
	bitcoin/src/rpc/rawtransaction.cpp 
	bitcoin/src/rpc/safemode.cpp 
	bitcoin/src/rpc/server.cpp 
	bitcoin/src/script/sigcache.cpp 
	bitcoin/src/script/ismine.cpp 
	bitcoin/src/timedata.cpp 
	bitcoin/src/torcontrol.cpp 
	bitcoin/src/txdb.cpp 
	bitcoin/src/txmempool.cpp 
	bitcoin/src/ui_interface.cpp 
	bitcoin/src/validation.cpp 
	bitcoin/src/validationinterface.cpp 
	bitcoin/src/versionbits.cpp 
	${bitcoin_core_h}
)

if(opt_enable_zmq)
	find_library(ld_libzmq "libzmq")
	set(ld_zmq libbitcoin_zmq)
	add_library(libbitcoin_zmq STATIC
		bitcoin/src/zmq/zmqabstractnotifier.cpp
		bitcoin/src/zmq/zmqnotificationinterface.cpp
		bitcoin/src/zmq/zmqpublishnotifier.cpp
	)
	add_definitions(-DENABLE_ZMQ)
endif(opt_enable_zmq)

if(opt_enable_wallet)
	set(ld_wallet libbitcoin_wallet)
	add_definitions(-DENABLE_WALLET)
endif(opt_enable_wallet)

add_library(libbitcoin_wallet STATIC
	bitcoin/src/wallet/crypter.cpp
	bitcoin/src/wallet/db.cpp
	bitcoin/src/wallet/feebumper.cpp
	bitcoin/src/wallet/fees.cpp
	bitcoin/src/wallet/init.cpp
	bitcoin/src/wallet/rpcdump.cpp
	bitcoin/src/wallet/rpcwallet.cpp
	bitcoin/src/wallet/wallet.cpp
	bitcoin/src/wallet/walletdb.cpp
	bitcoin/src/wallet/walletutil.cpp
	${bitcoin_core_h}
)

add_library(libbitcoin_crypto_base STATIC
	bitcoin/src/crypto/aes.cpp
	bitcoin/src/crypto/aes.h
	bitcoin/src/crypto/chacha20.h
	bitcoin/src/crypto/chacha20.cpp
	bitcoin/src/crypto/common.h
	bitcoin/src/crypto/hmac_sha256.cpp
	bitcoin/src/crypto/hmac_sha256.h
	bitcoin/src/crypto/hmac_sha512.cpp
	bitcoin/src/crypto/hmac_sha512.h
	bitcoin/src/crypto/ripemd160.cpp
	bitcoin/src/crypto/ripemd160.h
	bitcoin/src/crypto/sha1.cpp
	bitcoin/src/crypto/sha1.h
	bitcoin/src/crypto/sha256.cpp
	bitcoin/src/crypto/sha256.h
	bitcoin/src/crypto/sha512.cpp
	bitcoin/src/crypto/sha512.h
)

add_library(libbitcoin_consensus STATIC
	bitcoin/src/amount.h
	bitcoin/src/arith_uint256.cpp
	bitcoin/src/arith_uint256.h
	bitcoin/src/consensus/merkle.cpp
	bitcoin/src/consensus/merkle.h
	bitcoin/src/consensus/params.h
	bitcoin/src/consensus/validation.h
	bitcoin/src/hash.cpp
	bitcoin/src/hash.h
	bitcoin/src/prevector.h
	bitcoin/src/primitives/block.cpp
	bitcoin/src/primitives/block.h
	bitcoin/src/primitives/transaction.cpp
	bitcoin/src/primitives/transaction.h
	bitcoin/src/pubkey.cpp
	bitcoin/src/pubkey.h
	bitcoin/src/script/bitcoinconsensus.cpp
	bitcoin/src/script/interpreter.cpp
	bitcoin/src/script/interpreter.h
	bitcoin/src/script/script.cpp
	bitcoin/src/script/script.h
	bitcoin/src/script/script_error.cpp
	bitcoin/src/script/script_error.h
	bitcoin/src/serialize.h
	bitcoin/src/tinyformat.h
	bitcoin/src/uint256.cpp
	bitcoin/src/uint256.h
	bitcoin/src/utilstrencodings.cpp
	bitcoin/src/utilstrencodings.h
	bitcoin/src/version.h
)

add_library(libbitcoin_common STATIC
	bitcoin/src/base58.cpp
	bitcoin/src/bech32.cpp
	bitcoin/src/chainparams.cpp
	bitcoin/src/coins.cpp
	bitcoin/src/compressor.cpp
	bitcoin/src/core_read.cpp
	bitcoin/src/core_write.cpp
	bitcoin/src/key.cpp
	bitcoin/src/keystore.cpp
	bitcoin/src/netaddress.cpp
	bitcoin/src/netbase.cpp
	bitcoin/src/policy/feerate.cpp
	bitcoin/src/protocol.cpp
	bitcoin/src/scheduler.cpp
	bitcoin/src/script/sign.cpp
	bitcoin/src/script/standard.cpp
	bitcoin/src/warnings.cpp
	${bitcoin_core_h}
)

add_library(libbitcoin_util STATIC
	bitcoin/src/support/lockedpool.cpp
	bitcoin/src/chainparamsbase.cpp
	bitcoin/src/clientversion.cpp
	bitcoin/src/compat/glibc_sanity.cpp
	bitcoin/src/compat/glibcxx_sanity.cpp
	bitcoin/src/compat/strnlen.cpp
	bitcoin/src/fs.cpp
	bitcoin/src/random.cpp
	bitcoin/src/rpc/protocol.cpp
	bitcoin/src/rpc/util.cpp
	bitcoin/src/support/cleanse.cpp
	bitcoin/src/sync.cpp
	bitcoin/src/threadinterrupt.cpp
	bitcoin/src/util.cpp
	bitcoin/src/utilmoneystr.cpp
	bitcoin/src/utilstrencodings.cpp
	bitcoin/src/utiltime.cpp
	${bitcoin_core_h}
)

add_library(libbitcoin_cli STATIC
	bitcoin/src/rpc/client.cpp
	${bitcoin_core_h}
)

find_library(ld_bdb libdb48)
find_library(ld_find_libeay libeay32)
find_library(ld_find_ssl ssleay32)
#find_library(ld_leveldb libleveldb)

set(ld_boost Boost::system Boost::filesystem Boost::chrono Boost::program_options Boost::thread)
set(ld_libevent Ws2_32 event event_core event_extra)
set(ld_ssl ${ld_find_libeay} ${ld_find_ssl})

add_executable(bitcoind bitcoin/src/bitcoind.cpp bitcoin/src/bitcoind-res.rc)
add_executable(bitcoin-cli bitcoin/src/bitcoin-cli.cpp)
add_executable(bitcoin-tx bitcoin/src/bitcoin-tx.cpp)

target_link_libraries(bitcoind 
	libbitcoin_server
	libbitcoin_common
	univalue
	libbitcoin_util
	${ld_wallet}
	${ld_zmq}
	libbitcoin_consensus
	libbitcoin_crypto_base
	Shlwapi
	Iphlpapi
	leveldb
	secp256k1
	${ld_boost}
	${ld_bdb}
	${ld_ssl}
	${ld_libevent}
	${ld_libzmq}
)

target_link_libraries(bitcoin-cli
	libbitcoin_cli
	univalue
	libbitcoin_util
	libbitcoin_crypto_base
	${ld_boost}
	${ld_ssl}
	${ld_libevent}
)

target_link_libraries(bitcoin-tx
	secp256k1
	univalue
	libbitcoin_common
	libbitcoin_util
	libbitcoin_consensus
	libbitcoin_crypto_base
	${ld_boost}
	${ld_ssl}
	${ld_libevent}
)