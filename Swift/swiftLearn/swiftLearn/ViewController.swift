//
//  ViewController.swift
//  swiftLearn
//
//  Created by 19054909 on 2021/5/28.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var str: String? = "aaa"
        if  str != nil {
            var cstr = str
            var count = cstr!.count
            print(count)
            cstr = "vvvv"
            str = "cccc"
            print(cstr)
            print(str)
        }
        
    }


}

