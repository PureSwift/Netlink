#if canImport(Darwin)
import Darwin
#elseif os(Linux) || os(Android)
import Glibc
#endif
import SystemPackage

@usableFromInline
internal func system_getpid() -> CInterop.ProcessID {
  return getpid()
}

@usableFromInline
internal func system_getppid() -> CInterop.ProcessID {
  return getppid()
}
