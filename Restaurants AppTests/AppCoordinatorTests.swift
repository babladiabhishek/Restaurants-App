//
//  AppCoordinatorTests.swift
//  Restaurants AppTests
//
//  Created by Abhishek B on 2024-05-28.
//

import XCTest
@testable import Restaurants_App

class AppCoordinatorTests: XCTestCase {

    var coordinator: AppCoordinator!

    override func setUp() {
        super.setUp()
        coordinator = AppCoordinator(networkManager: NetworkAPIManager.shared)
    }

    override func tearDown() {
        coordinator = nil
        super.tearDown()
    }

    func testPush() {
        // Initial path should be empty
        XCTAssertEqual(coordinator.path.count, 0)

        // Push a new page
        coordinator.push(.landingPage)
        XCTAssertEqual(coordinator.path.count, 1)
    }

    func testPop() {
        // Push a new page and then pop it
        coordinator.push(.landingPage)
        XCTAssertEqual(coordinator.path.count, 1)

        coordinator.pop()
        XCTAssertEqual(coordinator.path.count, 0)
    }

    func testPopToRoot() {
        // Push multiple pages and then pop to root
        coordinator.push(.landingPage)
        coordinator.push(.landingPage)
        XCTAssertEqual(coordinator.path.count, 2)

        coordinator.popToRoot()
        XCTAssertEqual(coordinator.path.count, 0)
    }
}
