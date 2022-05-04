//
//  Linux.swift
//  Netlink
//
//  Created by Alsey Coleman Miller on 7/29/18.
//

import Foundation
import SystemPackage
import Socket
import CNetlink

/* level and options for setsockopt() */
internal var SOL_NETLINK: CInt { 270 }

#if !os(Linux)

#warning("This module will only run on Linux")

public var AF_NETLINK: CInt { 16 }
public extension SocketAddressFamily {
    static var netlink: SocketAddressFamily { SocketAddressFamily(rawValue: AF_NETLINK) }
}

public var NETLINK_ROUTE: CInt              { 0 }    /* Routing/device hook                */
public var NETLINK_UNUSED: CInt             { 1 }    /* Unused number                */
public var NETLINK_USERSOCK: CInt           { 2 }    /* Reserved for user mode socket protocols     */
public var NETLINK_FIREWALL: CInt           { 3 }   /* Unused number, formerly ip_queue        */
public var NETLINK_SOCK_DIAG: CInt          { 4 }   /* socket monitoring                */
public var NETLINK_NFLOG: CInt              { 5 }   /* netfilter/iptables ULOG */
public var NETLINK_XFRM: CInt               { 6 }   /* ipsec */
public var NETLINK_SELINUX: CInt            { 7 }    /* SELinux event notifications */
public var NETLINK_ISCSI: CInt              { 8 }    /* Open-iSCSI */
public var NETLINK_AUDIT: CInt              { 9 }    /* auditing */
public var NETLINK_FIB_LOOKUP: CInt         { 10 }
public var NETLINK_CONNECTOR: CInt          { 11 }
public var NETLINK_NETFILTER: CInt          { 12 }   /* netfilter subsystem */
public var NETLINK_IP6_FW: CInt             { 13 }
public var NETLINK_DNRTMSG: CInt            { 14 }    /* DECnet routing messages */
public var NETLINK_KOBJECT_UEVENT: CInt     { 15 }   /* Kernel messages to userspace */
public var NETLINK_GENERIC: CInt            { 16 }
public var NETLINK_SCSITRANSPORT: CInt      { 18 }  /* SCSI Transports */
public var NETLINK_ECRYPTFS: CInt           { 19 }
public var NETLINK_RDMA: CInt               { 20 }
public var NETLINK_CRYPTO: CInt             { 21 }   /* Crypto layer */

public var NLMSG_NOOP: CInt                 { 0x1 }    /* Nothing.        */
public var NLMSG_ERROR: CInt                { 0x2 }    /* Error        */
public var NLMSG_DONE: CInt                 { 0x3 }    /* End of a dump    */
public var NLMSG_OVERRUN: CInt              { 0x4 }    /* Data lost        */
public var NLMSG_MIN_TYPE: CInt             { 0x10 }    /* < 0x10: reserved control messages */

public var CTRL_ATTR_UNSPEC: CInt           { 0x00 }
public var CTRL_ATTR_FAMILY_ID: CInt        { 0x01 }
public var CTRL_ATTR_FAMILY_NAME: CInt      { 0x02 }
public var CTRL_ATTR_VERSION: CInt          { 0x03 }
public var CTRL_ATTR_HDRSIZE: CInt          { 0x04 }
public var CTRL_ATTR_MAXATTR: CInt          { 0x05 }
public var CTRL_ATTR_OPS: CInt              { 0x06 }
public var CTRL_ATTR_MCAST_GROUPS: CInt     { 0x07 }

public var CTRL_ATTR_OP_UNSPEC: CInt        { 0x00 }
public var CTRL_ATTR_OP_ID: CInt            { 0x01 }
public var CTRL_ATTR_OP_FLAGS: CInt         { 0x02 }

public var CTRL_ATTR_MCAST_GRP_UNSPEC: CInt { 0x00 }
public var CTRL_ATTR_MCAST_GRP_NAME: CInt   { 0x01 }
public var CTRL_ATTR_MCAST_GRP_ID: CInt     { 0x02 }

public var NETLINK_ADD_MEMBERSHIP: CInt     { 1 }
public var NETLINK_DROP_MEMBERSHIP: CInt    { 2 }
public var NETLINK_PKTINFO: CInt            { 3 }
public var NETLINK_BROADCAST_ERROR: CInt    { 4 }
public var NETLINK_NO_ENOBUFS: CInt         { 5 }
public var NETLINK_RX_RING: CInt            { 6 }
public var NETLINK_TX_RING: CInt            { 7 }
public var NETLINK_LISTEN_ALL_NSID: CInt    { 8 }
public var NETLINK_LIST_MEMBERSHIPS: CInt   { 9 }
public var NETLINK_CAP_ACK: CInt            { 10 }

public var NLM_F_REQUEST: CInt              { 1 }    /* It is request message.     */
public var NLM_F_MULTI: CInt                { 2 }    /* Multipart message, terminated by NLMSG_DONE */
public var NLM_F_ACK: CInt                  { 4 }    /* Reply with ack, with zero or error code */
public var NLM_F_ECHO: CInt                 { 8 }    /* Echo this request         */
public var NLM_F_DUMP_INTR: CInt            { 16 }    /* Dump was inconsistent due to sequence change */
public var NLM_F_DUMP_FILTERED: CInt        { 32 }    /* Dump was filtered as requested */

/* Modifiers to GET request */
public var NLM_F_ROOT: CInt                 { 0x100 }    /* specify tree    root    */
public var NLM_F_MATCH: CInt                { 0x200 }    /* return all matching    */
public var NLM_F_ATOMIC: CInt               { 0x400 }    /* atomic GET        */
public var NLM_F_DUMP: CInt                 { NLM_F_ROOT | NLM_F_MATCH }

/* Modifiers to NEW request */
public var NLM_F_REPLACE: CInt              { 0x100 }    /* Override existing        */
public var NLM_F_EXCL: CInt                 { 0x200 }    /* Do not touch, if it exists    */
public var NLM_F_CREATE: CInt               { 0x400 }    /* Create, if it does not exist    */
public var NLM_F_APPEND: CInt               { 0x800 }    /* Add to end of list        */

public var NLA_F_NESTED: CInt               { (1 << 15) }
public var NLA_F_NET_BYTEORDER: CInt        { (1 << 14) }

public struct sockaddr_nl {

    public var nl_family: CInterop.SocketAddressFamily = 0 /* AF_NETLINK    */

    public var nl_pad: UInt16 = 0 /* zero        */

    public var nl_pid: __u32 = 0 /* port ID    */

    public var nl_groups: __u32 = 0 /* multicast groups mask */
}

public struct nlmsghdr {

    public var nlmsg_len: __u32 = 0 /* Length of message including header */

    public var nlmsg_type: __u16 = 0 /* Message content */

    public var nlmsg_flags: __u16 = 0 /* Additional flags */

    public var nlmsg_seq: __u32 = 0 /* Sequence number */

    public var nlmsg_pid: __u32 = 0 /* Sending process port ID */
}

public typealias __u8 = UInt8
public typealias __u16 = UInt16
public typealias __u32 = UInt32
public typealias __u64 = UInt64
public typealias __s8 = Int8
public typealias __s16 = Int16
public typealias __s32 = Int32
public typealias __s64 = Int64

#endif
