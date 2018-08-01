//
//  APIServiceCall.swift
//  TelstraiOSAssignment
//
//  Created by Saravanakumar on 14/07/18.
//  Copyright © 2018 Saravanakumar. All rights reserved.
//

import Foundation


class APIServiceCall {
    
    func getAmenities(complete : @escaping (AmenitiesList)->(), error : @escaping (Error)->()) {
        self.queryRequest { (isComplete, aminitiesList, errors) in
            if let err = errors{
                error(err) //Fails
            }
            if let aminitie = aminitiesList{
                complete(aminitie) //Success
            }
        }
    }
    
    //API service call to get data
    func queryRequest(_ complete: @escaping (_ sucess:Bool, _ facts : AmenitiesList?,_ error : Error?)->()) {
        let query = "\(Constants.REQUEST_URL)"
        print(query)
        URLSession.shared.dataTask(with: URL(string:query)!, completionHandler: { (data, response, error) in
            if let responseData = data {
                if let value = String(data: responseData, encoding: String.Encoding.ascii) {
                    if let jsonData = value.data(using: String.Encoding.utf8) {
                        do {
                            let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? Dictionary<String, AnyObject>
                            let amenitiesList = AmenitiesList.init(dict: dictionary!)
                            print(amenitiesList)
                            complete(true,amenitiesList,nil)
                        } catch {
                            NSLog("ERROR \(error.localizedDescription)")
                            complete(false,nil,error)
                        }
                    }
                }
            }
            else{
                NSLog("ERROR \(String(describing: error?.localizedDescription))")
                complete(false,nil,error)
            }
        }).resume()
    }
}
