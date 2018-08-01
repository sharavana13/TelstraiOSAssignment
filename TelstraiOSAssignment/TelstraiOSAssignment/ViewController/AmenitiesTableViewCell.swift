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
    
    lazy var imgView : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    lazy var lblTitle: UILabel = {
        let lblTitle = UILabel()
        lblTitle.text = ""
        lblTitle.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        return lblTitle
    }()
    
    lazy var lblDescription: UILabel = {
        let lblDescription = UILabel()
        lblDescription.text = ""
        lblDescription.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lblDescription.numberOfLines = 0
        lblDescription.translatesAutoresizingMaskIntoConstraints = false
        return lblDescription
    }()
    
   
    
    
    // Initialization methods
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.loadSubViews()
        
    }
    
    func loadSubViews() {
        //Add Image view to tableview cell
        contentView.addSubview(self.imgView)
        self.imgView.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.left.equalTo(self.contentView.snp.left).offset(10.0)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        //Add title lable to tableview cell
        contentView.addSubview(self.lblTitle)
        self.lblTitle.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView.snp.top).offset(10.0)
            make.height.equalTo(22)
            make.left.equalTo(self.imgView.snp.right).offset(10.0)
            make.right.equalTo(self.contentView.snp.right).offset(-5.0)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        //Add description lable to tableview cell
        contentView.addSubview(self.lblDescription)
        self.lblDescription.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.lblTitle.snp.bottom).offset(10.0)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-5.0)
            make.left.equalTo(self.imgView.snp.right).offset(10.0)
            make.right.equalTo(self.contentView.snp.right).offset(-5.0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
