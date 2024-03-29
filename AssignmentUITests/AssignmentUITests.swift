//
//  AssignmentUITests.swift
//  AssignmentUITests
//
//  Created by Himanshu Saraswat on 19/06/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import XCTest
@testable import Assignment

class AssignmentUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func testConatctListAndAddButtonSelection() {
        
        let app = XCUIApplication()
        app.navigationBars["Contact"].buttons["Add"].tap()
    }
    
    func testApplicationTitle() {
        let desireTitleName = "Contact"
        let app = XCUIApplication()
        let pageTitle =
            app.navigationBars.element.identifier
        XCTAssertEqual(pageTitle, desireTitleName)
    }
    
    func testGroupButtonAction() {
        let app = XCUIApplication()
        app.navigationBars["Contact"].buttons["Groups"].tap()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
}
