//
//  Store.swift
//  CoolBlueAssignment
//
//  Created by Tran Gia Huy on 7/11/25.
//
import Foundation
import CoreLocation

struct GraphqlStoreListResponse: Codable {
	let data: StoreList
}

struct StoreList: Codable {
	let stores: [Store]
}

struct Store: Codable, Identifiable {
	let id: String?
	let name: String?
	let address: Address?
	let todayOpeningHours: TodayOpeningHours?
}

struct Address:Codable {
	let city: String?
	let country: String?
	let houseNumber: String?
	let postalCode: String?
	let street: String?
	let longitude: Double?
	let latitude: Double?
	
	var location: CLLocation {
		if let latitude, let longitude {
			return CLLocation(latitude: latitude, longitude: longitude)
		} else {
			return CLLocation(latitude: 0, longitude: 0)
		}
	}
	
	var fullAddress: String {
		return "\(street ?? "") \(houseNumber ?? "")\n\(postalCode ?? ""), \(city ?? "") \(country ?? "")"
	}
}

struct TodayOpeningHours: Codable {
	let openingTime: String?
	let closeTime: String?
	
	var operatingTime: String {
		return "\(openingTime ?? "N/A") - \(closeTime ?? "N/A")"
	}
}

extension Store {
	static var mocks: [Store] {
		[Store(
			id: "1",
			name: "Rotterdam Oostplein",
			address: Address(
				city: "Rotterdam",
				country: "NL",
				houseNumber: "97",
				postalCode: "1234BC",
				street: "Burgerstraat",
				longitude: 0,
				latitude: 0
			),
			todayOpeningHours: TodayOpeningHours(
				openingTime: "9:00:00",
				closeTime: "17:00:00"
			)
		),
		 Store(
			 id: "2",
			 name: "Amsterdam Zuid",
			 address: Address(
				 city: "Amsterdam",
				 country: "NL",
				 houseNumber: "12",
				 postalCode: "6661AA",
				 street: "Visstraat",
				 longitude: 1,
				 latitude: 1
			 ),
			 todayOpeningHours: TodayOpeningHours(
				 openingTime: "9:00:00",
				 closeTime: "17:00:00"
			 )
		 )
		]
	}
}

