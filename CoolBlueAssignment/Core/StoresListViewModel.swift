@Observable
@MainActor
class StoresListViewModel {
	private let locationManager: LocationManager
	private let networkManager: NetworkManager
	
	var stores: [Store] = []
	
	init(container: DependencyContainer) {
		self.locationManager = container.resolve(LocationManager.self)!
		self.networkManager = container.resolve(NetworkManager.self)!
	}
	
	func fetchStores() async {
		do {
			stores = try await networkManager.fetch()
		} catch {
			
		}
	}
}
