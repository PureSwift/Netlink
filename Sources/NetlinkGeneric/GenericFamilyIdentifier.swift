//
//  NetlinkGenericFamilyIdentifier.swift
//  Netlink
//
//  Created by Alsey Coleman Miller on 7/7/18.
//

import Foundation
@_implementationOnly import CNetlink

/// Netlink Generic Family Identifier
public struct NetlinkGenericFamilyIdentifier: RawRepresentable, Equatable, Hashable, Codable {
    
    public let rawValue: UInt16
    
    public init(rawValue: UInt16) {
        self.rawValue = rawValue
    }
}

// MARK: - Static Identifiers

public extension NetlinkGenericFamilyIdentifier {
        
    static var controller: NetlinkGenericFamilyIdentifier { .init(rawValue: UInt16(GENL_ID_CTRL)) }
}
