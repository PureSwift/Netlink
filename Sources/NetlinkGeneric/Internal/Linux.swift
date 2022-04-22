//
//  Linux.swift
//  
//
//  Created by Alsey Coleman Miller on 4/22/22.
//

#if !os(Linux)
import Netlink

public var CTRL_CMD_UNSPEC: CInt            { 0 }
public var CTRL_CMD_NEWFAMILY: CInt         { 1 }
public var CTRL_CMD_DELFAMILY: CInt         { 2 }
public var CTRL_CMD_GETFAMILY: CInt         { 3 }
public var CTRL_CMD_NEWOPS: CInt            { 4 }
public var CTRL_CMD_DELOPS: CInt            { 5 }
public var CTRL_CMD_GETOPS: CInt            { 6 }
public var CTRL_CMD_NEWMCAST_GRP: CInt      { 7 }
public var CTRL_CMD_DELMCAST_GRP: CInt      { 8 }
public var CTRL_CMD_GETMCAST_GRP: CInt      { 9 } /* unused */

/*
 * List of reserved static generic netlink identifiers:
 */
public var GENL_ID_GENERATE: CInt { 0 }
public var GENL_ID_CTRL: CInt { NLMSG_MIN_TYPE }
public var GENL_ID_VFS_DQUOT: CInt { NLMSG_MIN_TYPE + 1 }
public var GENL_ID_PMCRAID: CInt { NLMSG_MIN_TYPE + 2 }

#endif
