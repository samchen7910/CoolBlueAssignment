//
//  NetworkService.swift
//  CoolBlueAssignment
//
//  Created by Tran Gia Huy on 7/14/25.
//

import SwiftUI
@preconcurrency import Apollo

protocol NetworkServiceProtocol: Sendable {
	func fetchStoreList() async throws -> [Store]
}

struct NetworkService: NetworkServiceProtocol {
	private let apolloClient: ApolloClient
	private let decoder = JSONDecoder()

	init() {
		let url = URL(string: baseUrl)!
		let configuration = URLSessionConfiguration.default
		configuration.httpAdditionalHeaders = [
			"Content-Type": "application/json",
			"Accept-Language": "en-nl"
		]

		let client = URLSessionClient(sessionConfiguration: configuration)
		let store = ApolloStore(cache: InMemoryNormalizedCache())

		let provider = DefaultInterceptorProvider(client: client, store: store)
		let transport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: url)
		
		apolloClient = ApolloClient(networkTransport: transport, store: store)
	}
	
	func fetchStoreList() async throws -> [Store] {
		try await withCheckedThrowingContinuation { continuation in
			apolloClient.fetch(query: StoreListQuery()) { result in
				switch result {
				case let .success(response):
					if let _ = response.errors {
						continuation.resume(throwing: NetworkServiceError.graphqlResponseError)
					}
					
					do {
						let json = response.asJSONDictionary()
						let data = try JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted])
						let storeListResponse = try self.decoder.decode(GraphqlStoreListResponse.self, from: data)
						continuation.resume(returning: storeListResponse.data.stores)
					} catch {
						continuation.resume(throwing: NetworkServiceError.failedToDecode)
					}
				case .failure:
					continuation.resume(throwing: NetworkServiceError.failedToFetchStoreList)
				}
			}
		}
	}
}
