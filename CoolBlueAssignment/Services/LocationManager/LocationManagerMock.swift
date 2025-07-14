//
//  LocationManagerMock.swift
//  CoolBlueAssignment
//
//  Created by Tran Gia Huy on 7/14/25.
//
import Combine
import CoreLocation

class LocationManagerMock: LocationManagerProtocol {
	
	private(set) var isRequestedLocation = false
	func requestLocation() {
		isRequestedLocation = true
	}
	
	var userCurrentlocation: CurrentValueSubject<CLLocation?, Never> = CurrentValueSubject<CLLocation?, Never>(nil)
}
