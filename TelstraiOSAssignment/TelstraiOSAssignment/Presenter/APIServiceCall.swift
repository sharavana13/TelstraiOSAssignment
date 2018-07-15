//
//  APIServiceCall.swift
//  TelstraiOSAssignment
//
//  Created by Saravanakumar on 14/07/18.
//  Copyright © 2018 Saravanakumar. All rights reserved.
//

import Foundation
let QUERY_URL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

class APIServiceCall {
    
    //API service call to get data
    func queryRequest(_ complete: @escaping (_ sucess:Bool, _ facts : AmenitiesList?,_ error : Error?)->()) {
        let query = "\(QUERY_URL)"
        print(query)
        URLSession.shared.dataTask(with: URL(string:query)!, completionHandler: { (data, response, error) in
            if let value = String(data: data!, encoding: String.Encoding.ascii) {
                if let jsonData = value.data(using: String.Encoding.utf8) {
                    do {
                        let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? Dictionary<String, AnyObject>
                        let aminitiesList = AmenitiesList.init(dict: dictionary!)
                        print(aminitiesList)
                        complete(true,aminitiesList,nil)
                    } catch {
                        NSLog("ERROR \(error.localizedDescription)")
                        complete(false,nil,error)
                    }
                }
            }
            
        }).resume()
    }
}
