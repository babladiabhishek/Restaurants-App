//
//  ContentView.swift
//  Restaurants App
//
//  Created by Abhishek B on 2024-05-14.
//

import SwiftUI

struct RestaurantListView: View {
    @ObservedObject var viewModel: RestaurantsViewModel
    @EnvironmentObject private var coordinator: AppCoordinator
    
    @State private var selectedCategory: String?
    
    var body: some View {
        NavigationSplitView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(viewModel.tags, id: \.name) { tag in
                            FilterComponent(
                                isSelected: Binding(
                                    get: { selectedCategory == tag.name },
                                    set: { newValue in
                                        if newValue {
                                            selectedCategory = tag.name
                                            viewModel.filterRestaurants(by: tag.name)
                                        } else {
                                            selectedCategory = nil
                                            viewModel.filterRestaurants(by: "")
                                        }
                                    }
                                ),
                                filterName: tag.name,
                                imageUrl: tag.imageUrl
                            )
                        }
                    }
                    .padding(.leading)
                    .padding(.trailing)
                }
                
                List {
                    ForEach(viewModel.restaurants ?? [], id: \.id) { restaurant in
                        ZStack {
                            NavigationLink(destination: RestaurantDetailView(data: restaurant, viewModel: RestaurantDetailViewModel(networkManager: viewModel.networkManager))) {
                                EmptyView()
                            }
                            .opacity(0)
                            RestaurantRow(data: restaurant)
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Restaurants")
        } detail: {
            Text("Select a Restaurant")
        }
    }
}

struct RestaurantListView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantListView(viewModel: RestaurantsViewModel(networkManager: NetworkAPIManager.shared))
    }
}


