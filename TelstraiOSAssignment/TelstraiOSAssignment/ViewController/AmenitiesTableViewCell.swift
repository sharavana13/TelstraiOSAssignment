//
//  AmenitiesTableViewCell.swift
//  TelstraiOSAssignment
//
//  Created by Saravanakumar on 15/07/18.
//  Copyright © 2018 Saravanakumar. All rights reserved.
//

import Foundation
import UIKit
import SnapKit


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
        self.imgView?.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.left.equalTo(self.contentView.snp.left).offset(10.0)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        
        
        //Title view for tableview cell
        self.lblTitle = UILabel()
        self.lblTitle?.text = "Title"
        self.lblTitle?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        self.lblTitle?.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(self.lblTitle!)
        self.lblTitle?.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView.snp.top).offset(10.0)
            make.height.equalTo(22)
            make.left.equalTo((self.imgView?.snp.right)!).offset(10.0)
            make.right.equalTo(self.contentView.snp.right).offset(-5.0)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        //SubTitle view for tableview cell
        self.lblDescription = UILabel()
        self.lblDescription?.text = "Description"
        self.lblDescription?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        self.lblDescription?.numberOfLines = 0
        self.lblDescription?.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(self.lblDescription!)
        self.lblDescription?.snp.makeConstraints { (make) -> Void in
            make.top.equalTo((self.lblTitle?.snp.bottom)!).offset(10.0)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-5.0)
            make.left.equalTo((self.imgView?.snp.right)!).offset(10.0)
            make.right.equalTo(self.contentView.snp.right).offset(-5.0)
        }
        
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
