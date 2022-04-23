//
//  GenericFamilyName.swift
//  Netlink
//
//  Created by Alsey Coleman Miller on 7/7/18.
//

/// Netlink Generic Family Name
public struct NetlinkGenericFamilyName: RawRepresentable, Equatable, Hashable, Codable {
    
    public let rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
