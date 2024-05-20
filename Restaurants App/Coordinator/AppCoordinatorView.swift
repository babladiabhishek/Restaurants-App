//
//  AppCoordinatorView.swift
//  Restaurants App
//
//  Created by Abhishek B on 2024-05-14.
//

import SwiftUI

struct AppCoordinatorView: View {

    @StateObject private var coordinator = AppCoordinator(networkManager: NetworkAPIManager.shared)

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .landingPage)
                .navigationDestination(for: Page.self) { page in
                    coordinator.build(page: page)
                }
        }
        .environmentObject(coordinator)
    }
}

#Preview {
    AppCoordinatorView()
}
