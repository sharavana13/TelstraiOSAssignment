//
//  AmenitiesModel.swift
//  TelstraiOSAssignment
//
//  Created by Saravanakumar on 14/07/18.
//  Copyright © 2018 Saravanakumar. All rights reserved.
//

import Foundation

//Aminitie detail structure
struct Amenities
{
    var title : String
    var description : String
    var imageURL : String
    
    init(dict : Dictionary<String,AnyObject>) {
        self.title = dict["title"] as? String ?? "No Title Available"
        self.description = dict["description"] as? String ?? "No Description Available"
        self.imageURL = dict["imageHref"] as? String ?? ""
    }
}

//Aminities list structure
struct AmenitiesList {
    var title : String
    var rows : [Amenities]
    
    init(dict : Dictionary<String,AnyObject>) {
        self.title = dict["title"] as? String ?? "";
        let arrayOfRows = dict["rows"] as? [[String:AnyObject]] ?? []
        self.rows = arrayOfRows.map(Amenities.init)
        
    }
}
