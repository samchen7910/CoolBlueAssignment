//
//  StoresListView.swift
//  CoolBlueAssignment
//
//  Created by Tran Gia Huy on 7/11/25.
//
import SwiftUI

struct StoresListView: View {
	@State var viewModel: StoresListViewModel
	
	var body: some View {
		NavigationStack {
			ScrollView(.vertical) {
				VStack {
					if viewModel.isLoading {
						ProgressView()
					} else if viewModel.stores.isEmpty {
						emptyView
					} else {
						ForEach(viewModel.stores, id: \.id) { store in
							StoreView(
								name: store.name,
								address: store.address?.fullAddress,
								todayOpeningHours: store.todayOpeningHours?.operatingTime
							)
						}
					}
				}
				.padding()
			}
			.navigationTitle("Stores")
		}
		.task {
			await viewModel.fetchStores()
		}
		.alert("Error", isPresented: Binding(ifNotNil: $viewModel.showDialog)) {
			Button("Dismiss") {}
		} message: {
			Text("\(viewModel.showDialog?.description ?? "")")
		}
	}
	
	
	private var emptyView: some View {
		VStack(spacing: 8) {
			Image(systemName: "storefront")
				.font(.title)
			Text("There are no stores available. 😿")
				.bold()
				.font(.body)
		}
	}
}


#Preview("StoresListView - Success") {
	let container = DependencyContainer()
	container.register(LocationManagerProtocol.self,service: LocationManager())
	container.register(NetworkManager.self, service: NetworkManager(networkService: NetworkServiceMock()))
	
	return StoresListView(viewModel: StoresListViewModel(container: container))
}


#Preview("StoresListView - Failed") {
	let container = DependencyContainer()
	container.register(LocationManagerProtocol.self,service: LocationManager())
	container.register(NetworkManager.self, service: NetworkManager(networkService: NetworkServiceMock(showError: NetworkServiceError.failedToFetchStoreList)))
	
	return StoresListView(viewModel: StoresListViewModel(container: container))

}

#Preview("StoresListView - Empty") {
	let container = DependencyContainer()
	container.register(LocationManagerProtocol.self,service: LocationManager())
	container.register(NetworkManager.self, service: NetworkManager(networkService: NetworkServiceMock(stores: [], showError: nil)))
	
	return StoresListView(viewModel: StoresListViewModel(container: container))

}
