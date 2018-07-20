//
//  APIServiceCallTest.swift
//  TelstraiOSAssignment
//
//  Created by Saravanakumar on 20/07/18.
//  Copyright © 2018 Saravanakumar. All rights reserved.
//

import XCTest
@testable import TelstraiOSAssignment

class APIServiceCallTest: XCTestCase {
    var serviceCallAPI: APIServiceCall?
    var reachablity: Reachability?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRequest() {
        
        // Given A apiservice
        let service = self.serviceCallAPI
        
        // When fetch popular photo
        let expect = XCTestExpectation(description: "callback")
        service?.getAmenities(complete: { (amenitiesValue) in
            XCTAssertNotNil(amenitiesValue.rows.count > 0)
            expect.fulfill()
        }) { (error) in
            XCTAssertNil(error, "Error should be nil")
        }
    }
    
}
