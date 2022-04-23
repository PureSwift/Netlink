//
//  GenericGroupIdentifier.swift
//  Netlink
//
//  Created by Alsey Coleman Miller on 7/28/18.
//

import Foundation
import Netlink


/// Netlink Generic Family Group Identifier
public struct NetlinkGenericMulticastGroupIdentifier: RawRepresentable, Equatable, Hashable, Codable {
    
    public let rawValue: Int32
    
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }
}

// MARK: - Socket

public extension NetlinkSocket {
    
    func subscribe(to group: NetlinkGenericMulticastGroupIdentifier) throws {
        try addMembership(to: group.rawValue)
    }
    
    func unsubscribe(from group: NetlinkGenericMulticastGroupIdentifier) throws {
        try removeMembership(from: group.rawValue)
    }
}
