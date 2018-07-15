//
//  AmenitiesTableViewCell.swift
//  TelstraiOSAssignment
//
//  Created by Saravanakumar on 15/07/18.
//  Copyright © 2018 Saravanakumar. All rights reserved.
//

import Foundation
import UIKit


class AmenitiesTableViewCell: UITableViewCell {
    
    //MARK: Subviews
    //Add subView Programmatically
    var imgView: UIImageView?
    var lblTitle: UILabel?
    var lblDescription: UILabel?
    
    
    // Initialization methods
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Image view for tableview cell
        self.imgView = UIImageView()
        self.imgView?.contentMode = .scaleAspectFit
        self.imgView?.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(self.imgView!)
        self.imgView?.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10.0).isActive = true
        self.imgView?.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10.0).isActive = true
        self.imgView?.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.imgView?.widthAnchor.constraint(equalToConstant: 50).isActive = true
       
        
        //Title view for tableview cell
        self.lblTitle = UILabel()
        self.lblTitle?.text = "Title"
        self.lblTitle?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        self.lblTitle?.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(self.lblTitle!)
        self.lblTitle?.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10.0).isActive = true
        self.lblTitle?.heightAnchor.constraint(equalToConstant: 22).isActive = true
        self.lblTitle?.leftAnchor.constraint(equalTo: (self.imgView?.rightAnchor)!, constant: 10.0).isActive = true
        self.lblTitle?.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -5.0).isActive = true
        
        
        self.lblDescription = UILabel()
        self.lblDescription?.text = "Description"
        self.lblDescription?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        self.lblDescription?.numberOfLines = 0
        self.lblDescription?.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(self.lblDescription!)
        self.lblDescription?.topAnchor.constraint(equalTo: (self.lblTitle?.bottomAnchor)!, constant: 5.0).isActive = true
        self.lblDescription?.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5.0).isActive = true
        self.lblDescription?.leftAnchor.constraint(equalTo: (self.imgView?.rightAnchor)!, constant: 10.0).isActive = true
        self.lblDescription?.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -5.0).isActive = true
        contentView.addSubview(self.lblDescription!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //self.imgView?.image = nil
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
