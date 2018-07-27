//
//  ViewController.swift
//  SamplePOC

import UIKit
import Foundation
import Alamofire

class MyTableViewController: UITableViewController {

    let cellIdentifier = "cell"
    var dataSource = [AnyObject]()
    
    var pullToRefresh: UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
        pullToRefresh = UIRefreshControl()
        pullToRefresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
        pullToRefresh.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tableView.addSubview(pullToRefresh)
        
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor.gray

       tableView.register(CustomCell.self, forCellReuseIdentifier: cellIdentifier)
       downloadJSON()
    }

    
    func refresh(_ sender: Any) {
        downloadJSON()

    }
    
    func downloadJSON() {

        
        Alamofire.request(urlToParse.App_URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseString { (response:DataResponse) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    print(response.result.value as Any)
                    self.pullToRefresh.endRefreshing()
                }
                break
                
            case .failure(_):
                print(response.result.error as Any)
                break
                
            }
        }
        
    }
}

extension MyTableViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(dataSource.count)
        return dataSource.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CustomCell
        
        return cell
    }
}

class CustomCell: UITableViewCell {
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        setupViews()
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews() {
        
        //self.contentView.backgroundColor = UIColor.red
        
        self.contentView.addSubview(nameLabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

