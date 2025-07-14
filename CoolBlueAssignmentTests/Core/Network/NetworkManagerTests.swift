//
//  NetworkManagerTests.swift
//  CoolBlueAssignmentTests
//
//  Created by Tran Gia Huy on 7/14/25.
//

import Foundation
import Testing
@testable import CoolBlueAssignment

@MainActor
struct NetworkManagerTests {
	@Test("Load store list success")
	func testLoadStoreListSuccess() async throws {
		let mocks = Store.mocks
		let networkService = NetworkServiceMock(stores: mocks)
		let networkManager = NetworkManager(networkService: networkService)
		let result = try await networkManager.fetch()
		#expect(result.count == mocks.count)
	}
	
	@Test("Load store list unsuccess")
	func testLoadStoreListUnsuccess() async {
		let expectedError = NetworkServiceError.failedToFetchStoreList
		let networkService = NetworkServiceMock(showError: expectedError)
		let networkManager = NetworkManager(networkService: networkService)
		do {
			let _ = try await networkManager.fetch()
		} catch {
			if let error = error as? NetworkServiceError {
				#expect(error == expectedError)
			}
		}
	}
	
	@Test("Failed to decode")
	func testFailedToDecode() async {
		let expectedError = NetworkServiceError.failedToDecode
		let networkService = NetworkServiceMock(showError: expectedError)
		let networkManager = NetworkManager(networkService: networkService)
		do {
			let _ = try await networkManager.fetch()
		} catch {
			if let error = error as? NetworkServiceError {
				#expect(error == expectedError)
			}
		}
	}
	
	// Add more tests ...
}

