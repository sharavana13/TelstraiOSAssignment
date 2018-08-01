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
        listVC = CityAmenitiesListViewController()
        XCTAssertNotNil(listVC, "MasterViewController not initiated properly")
        
        listVC?.performSelector(onMainThread: #selector(listVC?.loadView), with: nil, waitUntilDone: true)
        listVC?.performSelector(onMainThread: #selector(listVC?.viewDidLoad), with: nil, waitUntilDone: true)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    // MARK: - UITableView Testcases
    func testThatViewConformsToTableViewDelegate() {
        XCTAssertTrue(listVC!.conforms(to: UITableViewDelegate.self), "MasterViewController conforms to UITableViewDelegate")
    }
    
    func testThatViewConformsToTableViewDataSources() {
        XCTAssertTrue(listVC!.conforms(to: UITableViewDataSource.self), "MasterViewController conforms to UITableViewDataSources")
    }
    

    func testPullToRefresh(){
        XCTAssertNotNil(listVC?.pullToRefreshData((listVC?.refreshControl)!), "Refresh controller not initiated properly")
    }
    
   
    
}
