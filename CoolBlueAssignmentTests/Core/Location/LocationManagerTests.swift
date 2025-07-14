//
//  LocationManagerTests.swift
//  CoolBlueAssignment
//
//  Created by Tran Gia Huy on 7/14/25.
//



import Foundation
import CoreLocation
import Testing
@testable import CoolBlueAssignment

@MainActor
struct StoreListViewModelTests {
	@Test("Loaded store list success")
	func testFetchStoresSuccess() async {
		let locationManager = LocationManagerMock()
		let networkService = NetworkServiceMock(stores: Store.mocks)
		let networkManager = NetworkManager(networkService: networkService)
		let container = DependencyContainer()
		container.register(NetworkManager.self, service: networkManager)
		container.register(LocationManagerProtocol.self, service: locationManager)
		
		let viewModel = StoresListViewModel(container: container)
		
		await viewModel.fetchStores()
		
		#expect(viewModel.stores.count == Store.mocks.count)
	}
	
	@Test("Test load nearst stores sorted")
	func testLoadNearstStores() async {
		let locationManager = LocationManagerMock()
		
		let networkService = NetworkServiceMock(stores: Store.mocks)
		let networkManager = NetworkManager(networkService: networkService)
		let container = DependencyContainer()
		container.register(NetworkManager.self, service: networkManager)
		container.register(LocationManagerProtocol.self, service: locationManager)
		
		let viewModel = StoresListViewModel(container: container)
	
		await viewModel.fetchStores()
		
		let givenLocation = CLLocation(latitude: 1, longitude: 1)
		locationManager.userCurrentlocation.send(givenLocation)
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			#expect(viewModel.stores.first?.address?.longitude == givenLocation.coordinate.longitude)
			#expect(viewModel.stores.first?.address?.latitude == givenLocation.coordinate.latitude)
		}
	}
	
	
	@Test("Test user current location")
	func testRequestUserCurrentLocation() async {
		let locationManager = LocationManagerMock()
		
		let networkService = NetworkServiceMock(stores: Store.mocks)
		let networkManager = NetworkManager(networkService: networkService)
		let container = DependencyContainer()
		container.register(NetworkManager.self, service: networkManager)
		container.register(LocationManagerProtocol.self, service: locationManager)
		
		let viewModel = StoresListViewModel(container: container)
	
		await viewModel.fetchStores()
		
		#expect(locationManager.isRequestedLocation == true)
	}
	
	@Test("Test fetch store list failed")
	func testFetchStoreListFailed() async {
		let locationManager = LocationManagerMock()
		
		let networkService = NetworkServiceMock(showError: NetworkServiceError.failedToFetchStoreList)
		let networkManager = NetworkManager(networkService: networkService)
		let container = DependencyContainer()
		container.register(NetworkManager.self, service: networkManager)
		container.register(LocationManagerProtocol.self, service: locationManager)
		
		let viewModel = StoresListViewModel(container: container)
	
		await viewModel.fetchStores()
		
		#expect(viewModel.stores.isEmpty)
		#expect(viewModel.showDialog == NetworkServiceError.failedToFetchStoreList)
	}
	
}
