//
//  RestaurantDetailViewModel.swift
//  Restaurants App
//
//  Created by Abhishek B on 2024-05-20.
//


import Combine
import SwiftUI

@MainActor
final class RestaurantDetailViewModel: ObservableObject {
    @Published var status:  String = ""
    @Published var errorMessage: String?
    
    var networkManager: NetworkAPIManager
    var openStatus: String {
        return status
    }
    var statusColor: Color {
        switch status {
        case "Open":
            return ColorManager.positiveColor
        case "Closed":
            return ColorManager.negativeColor
        default:
            return Color.gray
        }
    }
    
    init(networkManager: NetworkAPIManager) {
        self.networkManager = networkManager
    }
    
    func fetchStatus(for restaurandID: String) async {
        do {
            let fetchedStatus = try await networkManager.getStatus(for: restaurandID)
            self.status = fetchedStatus.description
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
