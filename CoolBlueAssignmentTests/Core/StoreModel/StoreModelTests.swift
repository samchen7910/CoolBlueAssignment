//
//  StoreModelTests.swift
//  CoolBlueAssignment
//
//  Created by Tran Gia Huy on 7/14/25.
//
import Foundation
import Testing
@testable import CoolBlueAssignment


@MainActor
struct StoreModelTests {
	@Test("StoreModel Initialization with full data")
	func testInitializationWithFullData() async {
		let address = Address(
			city: "San Francisco",
			country: "USA",
			houseNumber: "123",
			postalCode: "94103",
			street: "Market Street",
			longitude: -122.4194,
			latitude: 37.7749
		)
		
		let openingHours = TodayOpeningHours(
			openingTime: "09:00",
			closeTime: "18:00"
		)
		
		let store = Store(
			id: "store_001",
			name: "Main Store",
			address: address,
			todayOpeningHours: openingHours
		)
			   
		#expect(store.id == "store_001")
		#expect(store.name == "Main Store")
			   
		#expect(store.address != nil)
		#expect(store.address?.city == "San Francisco")
		#expect(store.address?.country == "USA")
		#expect(store.address?.fullAddress == "Market Street 123\n94103, San Francisco USA")
			   
		#expect(store.address?.location != nil)
		#expect(store.address?.location.coordinate.latitude == 37.7749)
		#expect(store.address?.location.coordinate.longitude == -122.4194)
			   
		#expect(store.todayOpeningHours != nil)
		#expect(store.todayOpeningHours?.operatingTime == "09:00 - 18:00")
	}
	
	// Add more tests ...
}
