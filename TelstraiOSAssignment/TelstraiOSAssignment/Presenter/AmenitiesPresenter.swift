//
//  AmenitiesPresenter.swift
//  TelstraiOSAssignment
//
//  Created by Saravanakumar on 14/07/18.
//  Copyright © 2018 Saravanakumar. All rights reserved.
//

import Foundation

class AmenitiesPresenter {
  //Service call to get JSON data from server
    func getAmenities(complete : @escaping (AmenitiesList)->(), error : @escaping (Error)->()) {
        let apiRequest = APIServiceCall()
        apiRequest.queryRequest { (isComplete, aminitiesList, errors) in
            if let err = errors
            {
                error(err) //Fails
            }
            if let aminitie = aminitiesList
            {
                complete(aminitie) //Success
            }
        }
    }
}
