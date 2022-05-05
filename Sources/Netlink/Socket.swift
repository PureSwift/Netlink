//
//  Socket.swift
//  Netlink
//
//  Created by Alsey Coleman Miller on 7/6/18.
//

import Foundation
import SystemPackage
import Socket
@_implementationOnly import CNetlink

public final class NetlinkSocket {
    
    // MARK: - Properties
    
    public let netlinkProtocol: NetlinkSocketProtocol
    
    internal let socket: Socket
    
    // MARK: - Initialization
    
    deinit {
        Task(priority: .high) {
            await socket.close()
        }
    }
    
    public init(
        _ netlinkProtocol: NetlinkSocketProtocol = .generic,
        group: Int32 = 0
    ) async throws {
        // open socket
        // socket(PF_NETLINK, SOCK_RAW, netlinkProtocol.rawValue)
        let fileDescriptor = try SocketDescriptor(netlinkProtocol)
        // bind address
        let address = NetlinkSocketAddress(
            processID: .current,
            group: group
        )
        try fileDescriptor.closeIfThrows {
            try fileDescriptor.bind(address)
        }
        // initialize socket
        self.socket = await Socket(fileDescriptor: fileDescriptor)
        self.netlinkProtocol = netlinkProtocol
    }
    
    // MARK: - Methods
    
    public func addMembership(to group: CInt) throws {
        try socket.setOption(NetlinkSocketOption.AddMembership(group: group))
    }
    
    public func removeMembership(from group: CInt) throws {
        try socket.setOption(NetlinkSocketOption.DropMembership(group: group))
    }
    
    public func send(_ data: Data) async throws {
        
        let sentBytes = try await socket.write(data)
        
        guard sentBytes == data.count
            else { throw NetlinkSocketError.invalidSentBytes(sentBytes) }
    }
    
    public func recieve <T: NetlinkMessageProtocol> (_ message: T.Type) async throws -> [T] {
        
        let data = try await recieve()
        
        if let errorMessages = try? NetlinkErrorMessage.from(data: data),
            let error = errorMessages.first(where: { $0.error != nil }) {
            throw error
        } else if let messages = try? T.from(data: data) {
            return messages
        } else {
            throw NetlinkSocketError.invalidData(data)
        }
    }
    
    public func recieve() async throws -> Data {
        
        let chunkSize = Int(system_getpagesize())
        var readData = Data()
        var chunk = Data()
        repeat {
            chunk = try await socket.read(chunkSize)
            readData.append(chunk)
        } while chunk.count == chunkSize // keep reading
        
        return readData
    }
}

// MARK: - Supporting Types

public enum NetlinkSocketError: Error {
    
    case invalidProtocol
    case invalidSentBytes(Int)
    case invalidData(Data)
}
