//
//  NL80211Command.swift
//  Netlink
//
//  Created by Alsey Coleman Miller on 7/7/18.
//

import Foundation
import Netlink
import NetlinkGeneric
@_implementationOnly import CNetlink

public extension NetlinkGenericCommand {
    
    /// 802.11 netlink interface
    enum NL80211 {
        
        /// NL80211_CMD_TRIGGER_SCAN
        public static var triggerScan: NetlinkGenericCommand        { .init(NL80211_CMD_TRIGGER_SCAN) }
        
        /// NL80211_CMD_GET_SCAN
        public static var getScan: NetlinkGenericCommand            { .init(NL80211_CMD_GET_SCAN) }
        
        /// NL80211_CMD_NEW_SCAN_RESULTS
        public static var newScanResults: NetlinkGenericCommand     { .init(NL80211_CMD_NEW_SCAN_RESULTS) }
        
        /// NL80211_CMD_GET_INTERFACE
        public static var getInterface: NetlinkGenericCommand       { .init(NL80211_CMD_GET_INTERFACE) }
        
        /// NL80211_CMD_GET_WIPHY
        public static var getWiphy: NetlinkGenericCommand           { .init(NL80211_CMD_GET_WIPHY) }
    }
}

fileprivate extension NetlinkGenericCommand {
    
    init(_ nl80211Command: nl80211_commands) {
        self.init(rawValue: UInt8(nl80211Command.rawValue))
    }
}
