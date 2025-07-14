//
//  CoolBlueAssignmentApp.swift
//  CoolBlueAssignment
//
//  Created by Tran Gia Huy on 7/11/25.
//

import SwiftUI

@main
struct AppEntryPoint {
	static func main() {
		// Prevented unnecessary loading during test execution
		if NSClassFromString("XCTestCase") != nil {
			TestingApp.main()
		} else {
			CoolBlueAssignmentApp.main()
		}
	}
}

struct TestingApp: App {
	var body: some Scene {
		WindowGroup {
			Text("Testing ")
		}
	}
}

struct CoolBlueAssignmentApp: App {
	@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
	
    var body: some Scene {
        WindowGroup {
			StoresListView(viewModel: StoresListViewModel(container: delegate.dependencies.container))
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
	
	var dependencies: Dependencies!
	
	func application(_ application: UIApplication,
					 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		var config: BuildConfiguration
#if MOCK
		config = .mock
#elseif DEV
		config = .dev
#else
		config = .prod
#endif
		// override the real data with mock when run UITest
		if ProcessInfo.processInfo.arguments.contains("UI_TESTING") {
			config = .mock
		}
		
		dependencies = Dependencies(config: config)

		return true
	}
}

