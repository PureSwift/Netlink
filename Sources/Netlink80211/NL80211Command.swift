//
//  NL80211Command.swift
//  Netlink
//
//  Created by Alsey Coleman Miller on 7/7/18.
//

import Foundation
import Netlink
import NetlinkGeneric
import CNetlink

public extension NetlinkGenericCommand {
    
    /// 802.11 netlink interface
    enum NL80211 {
        
        public static var triggerScan: NetlinkGenericCommand { .init(NL80211_CMD_TRIGGER_SCAN) }
        
        public static var getScan: NetlinkGenericCommand { .init(NL80211_CMD_GET_SCAN) }
        
        public static var newScanResults: NetlinkGenericCommand { .init(NL80211_CMD_NEW_SCAN_RESULTS) }
    }
}

fileprivate extension NetlinkGenericCommand {
    
    init(_ nl80211Command: nl80211_commands) {
        self.init(rawValue: UInt8(nl80211Command.rawValue))
    }
}
