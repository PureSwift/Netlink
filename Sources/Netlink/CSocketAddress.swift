import SystemPackage

internal protocol CSocketAddress {
    
    static var family: SocketAddressFamily { get }
}

internal extension CSocketAddress {
    
    @usableFromInline
    func withUnsafePointer<Result>(
        _ body: (UnsafePointer<CInterop.SocketAddress>, UInt32) throws -> Result
        ) rethrows -> Result {
        return try Swift.withUnsafeBytes(of: self) {
            return try body($0.baseAddress!.assumingMemoryBound(to:  CInterop.SocketAddress.self), UInt32(MemoryLayout<Self>.size))
        }
    }
}
