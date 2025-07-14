//
//  NetworkManager.swift
//  CoolBlueAssignment
//
//  Created by Tran Gia Huy on 7/11/25.
//
import SwiftUI

@MainActor
@Observable
class NetworkManager {
	private let networkService: NetworkServiceProtocol
	
	init(networkService: NetworkServiceProtocol) {
		self.networkService = networkService
	}
	
	func fetch() async throws -> [Store]{
		try await networkService.fetchStoreList()
	}
}



