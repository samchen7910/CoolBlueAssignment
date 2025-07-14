
struct NetworkServiceMock: NetworkServiceProtocol {
	let stores: [Store]
	let showError: NetworkServiceError?
	
	init(stores: [Store] = Store.mocks, showError: NetworkServiceError? = nil) {
		self.stores = stores
		self.showError = showError
	}
	
	private func tryShowError() throws {
		if let showError {
			throw showError
		}
	}
	
	func fetchStoreList() async throws -> [Store] {
		try tryShowError()
		return stores
	}
}
