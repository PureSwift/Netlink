import PackageDescription

#if os(macOS)
let nativeDependency: Target.Dependency = .Target(name: "DarwinWLAN")
#elseif os(Linux)
let nativeDependency: Target.Dependency = .Target(name: "LinuxWLAN")
#endif

let package = Package(
    name: "Netlink",
    targets: [
        Target(
            name: "Netlink"
        ),
        Target(
            name: "NetlinkGeneric",
            dependencies: [
                .Target(name: "Netlink")
                ]
        ),
        Target(
            name: "Netlink80211",
            dependencies: [
                .Target(name: "Netlink"),
                .Target(name: "NetlinkGeneric")
                ]
        )
    ],
    dependencies: [
        .Package(url: "https://github.com/PureSwift/CNetlink.git", majorVersion: 1)
    ],
    exclude: ["Xcode", "Carthage"]
)

#if swift(>=3.2)
#elseif swift(>=3.0)
package.dependencies.append(.Package(url: "https://github.com/PureSwift/Codable.git", majorVersion: 1))
#endif
