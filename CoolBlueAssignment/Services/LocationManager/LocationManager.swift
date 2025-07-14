//
//  LocationManager.swift
//  CoolBlueAssignment
//
//  Created by Tran Gia Huy on 7/13/25.
//

import CoreLocation
import Foundation
import Combine

protocol LocationManagerProtocol {
	func requestLocation()
	var userCurrentlocation: CurrentValueSubject<CLLocation?, Never> { get set }
}

class LocationManager: NSObject, LocationManagerProtocol {
	private let locationManager = CLLocationManager()
	private var canRequestLocation = false
	var userCurrentlocation: CurrentValueSubject<CLLocation?, Never> = CurrentValueSubject<CLLocation?, Never>(nil)
	
	override init() {
		super.init()
		locationManager.delegate = self
	}
	
	func requestLocation() {
		if canRequestLocation {
			locationManager.requestLocation()
		}
	}
}

extension LocationManager: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		switch status {
		case .authorizedAlways, .authorizedWhenInUse:
			canRequestLocation = true
			locationManager.requestLocation()
		case .notDetermined:
			canRequestLocation = false
			locationManager.requestWhenInUseAuthorization()
		case .denied, .restricted:
			canRequestLocation = false
		@unknown default:
			canRequestLocation = false
			locationManager.requestWhenInUseAuthorization()
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.first else {
			return
		}

		let userLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
		
		userCurrentlocation.send(userLocation)
	}

	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		// To do: maybe add a pop up
		print("Failed to find user's location: \(error.localizedDescription)")
	}
}

