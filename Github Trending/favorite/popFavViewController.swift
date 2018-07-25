//
//  popFavViewController.swift
//  Github Trending
//
//  Created by X's Mac on 2018/7/25.
//  Copyright © 2018年 X's Mac. All rights reserved.
//

import UIKit

class popFavViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {

    let fullSize = UIScreen.main.bounds.size
    let myUserDefaults = UserDefaults.standard
    override func viewDidLoad() {
        self.title = "pop Favorite"
        super.viewDidLoad()
        let myTableView = UITableView(frame: CGRect(x: 0, y: -35,width: fullSize.width,height: fullSize.height),style: .grouped)
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        myTableView.delegate = self as UITableViewDelegate
        myTableView.dataSource = self as UITableViewDataSource
        myTableView.separatorStyle = .singleLine
        myTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        myTableView.allowsSelection = true
        myTableView.allowsMultipleSelection = false
        
        self.view.addSubview(myTableView)
        
        myTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let info = myUserDefaults.object(forKey: "pop") as? [String]
        return (info?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        if let myLabel = cell.textLabel {
            if let info = myUserDefaults.object(forKey: "pop") as? [String] {
                myLabel.text = info[indexPath.row]
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let info = myUserDefaults.object(forKey: "pop") as? [String]
        let firstVC = readViewController(nibName:"readViewController",bundle: nil)
        firstVC.urloftitle = "https://github.com/" + (info?[indexPath.row])!
        present(firstVC, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
