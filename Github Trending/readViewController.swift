//
//  readViewController.swift
//  Github Trending
//
//  Created by X's Mac on 2018/7/16.
//  Copyright © 2018年 X's Mac. All rights reserved.
//

import UIKit
import WebKit
class readViewController: UIViewController, UITextFieldDelegate, WKNavigationDelegate {
    var myTextField :UITextField?
     var myWebView :WKWebView!
    var myActivityIndicator:UIActivityIndicatorView!
    var urloftitle :String?
    
    override func viewDidLoad() {
   
        super.viewDidLoad()
        let fullScreenSize = UIScreen.main.bounds.size
        let goWidth = 100.0
        let actionWidth = ( Double(fullScreenSize.width) - goWidth ) / 4
        myTextField = UITextField(frame: CGRect(x: 0, y: 20.0 + CGFloat(actionWidth), width: fullScreenSize.width, height: 40))
        myTextField?.text = urloftitle
        let myButton = UIButton(frame: CGRect(x: 0, y: 20, width: 120, height: 40))
        myButton.setTitle("back", for: .normal)
        myButton.addTarget(self, action: #selector(readViewController.back), for: .touchUpInside)
        //let nav = UINavigationController(rootViewController: readViewController())
        myWebView = WKWebView(frame: CGRect(x: 0, y:  0, width: fullScreenSize.width, height: fullScreenSize.height ))
        myWebView.navigationDelegate = self
        self.view.addSubview(myWebView)
        self.view.addSubview(myButton)
        self.go()
        
    }
    
    @objc func go() {
       
        let url = URL(string:(myTextField?.text)!)
        let urlRequest = URLRequest(url: url!)
        myWebView.load(urlRequest)
    }
    @objc func back() {
    dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
