#if canImport(Glibc)
import Glibc
#elseif canImport(Darwin)
import Darwin
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

@usableFromInline
internal func system_getpagesize() -> CInt {
  return getpagesize()
}
