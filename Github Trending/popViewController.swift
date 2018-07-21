//
//  popViewController.swift
//  Github Trending
//
//  Created by X's Mac on 2018/7/17.
//  Copyright © 2018年 X's Mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class popViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource{
        var i = 0
        var val :[message] = []
        let fullScreenSize = UIScreen.main.bounds.size
        override func viewDidLoad() {
            self.title = "Popular"
            super.viewDidLoad()
            Alamofire.request("https://api.github.com/search/repositories",parameters:["q":"stars:>1","sort":"stars"]).responseJSON { response in
                switch response.result {
                case .success:
                    if let value = response.result.value{
                    let json = JSON(value)
                        while(json["items"][self.i]["full_name"].string != nil){
                        self.val.append(message.init())
                        self.val[self.i].title = json["items"][self.i]["full_name"].string!
                            self.val[self.i].url = "https://github.com/" +  self.val[self.i].title!
                            self.i = self.i + 1
                        }
                       }
                case .failure(let error):
                    print("request failed with error\(error)")
                }
                let myTableView = UITableView(frame: CGRect(x: 0, y: -35,width: self.fullScreenSize.width,height: self.fullScreenSize.height),style: .grouped)
                myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
                myTableView.delegate = self as UITableViewDelegate
                myTableView.dataSource = self as UITableViewDataSource
                myTableView.separatorStyle = .singleLine
                myTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
                myTableView.allowsSelection = true
                myTableView.allowsMultipleSelection = false
                
                self.view.addSubview(myTableView)
                
                myTableView.reloadData()
                
            }
            
            
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return val.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
            
            if let myLabel = cell.textLabel {
                myLabel.text = val[indexPath.row].title!
            }
            
            return cell
        }
      
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let firstVC = readViewController(nibName:"readViewController",bundle: nil)
            firstVC.urloftitle = val[indexPath.row].url
            present(firstVC, animated: true, completion: nil)
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
}

