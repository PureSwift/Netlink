/*
 *
 *  Swift Netlink Headers
 *  MIT License
 *  PureSwift
 *
 * Created by Alsey Coleman Miller on 7/5/18.
 *
 */

#include <sys/ioctl.h>
#include <sys/types.h>
#include <ifaddrs.h>
#include <net/if.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>

#ifdef linux

#include <linux/types.h>        /* for __u* and __s* typedefs */
#include <linux/socket.h>        /* for "struct sockaddr" et al    */

#else

typedef uint8_t __u8;
typedef uint16_t __u16;
typedef uint32_t __u32;
typedef uint64_t __u64;

typedef int8_t __s8;
typedef int16_t __s16;
typedef int32_t __s32;
typedef int64_t __s64;

#endif

#if linux
#include <linux/nl80211.h>
#include <linux/genetlink.h>
#else
#include "nl80211.h"
#include "genetlink.h"
#endif


