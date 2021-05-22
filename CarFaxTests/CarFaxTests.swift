//
//  CarFaxTests.swift
//  CarFaxTests
//
//  Created by Nithin on 27/08/20.
//  Copyright © 2020 Nithin. All rights reserved.
//

import XCTest
@testable import CarFax

class CarFaxTests: XCTestCase {

    var utilities = Utilities()
    
    override func setUp() {
        
       
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testPriceFormatter() {
        
        XCTAssertNotNil(utilities.getCurrenyFormat(12))
        XCTAssertEqual(utilities.getCurrenyFormat(0), "$0")
        XCTAssertEqual(utilities.getCurrenyFormat(23), "$23")
        XCTAssertEqual(utilities.getCurrenyFormat(898), "$898")
        XCTAssertEqual(utilities.getCurrenyFormat(33451), "$33,451")
    }
    
    func testMileageFormatter() {
        
        XCTAssertNotNil(utilities.getMileageFormat(12))
        XCTAssertEqual(utilities.getMileageFormat(0), "0K")
        XCTAssertEqual(utilities.getMileageFormat(2324), "2K")
        XCTAssertEqual(utilities.getMileageFormat(45600), "45K")
        XCTAssertEqual(utilities.getMileageFormat(89890), "89K")
    }
}
