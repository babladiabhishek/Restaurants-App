import Foundation
import SwiftUI

enum Page: String, Identifiable {
    case landingPage

    var id: String {
        self.rawValue
    }
}

class AppCoordinator: ObservableObject {

    @Published var path = NavigationPath()
    private let networkManager: NetworkAPIManager

    init(networkManager: NetworkAPIManager) {
        self.networkManager = networkManager
    }

    func push(_ page: Page) {
        path.append(page)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }

    @MainActor @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .landingPage:
            RestaurantListView(viewModel: RestaurantsViewModel(networkManager: networkManager))
        }
    }
}
