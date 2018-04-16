//
//  SuperViewController.swift
//  customSildermenu
//
//  Created by Sufalam 4 on 11/04/18.
//  Copyright © 2018 Sufalam 4. All rights reserved.
//

import UIKit

class SuperViewController: UIViewController {

    
    var sliderMenu : CustomSliderView = CustomSliderView.getCustomSliderMenus();
     var Name:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderMenu.shownavigation = true
        sliderMenu.rightSideIcon = true
        sliderMenu.rigthsideSlider = true
        sliderMenu.titlelist = ["Order Histrory","News & Events","Testimonials","FAQs","Blog","Policy","Terms and Conditions","Live support", "Log out"]
        sliderMenu.imglist = ["order-history-icon","news-event-icon","testimonials","faqs-icon","blog","policy-icon","term-icon","Chat","logout"]
    }

    func menuNavigationBarItem(){
        let imgName: String = "MenuButton";
        let leftButton = UIBarButtonItem(image: UIImage(named: imgName)?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(SuperViewController.btnMenuClicked(_:)))
        
        let Name1 = UIBarButtonItem(title: Name.capitalized, style: .plain, target: self, action: nil)
        Name1.tintColor = UIColor(red: 212.0/255.0, green: 254.0/255.0, blue: 88.0/255.0, alpha: 1.0)
        
        if sliderMenu.rigthsideSlider == true{
            self.navigationItem.setRightBarButtonItems([leftButton,Name1], animated: true)
        }else{
            self.navigationItem.setLeftBarButtonItems([leftButton,Name1], animated: true);
        }
    }
    
    
    @objc func btnMenuClicked(_ sender:UIButton!){
        self.view.endEditing(true);
        self.navigationController!.navigationBar.endEditing(true);
        self.view.isUserInteractionEnabled = false;
        NSLog("Menu clicked");
        sliderMenu.showSliderMenu(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
