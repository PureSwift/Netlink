#if canImport(Glibc)
import Glibc
#elseif canImport(Darwin)
import Darwin
#endif
#if canImport(System)
import System
#else
import SystemPackage
#endif

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
