//
//  CityAmenitiesListViewController.swift
//  TelstraiOSAssignment
//
//  Created by Saravanakumar on 14/07/18.
//  Copyright © 2018 Saravanakumar. All rights reserved.
//

import UIKit

class CityAmenitiesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var listTableView : UITableView?
    var amenitiesList : AmenitiesList?
    var amenitiesPresenter = AmenitiesPresenter()
    
    
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
        
        self.navigationItem.title = "Title"
        //Add tableViewController programatically
        self.listTableView = UITableView()
        self.listTableView?.register(AmenitiesTableViewCell.self, forCellReuseIdentifier: "cell")
        self.listTableView?.delegate = self
        self.listTableView?.dataSource = self
        self.listTableView?.estimatedRowHeight = 44
        self.listTableView?.rowHeight = UITableViewAutomaticDimension
        self.listTableView?.translatesAutoresizingMaskIntoConstraints = false
        self.listTableView?.addSubview(self.refreshControl)
        self.activityIndicator.center = (self.listTableView?.center)!
        self.listTableView?.addSubview(self.activityIndicator)
        self.view.addSubview(self.listTableView!)
        
        
        self.listTableView?.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        self.listTableView?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        self.listTableView?.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        self.listTableView?.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
        self.listTableView?.tableFooterView = UIView()
        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.listTableView?.dequeueReusableCell(withIdentifier: "cell", for:indexPath) as? AmenitiesTableViewCell else { return UITableViewCell() }
        if let value = amenitiesList?.rows[indexPath.row]
        {
            cell.lblTitle?.text = value.title
            
            cell.lblDescription?.text = value.description
            
            cell.imgView?.image = nil
            
            let url = URL(string:(value.imageURL))
            print(url)
            
            
           
            var requestSession: URLSessionTask? = nil
            if let imgUrl = url {
                requestSession = URLSession.shared.dataTask(with: imgUrl, completionHandler: { data, response, error in
                    if data != nil {
                        var image: UIImage? = nil
                        if let imgData = data {
                            image = UIImage(data: imgData)
                        }
                        if image != nil {
                            DispatchQueue.main.async(execute: {
                                let cellToUpdate = self.listTableView?.cellForRow(at: indexPath as IndexPath) as? AmenitiesTableViewCell
                                if cellToUpdate != nil {
                                    cellToUpdate?.imgView?.image = image
                                }
                            })
                        }
                    }
                })
            }
            requestSession?.resume()
        }
        cell.selectionStyle = .none
        cell.accessoryType = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    //MARK: Functions & Methods
    
    //Method to call API
    func callAPIservice()  {
         DispatchQueue.main.async {
        self.activityIndicator.startAnimating()
        }
        amenitiesPresenter.getAmenities(complete: { (amenitiesValue) in
            self.amenitiesList = amenitiesValue
            DispatchQueue.main.async {
                self.title = self.amenitiesList?.title
                self.listTableView?.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }) { (error) in
            print(error.localizedDescription)
            self.activityIndicator.stopAnimating()
        }
    }
    
    
    // Pull to refresh event method
    @objc func pullToRefreshData(_ refreshControl: UIRefreshControl) {
        self.callAPIservice()
        self.refreshControl.endRefreshing()
        
    }
    
}

