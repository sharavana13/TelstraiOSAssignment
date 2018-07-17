//
//  TelstraiOSAssignmentTests.swift
//  TelstraiOSAssignmentTests
//
//  Created by Saravanakumar on 14/07/18.
//  Copyright © 2018 Saravanakumar. All rights reserved.
//

import XCTest
@testable import TelstraiOSAssignment

class TelstraiOSAssignmentTests: XCTestCase {
    
    var listVC: CityAmenitiesListViewController?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        listVC = storyboard.instantiateViewController(withIdentifier: "CityAmenitiesListViewController") as? CityAmenitiesListViewController
        XCTAssertNotNil(listVC, "MasterViewController not initiated properly")
        
        listVC?.performSelector(onMainThread: #selector(listVC?.loadView), with: nil, waitUntilDone: true)
        listVC?.performSelector(onMainThread: #selector(listVC?.viewDidLoad), with: nil, waitUntilDone: true)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK: - UITableView Testcases
    func testThatViewConformsToTableViewDelegate() {
        XCTAssertTrue(listVC!.conforms(to: UITableViewDelegate.self), "MasterViewController conforms to UITableViewDelegate")
    }
    
    func testThatViewConformsToTableViewDataSources() {
        XCTAssertTrue(listVC!.conforms(to: UITableViewDataSource.self), "MasterViewController conforms to UITableViewDataSources")
    }
    
    func testThatViewLoads() {
        XCTAssertNotNil(listVC, "masterViewController View not initiated properly")
    }
    
    
    func testThatTableViewLoads() {
        XCTAssertNotNil(listVC?.listTableView, "ListTableView not initiated")
    }
    
    func testAPICall()
    {
        XCTAssertNotNil(listVC?.callAPIservice(), "API not initiated")
    }
    

    func testPullToRefresh()
    {
        XCTAssertNotNil(listVC?.pullToRefreshData((listVC?.refreshControl)!), "Refresh controller not initiated properly")
    }
    
}
