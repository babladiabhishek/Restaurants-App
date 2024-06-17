//
//  RestaurantsViewModel.swift
//  Restaurants App
//
//  Created by Abhishek B on 2024-05-14.
//

import Combine
import SwiftUI

@MainActor
final class RestaurantsViewModel: ObservableObject {
    @Published var restaurants: [Restaurant]?
    @Published var errorMessage: String?
    @Published var tags: [(name: String, imageUrl: String)] = []
    
    private var allRestaurants: [Restaurant] = []
    var networkManager: NetworkAPIManager
    
    init(networkManager: NetworkAPIManager) {
        self.networkManager = networkManager
        Task {
            await fetchRestaurants()
        }
    }
    
    func fetchRestaurants() async {
        do {
            let fetchedRestaurants = try await networkManager.getAllRestaurants()
            self.allRestaurants = fetchedRestaurants
            self.restaurants = fetchedRestaurants
            await fetchTags()
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    func fetchTags() async {
        guard var fetchedRestaurants = self.restaurants else { return }
        
        do {
            var allTagsDict = [String: Filter]()
            var filterIds = [String]()
            for restaurant in fetchedRestaurants {
                filterIds.append(contentsOf: restaurant.filterIDS)
            }
            
            let uniqueFilterIds = Array(Set(filterIds))
            
            for filterId in uniqueFilterIds {
                let tag = try await networkManager.getAllTags(for: filterId)
                allTagsDict[filterId] = tag
            }
            
            for restaurant in 0..<fetchedRestaurants.count {
                let filterIDS = fetchedRestaurants[restaurant].filterIDS
                let tags = filterIDS.compactMap { allTagsDict[$0] }
                fetchedRestaurants[restaurant].tags = tags
            }
            
            // Extract unique tags and their images
            var uniqueTags: Set<Filter> = Set()
            for tag in allTagsDict.values {
                uniqueTags.insert(tag)
            }
            
            let tagsWithImages = uniqueTags.map { (name: $0.name, imageUrl: $0.imageURL) }
            
            DispatchQueue.main.async {
                self.restaurants = fetchedRestaurants
                self.allRestaurants = fetchedRestaurants
                self.tags = tagsWithImages
            }
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    func filterRestaurants(by tagName: String) {
        if tagName.isEmpty {
            self.restaurants = allRestaurants
        } else {
            self.restaurants = allRestaurants.filter { restaurant in
                let hasTag = restaurant.tags.contains { $0.name == tagName }
                return hasTag
            }
        }
    }
}
