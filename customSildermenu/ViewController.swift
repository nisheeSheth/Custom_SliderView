//
//  ViewController.swift
//  customSildermenu
//
//  Created by Sufalam 4 on 11/04/18.
//  Copyright © 2018 Sufalam 4. All rights reserved.
//

import UIKit

class ViewController: SuperViewController {

    @IBOutlet weak var txtfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Name = "menu"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 53.0/255.0, green: 140.0/255.0, blue: 62.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.isTranslucent = true
        menuNavigationBarItem()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

