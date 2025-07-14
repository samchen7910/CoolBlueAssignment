class LocationManagerMock: LocationManagerProtocol {
	
	private(set) var isRequestedLocation = false
	func requestLocation() {
		isRequestedLocation = true
	}
	
	var userCurrentlocation: CurrentValueSubject<CLLocation?, Never> = CurrentValueSubject<CLLocation?, Never>(nil)
}
