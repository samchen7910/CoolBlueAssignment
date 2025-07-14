//
//  DependencyContainer.swift
//  CoolBlueAssignment
//
//  Created by Tran Gia Huy on 7/11/25.
//
import SwiftUI

@Observable
@MainActor
class DependencyContainer {
	private var services: [String: Any] = [:]
	
	func register<T>(_ type: T.Type, service: T) {
		let key = "\(type)"
		services[key] = service
	}
	
	func register<T>(_ type: T.Type, service: () -> T) {
		let key = "\(type)"
		services[key] = service()
	}
	
	func resolve<T>(_ type: T.Type) -> T? {
		let key = "\(type)"
		return services[key] as? T
	}
}

@MainActor
struct Dependencies {
	let container: DependencyContainer

	init(config: BuildConfiguration) {
		self.container = DependencyContainer()

		switch config {
		case .mock:
			let networkManager = NetworkManager(networkService: NetworkServiceMock())
			container.register(NetworkManager.self, service: networkManager)
			
			let locationManager = LocationManager()
			container.register(LocationManager.self, service: locationManager)
		case .dev:
			let networkManager = NetworkManager(networkService: NetworkService())
			container.register(NetworkManager.self, service: networkManager)
			
			let locationManager = LocationManager()
			container.register(LocationManager.self, service: locationManager)
		case .prod:
			let networkManager = NetworkManager(networkService: NetworkService())
			container.register(NetworkManager.self, service: networkManager)
			
			let locationManager = LocationManager()
			container.register(LocationManager.self, service: locationManager)
		}
	}
}

