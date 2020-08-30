//
//  CarFaxUITests.swift
//  CarFaxUITests
//
//  Created by Nithin on 27/08/20.
//  Copyright © 2020 Nithin. All rights reserved.
//

import XCTest

class CarFaxUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testAppLauch() {
        
        let carFax = XCUIApplication()
        carFax.launch()
    }
    
    func testVehicleListSwipe() {

    }
    
    func testVehicleSelect() {

        let carFax = XCUIApplication()
        carFax.launch()
        
        carFax.collectionViews/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"2020 - Acura TLX Technology")/*[[".cells.containing(.button, identifier:\"(833) 498 0574\")",".cells.containing(.staticText, identifier:\"$31,985 |  1K Mi | Manassas, VA\")",".cells.containing(.staticText, identifier:\"2020 - Acura TLX Technology\")"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .other).element.tap()
    }
    
    func testDetailViewController() {
        
        let carFax = XCUIApplication()
        carFax.launch()
        
        carFax.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["2020 - Acura TLX Technology"]/*[[".cells.staticTexts[\"2020 - Acura TLX Technology\"]",".staticTexts[\"2020 - Acura TLX Technology\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        carFax.navigationBars["Details"].buttons["Car Fax"].tap()
    }
}
