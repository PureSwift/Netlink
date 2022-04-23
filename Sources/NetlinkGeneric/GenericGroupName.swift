//
//  NetlinkGenericGroup.swift
//  Netlink
//
//  Created by Alsey Coleman Miller on 7/7/18.
//

public struct NetlinkGenericMulticastGroupName: RawRepresentable, Equatable, Hashable, Codable {
    
    public let rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
