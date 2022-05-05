//
//  GenericCommand.swift
//  Netlink
//
//  Created by Alsey Coleman Miller on 7/7/18.
//

@_implementationOnly import CNetlink

public struct NetlinkGenericCommand: RawRepresentable, Equatable, Hashable {
    
    public let rawValue: UInt8
    
    public init(rawValue: UInt8) {
        
        self.rawValue = rawValue
    }
}

// MARK: - ExpressibleByIntegerLiteral

extension NetlinkGenericCommand: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: UInt8) {
        self.init(rawValue: value)
    }
}

// MARK: -

public extension NetlinkGenericCommand {
    
    static var newFamily: NetlinkGenericCommand { NetlinkGenericCommand(rawValue: UInt8(CTRL_CMD_NEWFAMILY)) }
    
    static var getFamily: NetlinkGenericCommand { NetlinkGenericCommand(rawValue: UInt8(CTRL_CMD_GETFAMILY)) }
}
