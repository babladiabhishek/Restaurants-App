//
//  MockNetworkAPIManager.swift
//  Restaurants App
//
//  Created by Abhishek B on 2024-05-20.
//

import Foundation
class MockNetworkAPIManager: NetworkAPIManager {
    var mockRestaurants: [Restaurant] = []
    var mockTags: [String: Filter] = [:]
    var mockStatus: OpenStatus?
    var shouldThrowError: Bool = false

    override func getAllRestaurants() async throws -> [Restaurant] {
        if shouldThrowError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        return mockRestaurants
    }

    override func getAllTags(for filterId: String) async throws -> Filter {
        if shouldThrowError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        guard let tag = mockTags[filterId] else {
            throw NSError(domain: "TestError", code: 2, userInfo: nil)
        }
        return tag
    }

    override func getStatus(for restaurantId: String) async throws -> OpenStatus {
        if shouldThrowError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        return mockStatus ?? OpenStatus(isCurrentlyOpen: true, restaurantID: restaurantId)
    }
}

class MockHTTPRequestExecuter: HTTPRequestProtocol {
    var mockResponse: Any?
    var shouldThrowError: Bool = false

    func performRequest<T>(endpoint: any Restaurants_App.EndPointTarget, responseModel: T.Type, cachedResponseOnError: Bool) async throws -> T where T : Decodable, T : Encodable {
        if shouldThrowError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        guard let response = mockResponse as? T else {
            throw NSError(domain: "TestError", code: 2, userInfo: nil)
        }
        return response
    }
}
