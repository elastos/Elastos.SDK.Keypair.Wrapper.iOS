/*
 * Building OpenSSL for the different architectures of all iOS and tvOS devices requires different settings.
 * In order to be able to use assembly code on all devices, the choice was made to keep optimal settings for all
 * devices and use this intermediate header file to use the proper opensslconf.h file for each architecture.

 * See also https://github.com/x2on/OpenSSL-for-iPhone/issues/126 and referenced pull requests
 */

#include <TargetConditionals.h>

#if 0
# include <openssl/opensslconf_ios_iossimulator.h>
#elif 0
# include <openssl/opensslconf_ios_ios64.h>
#else
# error Unable to determine target or target not included in OpenSSL build
#endif
