//
//  LoginVC.swift
//  Registration_demo
//
//  Created by TBS17 on 16/09/19.
//  Copyright © 2019 Sazzadhusen Iproliya. All rights reserved.
//

import UIKit
import CoreData

class LoginVC: SIViewController, UITextFieldDelegate {

    @IBOutlet var txtEmail:UnderLineTextField!
    @IBOutlet var txtPassword:UnderLineTextField!
    
    var isView = false
    var strTextFieldSelected = ""
    var deviceToken = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        deviceToken = getValueFromDefault(key: kdeviceToken) as! String
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.clear
        
        self.view.shiftHeightAsDodgeViewForMLInputDodger = 25.0;
        self.view.registerAsDodgeViewForMLInputDodger()
    }
    
//MARK:- UIStatusBar Light
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .default
    }
    
//MARK:- TextField Delegate Methods
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtEmail{
            strTextFieldSelected = "txtEmail"
        }else if textField == txtPassword{
            strTextFieldSelected = "txtPassword"
        }
        textField.inputAccessoryView = toolbarInit()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
//MARK:- UITextField Toolbar and Methods
    func toolbarInit() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40)
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = false
        toolBar.barTintColor = ThemeYellow
        toolBar.tintColor = UIColor.white
        
        let doneButton = UIBarButtonItem(title: NSLocalizedString("String8", comment: "done"), style: UIBarButtonItem.Style.done, target: self, action: #selector(resignKeyboard))
        let previousButton:UIBarButtonItem! = UIBarButtonItem()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        previousButton.customView = self.prevNextSegment()
        toolBar.setItems([previousButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        return toolBar;
    }
    
    func prevNextSegment() -> UISegmentedControl {
        let prevNextSegment = UISegmentedControl()
        prevNextSegment.isMomentary = true
        prevNextSegment.tintColor = UIColor.white
        let barbuttonFont = UIFont(name: ThemeFont.Regular, size: 15) ?? UIFont.systemFont(ofSize: 15)
        prevNextSegment.setTitleTextAttributes([NSAttributedString.Key.font: barbuttonFont, NSAttributedString.Key.foregroundColor:UIColor.white], for: UIControl.State.disabled)
        prevNextSegment.frame = CGRect(x: 0, y: 0, width: 130, height: 35)
        prevNextSegment.insertSegment(withTitle:  NSLocalizedString("String9", comment: ""), at: 0, animated: false)
        prevNextSegment.insertSegment(withTitle:  NSLocalizedString("String10", comment: ""), at: 1, animated: false)
        prevNextSegment.addTarget(self, action: #selector(prevOrNext), for: UIControl.Event.valueChanged)
        return prevNextSegment;
    }
    
    @objc func prevOrNext(_ segm: UISegmentedControl) {
        if (segm.selectedSegmentIndex == 1){
            if (strTextFieldSelected == "txtEmail"){
                _ = txtEmail.resignFirstResponder()
                _ = txtPassword.becomeFirstResponder()
            }
        }
        else{
            if (strTextFieldSelected == "txtPassword"){
                _ = txtPassword.resignFirstResponder()
                _ = txtEmail.becomeFirstResponder()
            }
        }
    }
    
    @objc func resignKeyboard() {
        _ = self.txtEmail.resignFirstResponder()
        _ = self.txtPassword.resignFirstResponder()
    }
    
//MARK:- UIAction Events
    @IBAction func TapLogin(_ sender:AnyObject) {
        if !(txtEmail.text?.emailValidation())! {
            appDelegateShared.showToastMessage( NSLocalizedString("String3", comment: ""))
        }else if !(txtPassword.text?.passwordValidation())! {
            appDelegateShared.showToastMessage( NSLocalizedString("String4", comment: ""))
        }else {
            self.resignKeyboard()
            createLogin()
        }
    }
    
    @IBAction func TapSignUp(_ sender:AnyObject) {
        self.resignKeyboard()
        let initVC = mainSB.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        self.navigationController?.pushViewController(initVC, animated: true)
    }
    
    @IBAction func TapViewPassword(_ sender:AnyObject) {
        if isView{
            isView = false
            txtPassword.isSecureTextEntry = true
        }else{
            isView = true
            txtPassword.isSecureTextEntry = false
        }
    }
    
//MARK:- Login
    func createLogin() {
        
        appDelegateShared.showHudder()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let emailPredicate = NSPredicate(format: "email = %@", txtEmail.text!)
        let pwdPredicate = NSPredicate(format: "password = %@", txtPassword.text!)
        let predicate = NSCompoundPredicate(type: .and, subpredicates: [emailPredicate, pwdPredicate])
        fetchRequest.predicate = predicate
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            appDelegateShared.hideHudder()
            if result.count > 0{
                appDelegateShared.showToastMessage(NSLocalizedString("String21", comment:"Logged in successfully"))
                let data = (result as! [NSManagedObject])[0]
                
                loginObj.firstName = data.value(forKey: "firstname") as? String
                loginObj.lastName = data.value(forKey: "lastname") as? String
                loginObj.email = data.value(forKey: "email") as? String
                loginObj.dob = data.value(forKey: "dob") as? String
                loginObj.mobile = data.value(forKey: "phone") as? String
                setModelDataInUserDefaults(loginObj, key: UDKey.modelLogin)
                setValueToDefault(value: "Yes", key: UDKey.isLogin)
                
                appDelegateShared.deleteAllData("Item")
                let initVC = mainSB.instantiateViewController(withIdentifier: "TabBarVC") as! UITabBarController
                self.navigationController?.pushViewController(initVC, animated: true)
            }else{
                appDelegateShared.showToastMessage(NSLocalizedString("String17", comment:"Invalid email or password"))
            }
        }catch{
            appDelegateShared.hideHudder()
            print((error as NSError).userInfo)
        }
    }
}

