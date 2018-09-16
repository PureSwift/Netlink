import XCTest
@testable import NetlinkTests
@testable import NetlinkGenericTests
@testable import Netlink80211Tests

XCTMain([
    testCase(NetlinkTests.allTests),
    testCase(Netlink80211Tests.allTests),
    testCase(NetlinkGenericTests.allTests)
])
