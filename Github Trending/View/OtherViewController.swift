//
//  OtherViewController.swift
//  Github Trending
//
//  Created by X's Mac on 2018/7/26.
//  Copyright © 2018年 X's Mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftSoup

class OtherViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource , UIPickerViewDelegate, UIPickerViewDataSource{
    let period = ["daily","weekly","monthly"]
    var langeuage = ["All","C++","HTML","Java","JavaScript","PHP","Python","Ruby","Unknow"]
    var whatPeriod = "monthly"
    var favorite:[String] = []
    let myUserDefaults = UserDefaults.standard
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return period.count
        
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return period[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let myTextField = self.view?.viewWithTag(100) as? UITextField
        myTextField?.text = period[row]
        whatPeriod = (myTextField?.text)!
        pickerView.reloadComponent(row)
        viewDidLoad()
    }
    
    var i = 0
    var val :[message] = []
    let fullScreenSize = UIScreen.main.bounds.size
    @objc func hideKeyboard(tapG:UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Trending"
        Alamofire.request("https://github.com/trending/unknow?since="+whatPeriod).responseString { response in
            let html = String(describing: response.result.value)
            let doc: Document = try! SwiftSoup.parse(html)
            let link: Elements = try! doc.body()!.select("li")
            let linkText: String = try! link.text()
            let l: Elements = try! doc.body()!.select("span")
            let lText: String = try! l.text()
            var str = linkText.replacingOccurrences(of:"\\n", with: "")
            var pattern = "\\S* / \\S*"
            var regex = try? NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            var res = regex?.matches(in: str, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, str.characters.count))
            for checkingRes in res! {
                if(self.i == self.val.count){
                    self.val.append(message.init())
                }
                self.val[self.i].title = (str as NSString).substring(with: checkingRes.range)
                self.val[self.i].title = self.val[self.i].title?.replacingOccurrences(of:" ", with: "")
                self.val[self.i].url = "https://github.com/" +  self.val[self.i].title!
                self.i = self.i + 1
            }
            self.i = 0
            
            str = lText.replacingOccurrences(of:"\\n", with: "")
            pattern = " / \\D*"
            regex = try? NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            res = regex?.matches(in: str, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, str.characters.count))
            for checkingRes in res! {
                self.val[self.i].langeuage = (str as NSString).substring(with: checkingRes.range)
                self.val[self.i].langeuage = self.val[self.i].langeuage?.replacingOccurrences(of:"Built by", with: "")
                self.val[self.i].langeuage = self.val[self.i].langeuage?.replacingOccurrences(of:"/", with: "")
                self.val[self.i].langeuage = self.val[self.i].langeuage?.replacingOccurrences(of:" ", with: "")
                self.val[self.i].langeuage = (self.val[self.i].langeuage! as NSString).substring(to: (self.val[self.i].langeuage?.count)!/2)
                self.i = self.i + 1
            }
            self.i = 0
            
            let myTableView = UITableView(frame: CGRect(x: 0, y:0,width: self.fullScreenSize.width,height: self.fullScreenSize.height),style: .grouped)
            myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            myTableView.tag = 50
            myTableView.delegate = self
            myTableView.dataSource = self
            myTableView.separatorStyle = .none
            myTableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20)
            myTableView.allowsSelection = true
            myTableView.allowsMultipleSelection = false
            self.view.addSubview(myTableView)
            let myTextField = UITextField(frame: CGRect(x: 0, y: 0,width: self.fullScreenSize.width, height: 20))
            let myPickerView = UIPickerView()
            myPickerView.delegate = self
            myPickerView.dataSource = self
            myTextField.inputView = myPickerView
            myTextField.text = self.whatPeriod
            myTextField.tag = 100
            myTextField.backgroundColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
            myTextField.textAlignment = .center
            myTextField.center = CGPoint(x: self.fullScreenSize.width * 0.5, y: self.fullScreenSize.height * 0.025)
            self.view.addSubview(myTextField)
            let tap = UITapGestureRecognizer(target: self,action:#selector(OtherViewController.hideKeyboard(tapG:)))
            tap.cancelsTouchesInView = false
            self.view.addGestureRecognizer(tap)
            myTableView.reloadData()
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return val.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        if indexPath.section == 0 {
            cell.accessoryType = .detailButton
        }
        if let myLabel = cell.textLabel {
            myLabel.text = val[indexPath.row].title!
        }
        return cell
    }
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if(!val[indexPath.row].isfavorite){
            val[indexPath.row].isfavorite = true
        }else{
            val[indexPath.row].isfavorite = false
        }
        if(val[indexPath.row].isfavorite){
            favorite.append(val[indexPath.row].title!)
            //   myUserDefaults?.removeObject(forKey: "info")
            myUserDefaults.set(favorite, forKey: "trend")
            myUserDefaults.synchronize()
        }else{
            var a = 0
            for i in favorite{
                if(i == val[indexPath.row].title!){
                    favorite.remove(at: a)
                }
                a = a + 1
            }
        }
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

