//
//  MyTabBarController.swift
//  MultiStoryBoadsDemo
//
//  Created by atsushi otsubo on 2015/03/19.
//  Copyright (c) 2015年 atsushi otsubo. All rights reserved.
//
//  storyboad分割用にUITabBarControllerをカスタム
//  ここがrootになる。一番初めに表示するタブはinfo.plistの「Main storyboard file base name」で設定
//っっっっっｋtesutoooo

import UIKit

class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //make URL of google feed api
        var urlString = "http://localhost:3000/json"
        var url = NSURL(string: urlString)
        
        //download by NSSession
        var task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler:{data, response, error in
            //convert json data to dictionary
            var error: NSError?
            
            var dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSArray
            
            var hoge = dict[0]["EVENT"] as NSDictionary
            
            println(hoge)
            println(hoge["category"]!)
            println(hoge["description"]!)
            println(hoge["organizer"]!)
            println(hoge["title"]!)
            println(hoge["sub_place"]!)
        })
        
        task.resume()
        

        // Do any additional setup after loading the view.
        
        // タブにviewcontrollerを追加
        self.viewControllers = [self.createViewControllerInTabBar("Events"), self.createViewControllerInTabBar("Map"), self.createViewControllerInTabBar("Schedule"), self.createViewControllerInTabBar("Timeline"), self.createViewControllerInTabBar("Others")]
    }
    
    // 5つのタブの中のviewcontrollerを生成(全てにnavigation controllerが付いているのでそれを生成)
    
    func createViewControllerInTabBar(nameOfViewCtr: String) -> UINavigationController{
        let storyB = UIStoryboard(name: nameOfViewCtr, bundle: nil)
        let navigationCtr = storyB.instantiateInitialViewController() as UINavigationController
        return navigationCtr
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
