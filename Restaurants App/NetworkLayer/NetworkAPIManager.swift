//
//  NetworkAPIManager.swift
//  Restaurants App
//
//  Created by Abhishek B on 2024-05-14.
//

import Foundation
import Combine

class NetworkAPIManager: NetworkAPIProtocol {

    var executer: HTTPRequestProtocol

    init(executer: HTTPRequestProtocol) {
        self.executer = executer
    }

    static let shared = NetworkAPIManager(executer: HTTPRequestExecuter(timeoutInterval: 40))
    func getAllRestaurants() async throws -> [Restaurant] {
        do {
            let resultModel: ResultModel<[Restaurant]> = try await executer.performRequest(
                endpoint: ServiceEndPoint.getRestaurants,
                responseModel: ResultModel<[Restaurant]>.self,
                cachedResponseOnError: true)
            guard let restaurants = resultModel.restaurants else {
                return []
            }
            return restaurants
        } catch {
            throw error
        }
    }

    func getAllTags(for filterId: String) async throws -> Filter {
        do {
            
            let endPoint = ServiceEndPoint.getAllTags(filterId)

            let filter: Filter = try await executer.performRequest(
                endpoint: endPoint,
                responseModel: Filter.self,
                cachedResponseOnError: true)
            return filter
        } catch {
            throw error
        }
    }
    
    func getStatus(for restaurantId: String) async throws -> OpenStatus {
        do {
            let endPoint = ServiceEndPoint.getStatus(restaurantId)

            let status: OpenStatus = try await executer.performRequest(
                endpoint: endPoint,
                responseModel: OpenStatus.self,
                cachedResponseOnError: true
            )
            return status
        } catch {
            throw error
        }
    }
}
