//
//  CustomSliderView.swift
//  customSildermenu
//
//  Created by Sufalam 4 on 11/04/18.
//  Copyright © 2018 Sufalam 4. All rights reserved.
//

import UIKit

class CustomSliderView: UIView,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate{
    
    var tableMenus : UITableView! = nil;
    var viewCTR : UIViewController = UIViewController();
    var viewToHideSlideMenu : UIView = UIView();
    var tapGesture : UITapGestureRecognizer = UITapGestureRecognizer();
    var rightSideIcon:Bool = false
    var rigthsideSlider:Bool = false
    var shownavigation: Bool = false
    var menuName:UILabel! = nil
    var imgMehu:UIImageView! =  nil
    var imglist: [String] = [];
    var titlelist: [String] = []
    
    
    //MARK:- Gesture Handle
    static func getCustomSliderMenus() -> CustomSliderView{
        var viewCustom : CustomSliderView;
        viewCustom = CustomSliderView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height));
        viewCustom.backgroundColor = UIColor(red:  255/255.0, green: 131/255.0, blue: 23/255.0, alpha: 1.0);
        return viewCustom;
    }
    
    //MARK:- ShowSliderMenu Function
    func showSliderMenu(_ viewCTRTemp : UIViewController){
        viewCTR = viewCTRTemp;
        self.backgroundColor = UIColor.white
        let window : UIWindow = UIApplication.shared.windows[0];
        window.backgroundColor = UIColor.white
        if rigthsideSlider == true{
            tableMenus = UITableView(frame: CGRect(x: window.frame.size.width - 256, y: 0, width: 256, height: window.frame.size.height - 58), style: .grouped)
        }else{
            tableMenus = UITableView(frame: CGRect(x: 0, y: 0, width: 256, height: window.frame.size.height - 58), style: .grouped)
        }
        
        tableMenus.bounces = false;
        tableMenus.autoresizingMask = [.flexibleHeight, .flexibleWidth, .flexibleRightMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleTopMargin];
        tableMenus.translatesAutoresizingMaskIntoConstraints = true;
        tableMenus.delegate = self;
        tableMenus.dataSource = self;
        
        //table view background color
        tableMenus.backgroundColor = UIColor.white
        tableMenus.tableFooterView = UIView.init(frame: CGRect.zero);
        tableMenus.tableHeaderView = UIView.init(frame: CGRect.zero);
        tableMenus.sectionHeaderHeight = 110
        
        
        let viewHeader: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: tableMenus.frame.size.width, height: 110));
        
        //MARK:- Title OF nemu If you don't want to put logo image
        //        let lbltitle: UILabel = UILabel.init(frame: CGRect(x: 62, y: 15, width: 200, height: 50))
        //        lbltitle.text = Title;
        //        lbltitle.font = lbltitle.font.withSize(23)
        //        lbltitle.font = UIFont(name: "Helvetica-Condensed" as String, size: 23);
        //        lbltitle.textColor = UIColor.init(red: 34/255, green: 34/255, blue: 34/255 , alpha: 1.0)
        //        viewHeader.addSubview(lbltitle);
        
        
        //MARK:- Logo Image
        let imgMehu:UIImageView = UIImageView(frame: CGRect(x: 15, y: 5, width: 100, height: 70));
        imgMehu.contentMode = .scaleAspectFit
        imgMehu.image = UIImage(named: "OnOneCall")
        viewHeader.backgroundColor = UIColor.init(red: 52/255, green: 138/255, blue: 61/255, alpha: 1.0)
        imgMehu.layoutIfNeeded()
        viewHeader.addSubview(imgMehu);
        
        
        //MARK:- Username
        let btnUser = UIButton(frame: CGRect(x:10, y: viewHeader.frame.size.height - 40, width: viewHeader.frame.size.width - 40 , height: 30));
        btnUser.titleLabel?.lineBreakMode = NSLineBreakMode.byTruncatingTail
        btnUser.setTitle("Nishee sheth", for: .normal)
        btnUser.setImage(UIImage(named: "UserIconWhite"), for: .normal);
        btnUser.imageView?.contentMode = .scaleAspectFit;
        btnUser.addTarget(self, action: #selector(self.btnUserProfileClicked(_:)), for: .touchUpInside);
        btnUser.contentHorizontalAlignment = .left;
        btnUser.setTitleColor(UIColor.white,for: UIControlState.normal)
        btnUser.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)  // Making Gap Between Image and Title
        viewHeader.addSubview(btnUser);
        
        //MARK:- set image on edit button
        let imgIcon:UIImageView = UIImageView(frame: CGRect(x: viewHeader.frame.size.width - 35, y: viewHeader.frame.size.height - 35, width: 20 , height: 20));
        imgIcon.contentMode = .scaleAspectFit
        imgIcon.image = UIImage(named: "EditProfile")
        imgIcon.layoutIfNeeded()
        viewHeader.addSubview(imgIcon);
        
        if shownavigation == true{
            tableMenus.tableHeaderView = viewHeader;
        }
        
        tableMenus.separatorInset = .zero;
        self.addSubview(tableMenus);
        tableMenus.showsVerticalScrollIndicator = false;
        tableMenus.reloadData();
        
        if rigthsideSlider == true{
            viewToHideSlideMenu = UIView.init(frame: CGRect(x: -256, y: 0, width: self.frame.size.width, height: self.frame.size.height));
        }else{
            viewToHideSlideMenu = UIView.init(frame: CGRect(x: 256, y: 0, width: self.frame.size.width, height: self.frame.size.height));
        }
        
        viewToHideSlideMenu.backgroundColor = UIColor.clear;
        window.addSubview(viewToHideSlideMenu);
        viewToHideSlideMenu.isHidden = false;
        
        //Set TAP Gesture
        let tapGestureTemp = UITapGestureRecognizer.init(target: self, action: #selector(CustomSliderView.tapGestureHappen));
        tapGestureTemp.numberOfTapsRequired = 1;
        tapGestureTemp.numberOfTouchesRequired = 1;
        viewToHideSlideMenu.addGestureRecognizer(tapGestureTemp);
        
        //Set Swipe Gesture
        let swipeGesture = UISwipeGestureRecognizer.init(target: self, action: #selector(CustomSliderView.swipeGestureHappen));
        viewToHideSlideMenu.addGestureRecognizer(swipeGesture);
        
        self.frame = CGRect(x: 0, y: 0, width: window.frame.size.width, height: self.frame.size.height);
        window.addSubview(self);
        
        UIView.transition(with: self, duration: 0.5, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            if self.rigthsideSlider == true{
                self.viewCTR.navigationController?.view.frame = CGRect(x: -256, y: self.viewCTR.navigationController!.view.frame.origin.y, width: self.viewCTR.navigationController!.view.frame.size.width, height: self.viewCTR.navigationController!.view.frame.size.height);
            }else{
                self.viewCTR.navigationController?.view.frame = CGRect(x: 256, y: self.viewCTR.navigationController!.view.frame.origin.y, width: self.viewCTR.navigationController!.view.frame.size.width, height: self.viewCTR.navigationController!.view.frame.size.height);
            }
            
            window.bringSubview(toFront: self.viewCTR.navigationController!.view);
            
        }, completion: { (finished) -> Void in
            self.viewToHideSlideMenu.isHidden = false;
            window.bringSubview(toFront: self.viewToHideSlideMenu);
        });
        self.layoutIfNeeded()
    }
    
    @objc func tapGestureHappen() {
        self.dissmissPopView();
    }
    
    @objc func swipeGestureHappen() {
        self.dissmissPopView();
    }
    
    func dissmissPopView() {
        
        viewCTR.view.isUserInteractionEnabled = true;
        
        let _ : UIWindow = UIApplication.shared.windows[0];
        
        UIView.transition(with: self, duration: 0.5, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            self.viewCTR.navigationController!.view.frame = CGRect(x: 0, y: 0, width: self.viewCTR.navigationController!.view.frame.size.width, height: self.viewCTR.navigationController!.view.frame.size.height);
            
        }) { (finished) -> Void in
            self.tableMenus.removeFromSuperview();
            self.viewToHideSlideMenu.isHidden = true;
        };
        self.layoutIfNeeded()
        
    }
    
    func gestureRecognizer (_ gestureRecognizer : UIGestureRecognizer, touch:UITouch) -> Bool{
        
        if (touch.view == tableMenus) {
            return false;
        }
        return true;
    }
    
    
    //MARK: - UITableView delegate methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titlelist.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier : String = "Cell";
        var cell : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellIdentifier);
        if (cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier);
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none;
        
        if rightSideIcon == true{
            menuName = UILabel(frame: CGRect(x: 20, y: 10, width: 200, height: 20));
        }else{
            menuName = UILabel(frame: CGRect(x: 60, y: 10, width: 200, height: 20));
        }
        menuName.font = UIFont(name: "Open Sans" as String, size: 15.0);
        menuName.font = menuName.font.withSize(16)
        menuName.text = titlelist[indexPath.row];
        menuName.tag = 101;
        menuName.textColor = UIColor.black;
        
        cell.addSubview(menuName);
        if rightSideIcon == true{
            imgMehu = UIImageView(frame: CGRect(x: 200, y: 10, width: 24, height: 24));
        }else{
            imgMehu = UIImageView(frame: CGRect(x: 20, y: 10, width: 24, height: 24));
        }
        
        imgMehu.image = UIImage(named: imglist[indexPath.row]);
        imgMehu.contentMode = .scaleAspectFit;
        cell.addSubview(imgMehu);
        let imgNav:UIImageView = UIImageView(frame: CGRect(x: tableMenus.frame.size.width - 20, y: 10, width: 10, height: 24));
        imgNav.image = UIImage(named: "next-green");
        imgNav.contentMode = .scaleAspectFit;
        
        if indexPath.row != titlelist.count - 1 {
            cell.addSubview(imgNav);
        }
        self.tableMenus.separatorColor = UIColor.black
        UITableView.appearance().separatorColor = UIColor.black
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0{
        }else if indexPath.row == 1 {
        }else if indexPath.row == 2{
        }else if indexPath.row == 3{
        }else if indexPath.row == 4{
        }else if indexPath.row == 5{
        }else if indexPath.row == 6{
        }else if indexPath.row == 7{
        }else if indexPath.row == 8{
            let logoutAlert = UIAlertController(title: "Logout", message: "Are you sure, you want to logout?", preferredStyle: UIAlertControllerStyle.alert)
            logoutAlert.addAction(UIAlertAction(title: "NO", style: .default, handler: { (action: UIAlertAction!) in
                print("Handle NO logic here")
            }))
            logoutAlert.addAction(UIAlertAction(title: "YES", style: .cancel, handler: { (action: UIAlertAction!) in
            }))
            self.window?.rootViewController?.present(logoutAlert, animated: true, completion: nil);
        }else{
            return
        }
        sliderhandle();
    }
    
    func sliderhandle(){
        let window : UIWindow = UIApplication.shared.windows[0];
        UIView.transition(with: self, duration: 0.5, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            self.viewCTR.navigationController!.view.frame = CGRect(x: 0, y: 0, width: self.viewCTR.navigationController!.view.frame.size.width, height: self.viewCTR.navigationController!.view.frame.size.height);
            
            window.bringSubview(toFront: self.viewCTR.navigationController!.view);
        }) { (finished) -> Void in
            
            self.tableMenus.removeFromSuperview();
            self.viewToHideSlideMenu.isHidden = false;
        }
        self.layoutIfNeeded()
        viewCTR.view.isUserInteractionEnabled = true;
    }

    @objc func btnUserProfileClicked(_ sender: UIButton) {
      // Username edit Action
    }
}
