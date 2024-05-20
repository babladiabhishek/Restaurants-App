//
//  NetworkAPIProtocol.swift
//  Restaurants App
//
//  Created by Abhishek B on 2024-05-14.
//

import Foundation
import Combine

protocol NetworkAPIProtocol {
    func getAllRestaurants() async throws -> [Restaurant]
    func getAllTags(for filterId: String) async throws -> Filter
    func getStatus(for restaurantID: String) async throws -> OpenStatus
}
