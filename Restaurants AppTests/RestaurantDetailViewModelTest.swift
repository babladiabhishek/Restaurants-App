//
//  RestaurantDetailViewModelTest.swift
//  Restaurants AppTests
//
//  Created by Abhishek B on 2024-05-20.
//

import XCTest
import Combine
@testable import Restaurants_App

@MainActor
final class RestaurantsViewModelTests: XCTestCase {
    var viewModel: RestaurantsViewModel!
    var mockNetworkManager: MockNetworkAPIManager!
    var mockExecuter: MockHTTPRequestExecuter!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockExecuter = MockHTTPRequestExecuter()
        mockNetworkManager = MockNetworkAPIManager(executer: mockExecuter)
        viewModel = RestaurantsViewModel(networkManager: mockNetworkManager)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockNetworkManager = nil
        mockExecuter = nil
        try super.tearDownWithError()
    }

    func testFetchRestaurantsFailure() {
        let expectation = self.expectation(description: "Fetch Restaurants Failure")

        Task {
            // Given
            mockNetworkManager.shouldThrowError = true

            // When
            await viewModel.fetchRestaurants()

            // Then
            XCTAssertNotNil(viewModel.errorMessage)
            XCTAssertNil(viewModel.restaurants)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5)
    }

    func testFetchTagsSuccess() {
        let expectation = self.expectation(description: "Fetch Tags Success")

        Task {
            // Given
            let restaurant = Restaurant(
                name: "Wayne \"Chad Broski\" Burgers",
                imageURL: "Test Restaurant",
                id: "7450001",
                filterIDS: ["0017e59c-4407-453f-a5be-901695708015"],
                rating: 4.5,
                deliveryTimeMinutes: 30,
                tags: []
            )
            mockNetworkManager.mockRestaurants = [restaurant]
            let filter = Filter(name: "Fast Food", id: "0017e59c-4407-453f-a5be-901695708015", imageURL: "http://example.com/fast_food.png")
            mockNetworkManager.mockTags = ["0017e59c-4407-453f-a5be-901695708015": filter]
            await viewModel.fetchRestaurants()

            // When
            await viewModel.fetchTags()

            // Then
            XCTAssertEqual(viewModel.restaurants?.first?.tags.count, 1)
            XCTAssertEqual(viewModel.restaurants?.first?.tags.first?.name, "Fast Food")
            XCTAssertEqual(viewModel.tags.count, 1)
            XCTAssertEqual(viewModel.tags.first?.name, "Fast Food")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5)
    }

    func testFetchTagsFailure() {
        let expectation = self.expectation(description: "Fetch Tags Failure")

        Task {
            // Given
            let restaurant = Restaurant(
                name: "Wayne \"Chad Broski\" Burgers",
                imageURL: "Test Restaurant",
                id: "7450001",
                filterIDS: ["0017e59c-4407-453f-a5be-901695708015"],
                rating: 4.5,
                deliveryTimeMinutes: 30,
                tags: []
            )
            mockNetworkManager.mockRestaurants = [restaurant]
            mockNetworkManager.shouldThrowError = true
            await viewModel.fetchRestaurants()

            // When
            await viewModel.fetchTags()

            // Then
            XCTAssertNotNil(viewModel.errorMessage)
            XCTAssertEqual(viewModel.restaurants?.first?.tags.count, nil)
            XCTAssertEqual(viewModel.tags.count, 0)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5)
    }

    func testFilterRestaurants() {
        let expectation = self.expectation(description: "Filter Restaurants")

        Task {
            // Given
            let takeOutFilter = Filter(name: "Take-Out", id: "c67cd8a3-f191-4083-ad28-741659f214d7", imageURL: "https://food-delivery.umain.io/images/filter/filter_take_out.png")
            let fastFoodFilter = Filter(name: "Fast Food", id: "23a38556-779e-4a3b-a75b-fcbc7a1c7a20", imageURL: "https://food-delivery.umain.io/images/filter/filter_fast_food.png")

            let restaurant1 = Restaurant(
                name: "Wayne \"Chad Broski\" Burgers",
                imageURL: "https://food-delivery.umain.io/images/restaurant/burgers.png",
                id: "7450001",
                filterIDS: ["5c64dea3-a4ac-4151-a2e3-42e7919a925d", "614fd642-3fa6-4f15-8786-dd3a8358cd78", "c67cd8a3-f191-4083-ad28-741659f214d7", "23a38556-779e-4a3b-a75b-fcbc7a1c7a20"],
                rating: 4.6,
                deliveryTimeMinutes: 9,
                tags: [takeOutFilter, fastFoodFilter]
            )
            let restaurant2 = Restaurant(
                name: "Yuma´s Candyshop",
                imageURL: "https://food-delivery.umain.io/images/restaurant/candy.png",
                id: "7450002",
                filterIDS: ["5c64dea3-a4ac-4151-a2e3-42e7919a925d"],
                rating: 4.7,
                deliveryTimeMinutes: 45,
                tags: []
            )
            mockNetworkManager.mockRestaurants = [restaurant1, restaurant2]

            // Fetch restaurants
            await viewModel.fetchRestaurants()

            // Debug: Print fetched restaurants
            print("Fetched Restaurants: \(viewModel.restaurants ?? [])")
            XCTAssertEqual(viewModel.restaurants?.count, 2, "Expected to fetch 2 restaurants")

            // When filtering with "Take-Out" tag
            viewModel.filterRestaurants(by: "Take-Out")

            // Debug: Print filtered restaurants
            print("Filtered Restaurants: \(viewModel.restaurants ?? [])")
            XCTAssertEqual(viewModel.restaurants?.count, 1, "Expected 1 restaurant with 'Take-Out' filter")
            XCTAssertEqual(viewModel.restaurants?.first?.name, "Wayne \"Chad Broski\" Burgers")

            // When filtering with an empty tag name
            viewModel.filterRestaurants(by: "")

            // Debug: Print filtered restaurants for empty tag
            print("Filtered Restaurants (Empty Tag): \(viewModel.restaurants ?? [])")
            XCTAssertEqual(viewModel.restaurants?.count, 2, "Expected all restaurants when filtering with empty tag")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5)
    }

    func testPerformanceExample() throws {
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
