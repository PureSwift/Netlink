//
//  MessageType.swift
//  Netlink
//
//  Created by Alsey Coleman Miller on 5/4/22.
//
//

import SystemPackage

/// POSIX Process ID
@frozen
public struct ProcessID: RawRepresentable, Equatable, Hashable, Codable {
    
    /// The raw C process ID.
    @_alwaysEmitIntoClient
    public let rawValue: CInterop.ProcessID

    /// Creates a strongly typed process ID from a raw C process ID.
    @_alwaysEmitIntoClient
    public init(rawValue: CInterop.ProcessID) { self.rawValue = rawValue }
}

public extension ProcessID {
    
    @_alwaysEmitIntoClient
    static var current: ProcessID { ProcessID(rawValue: system_getpid()) }
    
    @_alwaysEmitIntoClient
    static var parent: ProcessID { ProcessID(rawValue: system_getppid()) }
}
