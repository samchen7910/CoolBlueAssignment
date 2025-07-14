//
//  LocationManager.swift
//  CoolBlueAssignment
//
//  Created by Tran Gia Huy on 7/13/25.
//

import CoreLocation
import Foundation

protocol LocationManaging {
	
}

class LocationManager: NSObject {
	private let locationManager = CLLocationManager()
	private var canRequestLocation = false
	var userShortlocation: CLLocation? = nil
	
	override init() {
		super.init()
		locationManager.delegate = self
		
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
		case .denied, .notDetermined, .restricted:
			canRequestLocation = false
			// To do: pop up
		@unknown default:
			canRequestLocation = false
			// To do: pop up
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.first else {
			return
		}

		userShortlocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
	}

	 func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("Failed to find user's location: \(error.localizedDescription)")
	}
}
