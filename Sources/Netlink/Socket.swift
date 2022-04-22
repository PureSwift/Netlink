//
//  Socket.swift
//  Netlink
//
//  Created by Alsey Coleman Miller on 7/6/18.
//

#if os(Linux)
import Glibc
#elseif os(macOS)
import Darwin.C
#endif

import Foundation
import SystemPackage
import Socket
import CNetlink

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
        let fileDescriptor = try FileDescriptor.socket(netlinkProtocol)
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
        
        var group = group
        
        guard withUnsafePointer(to: &group, { (pointer: UnsafePointer<CInt>) in
            setsockopt(socket.fileDescriptor.rawValue,
                       SOL_NETLINK,
                       NETLINK_ADD_MEMBERSHIP,
                       UnsafeRawPointer(pointer),
                       socklen_t(MemoryLayout<CInt>.size))
        }) == 0 else { throw Errno(rawValue: errno) }
    }
    
    public func removeMembership(from group: CInt) throws {
        
        var group = group
        
        guard withUnsafePointer(to: &group, { (pointer: UnsafePointer<CInt>) in
            setsockopt(socket.fileDescriptor.rawValue,
                       SOL_NETLINK,
                       NETLINK_DROP_MEMBERSHIP,
                       UnsafeRawPointer(pointer),
                       socklen_t(MemoryLayout<CInt>.size))
        }) == 0 else { throw Errno(rawValue: errno) }
    }
    
    public func send(_ data: Data) async throws {
        
        var address = sockaddr_nl.zero
        
        let sentBytes = withUnsafePointer(to: &address, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1, { (socketPointer) in
                data.withUnsafeBytes { (dataPointer: UnsafePointer<UInt8>) in
                    sendto(socket.fileDescriptor.rawValue, UnsafeRawPointer(dataPointer), data.count, 0, socketPointer, socklen_t(MemoryLayout<sockaddr_nl>.size))
                }
            })
        })
        
        guard sentBytes >= 0
            else { throw Errno(rawValue: errno) }
        
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
        
        let chunkSize = Int(getpagesize())
        
        var readData = Data()
        var chunk = Data()
        repeat {
            chunk = try await recieveChunk(size: chunkSize)
            readData.append(chunk)
        } while chunk.count == chunkSize // keep reading
        
        return readData
    }
    
    internal func recieveChunk(size: Int, flags: CInt = 0) async throws -> Data {
        
        var data = Data(count: size)
        
        let recievedBytes = data.withUnsafeMutableBytes { (dataPointer: UnsafeMutablePointer<UInt8>) in
            recv(socket.fileDescriptor.rawValue, UnsafeMutableRawPointer(dataPointer), size, flags)
        }
        
        guard recievedBytes >= 0
            else { throw Errno(rawValue: errno) }
        
        return Data(data.prefix(recievedBytes))
    }
}

// MARK: - Supporting Types

public enum NetlinkSocketError: Error {
    
    case invalidProtocol
    case invalidSentBytes(Int)
    case invalidData(Data)
}
