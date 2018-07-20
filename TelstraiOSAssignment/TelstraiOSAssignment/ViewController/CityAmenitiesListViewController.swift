//
//  CityAmenitiesListViewController.swift
//  TelstraiOSAssignment
//
//  Created by Saravanakumar on 14/07/18.
//  Copyright © 2018 Saravanakumar. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class CityAmenitiesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var listTableView : UITableView?
    var amenitiesList : AmenitiesList?
    var serviceCall = APIServiceCall()
    
    
    //refresh control to reload data
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.pullToRefreshData(_:)),
                                 for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()
    
    
    //loader Indicator
    lazy var activityIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.isHidden = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    //MARK: View delegate methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = Constants.NAVIGATION_BAR_TITLE
        
        //Add tableViewController programatically
        self.listTableView = UITableView()
        self.listTableView?.register(AmenitiesTableViewCell.self, forCellReuseIdentifier: Constants.CELL_IDENTIFIER)
        self.listTableView?.delegate = self
        self.listTableView?.dataSource = self
        self.listTableView?.estimatedRowHeight = 44
        self.listTableView?.rowHeight = UITableViewAutomaticDimension
        self.listTableView?.translatesAutoresizingMaskIntoConstraints = false
        self.listTableView?.addSubview(self.refreshControl)
        self.view.addSubview(self.listTableView!)
        self.view.addSubview(self.activityIndicator)
        
        //Autolayout for tableview using snapkit(Masonry)
        self.listTableView?.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        self.listTableView?.tableFooterView = UIView()
        activityIndicator.center = self.view.center
        self.callAPIservice()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITableView DataSource and Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let value = self.amenitiesList else { return 0 }
        return value.rows.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.listTableView?.dequeueReusableCell(withIdentifier: Constants.CELL_IDENTIFIER, for:indexPath) as? AmenitiesTableViewCell else { return UITableViewCell() }
        if let value = amenitiesList?.rows[indexPath.row]
        {
            cell.lblTitle?.text = value.title
            cell.lblDescription?.text = value.description
            //SDWebImage to download image from web
            cell.imgView?.sd_setImage(with: URL(string: value.imageURL), placeholderImage: #imageLiteral(resourceName: "ImagePlaceholder"), options: SDWebImageOptions.retryFailed, completed: nil)
        }
        cell.selectionStyle = .none
        cell.accessoryType = .none
        return cell
    }
    
    
    
    
    //MARK: Functions & Methods
    
    //Method to call API
    func callAPIservice()  {
        if (Reachability.isConnectedToNetwork()) {
            print("Internet connection OK")
            DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
            }
            serviceCall.getAmenities(complete: { (amenitiesValue) in
                self.amenitiesList = amenitiesValue
                DispatchQueue.main.async {
                    self.title = self.amenitiesList?.title
                    self.listTableView?.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            }) { (error) in
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                    self.activityIndicator.stopAnimating()
                    self.showAlert(title: Constants.SERVICE_ERROR, message: Constants.HOST_NOT_REACHABLE)
                }
            }
        } else {
            print("Internet connection FAILED")
            self.showAlert(title: Constants.NO_INTERNET_TITLE, message: Constants.NO_INTERNET_MSG)
        }
        
    }
    
    
    // Pull to refresh event method
    @objc func pullToRefreshData(_ refreshControl: UIRefreshControl) {
        self.callAPIservice()
        self.refreshControl.endRefreshing()
        
    }
    
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: Constants.OK_BUTTON, style: UIAlertActionStyle.default, handler: nil))
        if self.presentedViewController == nil {
            self.present(alert, animated: true, completion: nil)
        }
        else {
            self.dismiss(animated: false, completion: nil)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}


