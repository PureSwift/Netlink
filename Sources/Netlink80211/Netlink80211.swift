//
//  Netlink80211.swift
//  Netlink80211
//
//  Created by Alsey Coleman Miller on 9/16/18.
//

import Foundation
import CNetlink
import Netlink
import NetlinkGeneric

public extension NetlinkGenericFamilyName {
    
    static var nl80211: NetlinkGenericFamilyName {
        return NetlinkGenericFamilyName(rawValue: NL80211_GENL_NAME)
    }
}
