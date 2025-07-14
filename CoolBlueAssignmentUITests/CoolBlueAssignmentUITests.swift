//
//  CoolBlueAssignmentUITests.swift
//  CoolBlueAssignmentUITests
//
//  Created by Tran Gia Huy on 7/11/25.
//

import XCTest

final class CoolBlueAssignmentUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
		
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launchArguments = ["UI_TESTING"]
		app.launch()
		app.activate()
				
		let scrollViewsQuery = app.scrollViews
		scrollViewsQuery/*@START_MENU_TOKEN@*/.firstMatch/*[[".containing(.other, identifier: \"Vertical scroll bar, 4 pages\").firstMatch",".containing(.other, identifier: nil).firstMatch",".firstMatch"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
		scrollViewsQuery/*@START_MENU_TOKEN@*/.firstMatch/*[[".containing(.other, identifier: \"Vertical scroll bar, 3 pages\").firstMatch",".containing(.other, identifier: nil).firstMatch",".firstMatch"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()

    }

}
