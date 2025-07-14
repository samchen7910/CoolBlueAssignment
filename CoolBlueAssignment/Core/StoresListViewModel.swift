//
//  StoresListViewModel.swift
//  CoolBlueAssignment
//
//  Created by Tran Gia Huy on 7/14/25.
//
import SwiftUI
import Combine
import CoreLocation

@Observable
@MainActor
class StoresListViewModel {
	private let locationManager: LocationManagerProtocol
	private let networkManager: NetworkManager
	private var cancellables = Set<AnyCancellable>()

	private(set) var isLoading: Bool = false
	private(set) var stores: [Store] = []

	var showDialog: NetworkServiceError? = nil

	init(container: DependencyContainer) {
		self.locationManager = container.resolve(LocationManagerProtocol.self)!
		self.networkManager = container.resolve(NetworkManager.self)!
		
		requestLocation()
		observeLocationUpdates()
	}
	
	private func requestLocation() {
		locationManager.requestLocation()
	}
	
	func fetchStores() async  {
		do {
			let stores = try await networkManager.fetch()
			self.stores = stores
		} catch {
			showDialog = error as? NetworkServiceError
		}
		
		isLoading = false
	}
	
	private func sortedNearestStores(with userLocation: CLLocation) {
		
		let sorted = stores.sorted {
			userLocation.distance(from: $0.address!.location) < userLocation.distance(from: $1.address!.location)
		}
		
		stores = sorted
	}
	
	private func observeLocationUpdates() {
		locationManager.userCurrentlocation.receive(on: DispatchQueue.main).sink { result in
			switch result {
			case .finished:
				break
			case .failure:
				self.showDialog = NetworkServiceError.failedToGetUserLocation
			}
		} receiveValue: { [weak self] userLocation in
			guard let self = self else {
				   return
			}
			if let userLocation {
				sortedNearestStores(with: userLocation)
			}
		}.store(in: &cancellables)
	}
}
