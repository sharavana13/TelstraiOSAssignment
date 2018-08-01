//
//  APIServiceCallTest.swift
//  TelstraiOSAssignment
//
//  Created by Saravanakumar on 20/07/18.
//  Copyright © 2018 Saravanakumar. All rights reserved.
//

import XCTest
import SDWebImage
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
            XCTAssertTrue(amenitiesValue.rows.count > 0, "Service call success and data parsed")
            XCTAssertNil(amenitiesValue.rows.count == 0, "JSON Data List is nil")
            expect.fulfill()
        }) { (error) in
            XCTAssertNil(error, "Error should be nil")
            XCTAssertFalse(true)
            expect.fulfill()
        }
    }
    
    // This method test the time performance of Fact JSON URL Response.
    func testFactListResponseTime() {
        
        self.measure {
            
            // Initialize service call API
            let service = self.serviceCallAPI
            service?.getAmenities(complete: { (amenitiesValue) in
                XCTAssertTrue(amenitiesValue.rows.count > 0, "Service call success and data parsed")
                XCTAssertNil(amenitiesValue.rows.count == 0, "JSON Data List is nil")
            }) { (error) in
                XCTAssertNil(error, "Error should be nil")
            }
        }
    }
    
    
    func testNetworkReachability(){
        if(Reachability.isConnectedToNetwork()){
            XCTAssertTrue(true, "Network reachable")
        }else{
            XCTAssertFalse(false)
        }
    }
    
    func testImageLoad(){
        // Given A apiservice
        let service = self.serviceCallAPI
        
        // When fetch popular photo
        let expect = XCTestExpectation(description: "imageLoad")
        service?.getAmenities(complete: { (amenitiesValue) in
            XCTAssertTrue(amenitiesValue.rows.count > 0, "Service call success and data parsed")
            XCTAssertNil(amenitiesValue.rows.count == 0, "JSON Data List is nil")
            if (amenitiesValue.rows.count > 0){
                for listValue in amenitiesValue.rows
                {
                    let imgView = UIImageView()
                    imgView.contentMode = .scaleAspectFit
                    imgView.translatesAutoresizingMaskIntoConstraints = false
                    imgView.sd_setImage(with: URL(string: listValue.imageURL), placeholderImage: #imageLiteral(resourceName: "ImagePlaceholder"), options: SDWebImageOptions.retryFailed, completed: nil)
                    imgView.sd_setHighlightedImage(with: URL(string: listValue.imageURL), options: SDWebImageOptions.retryFailed, completed: { image, error, cacheType, imageURL in
                        if image != nil{
                            XCTAssertTrue(true, "Image Downloaded Successfully")
                        }else{
                            XCTFail("Image failed to download")
                        }
                    })
                }
            }else{
                XCTFail("API Call Fails")
            }
            expect.fulfill()
        }) { (error) in
            XCTAssertNil(error, "Error should be nil")
        }
    }
}
