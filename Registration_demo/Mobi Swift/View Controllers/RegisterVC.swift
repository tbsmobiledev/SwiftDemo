//
//  RegisterVC.swift
//  Registration_demo
//
//  Created by TBS17 on 16/09/19.
//  Copyright © 2019 Sazzadhusen Iproliya. All rights reserved.
//

import UIKit
import CoreData

class RegisterVC: SIViewController ,UnderLineTextFieldDelegate{

    @IBOutlet var txtFirstName: UnderLineTextField!
    @IBOutlet var txtLastName: UnderLineTextField!
    @IBOutlet var txtEmail: UnderLineTextField!
    @IBOutlet var txtPassword: UnderLineTextField!
    @IBOutlet var txtConfirmPassword: UnderLineTextField!
    @IBOutlet var txtPhoneNumber: UnderLineTextField!
    @IBOutlet var txtDOB: UnderLineTextField!
    
    @IBOutlet var vwProgress:UIProgressView!
    @IBOutlet var heightVwProgress:NSLayoutConstraint!
    
    @IBOutlet var lblPasswordStatus: SILabel!
    @IBOutlet var lblTermsAndConditions: SILabel!
    @IBOutlet var lblDobValidation: SILabel!
    
    @IBOutlet var imgCheckTermsAndConditions: SIImageView!
    
    var strTextFieldSelected = ""
    var flagTermsAndConditions = false
    var deviceToken = ""
    var datePicker = UIDatePicker()
    var formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtFirstName.validationType = .afterEdit
        txtLastName.validationType = .afterEdit
        txtEmail.validationType = .afterEdit
        txtPassword.validationType = .afterEdit
        txtConfirmPassword.validationType = .afterEdit
        txtPhoneNumber.validationType = .afterEdit
        
        lblPasswordStatus.text = ""
        heightVwProgress.constant = 0
        lblDobValidation.text = NSLocalizedString("String12", comment: "Required age to use app is 18 years")
        
        formatter.dateFormat = "dd-MM-yyyy"
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.backgroundColor = .white
        datePicker.addTarget(self, action: #selector(getDateFromPicker(_:)), for: .valueChanged)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLblTnC))
        lblTermsAndConditions.addGestureRecognizer(tap)
        
        deviceToken = getValueFromDefault(key: kdeviceToken) as! String
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0
        self.view.registerAsDodgeViewForMLInputDodger()
        
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.white
    }
    
//MARK:- UIStatusBar Light
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .default
    }
  
//MARK:- TextField Delegate Method
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtFirstName{
            strTextFieldSelected = "txtFirstName"
        }else if textField == txtLastName{
            strTextFieldSelected = "txtLastName"
        }else if textField == txtEmail{
            strTextFieldSelected = "txtEmail"
        }else if textField == txtDOB {
            strTextFieldSelected = "txtDOB"
            textField.inputView = datePicker
        }else if textField == txtPassword{
            strTextFieldSelected = "txtPassword"
        }else if textField == txtConfirmPassword{
            strTextFieldSelected = "txtConfirmPassword"
        }else if textField == txtPhoneNumber{
            strTextFieldSelected = "txtPhoneNumber"
        }
        textField.inputAccessoryView = toolbarInit();
        return true
    }
    
    func textFieldTextChanged(underLineTextField: UnderLineTextField) {
        if underLineTextField == txtPassword{
            let strength = passwordStatus(txtPassword.text!)
            
            heightVwProgress.constant = 5 * DeviceScale.SCALE_Y
            vwProgress.layer.cornerRadius = heightVwProgress.constant / 2
            vwProgress.layer.masksToBounds = true
            vwProgress.setProgress((Float(strength)/5.0), animated: true)
            
            lblPasswordStatus.isHidden = false
            switch strength {
            case 0:
                lblPasswordStatus.text = ""
                vwProgress.progressTintColor = UIColor.clear
            case 1...2:
                lblPasswordStatus.text = NSLocalizedString("String14", comment: "Weak")
                lblPasswordStatus.textColor = ThemeRed
                vwProgress.progressTintColor = ThemeRed
            case 3...4:
                lblPasswordStatus.text = NSLocalizedString("String15", comment: "Average")
                lblPasswordStatus.textColor = ThemeOrange
                vwProgress.progressTintColor = ThemeOrange
            default:
                lblPasswordStatus.text = NSLocalizedString("String16", comment: "Strong")
                lblPasswordStatus.textColor = ThemeGreen
                vwProgress.progressTintColor = ThemeGreen
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtPassword{
            heightVwProgress.constant = 0
            lblPasswordStatus.isHidden = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtPhoneNumber {
            let currentCharacterCount = textField.text?.count ?? 0
            if range.length + range.location > currentCharacterCount {
                return false
            }
            let newLength = currentCharacterCount + string.count - range.length
            return newLength <= 15
        }else{
            return true
        }
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
            if (strTextFieldSelected == "txtFirstName"){
                _ = txtFirstName.resignFirstResponder()
                _ = txtLastName.becomeFirstResponder()
            }else if (strTextFieldSelected == "txtLastName"){
                _ = txtLastName.resignFirstResponder()
                _ = txtEmail.becomeFirstResponder()
            }else if (strTextFieldSelected == "txtEmail"){
                _ = txtEmail.resignFirstResponder()
                _ = txtDOB.becomeFirstResponder()
            }else if (strTextFieldSelected == "txtDOB"){
                _ = txtDOB.resignFirstResponder()
                _ = txtPassword.becomeFirstResponder()
            }else if (strTextFieldSelected == "txtPassword"){
                _ = txtPassword.resignFirstResponder()
                _ = txtConfirmPassword.becomeFirstResponder()
            }else if (strTextFieldSelected == "txtConfirmPassword"){
                _ = txtConfirmPassword.resignFirstResponder()
                _ = txtPhoneNumber.becomeFirstResponder()
            }else if (strTextFieldSelected == "txtPhoneNumber"){
                _ = txtPhoneNumber.resignFirstResponder()
            }
        }else{
            if (strTextFieldSelected == "txtPhoneNumber"){
                _ = txtPhoneNumber.resignFirstResponder()
                _ = txtConfirmPassword.becomeFirstResponder()
            }else if (strTextFieldSelected == "txtConfirmPassword"){
                _ = txtConfirmPassword.resignFirstResponder()
                _ = txtPassword.becomeFirstResponder()
            }else if (strTextFieldSelected == "txtPassword"){
                _ = txtPassword.resignFirstResponder()
                _ = txtDOB.becomeFirstResponder()
            }else if (strTextFieldSelected == "txtDOB"){
                _ = txtDOB.resignFirstResponder()
                _ = txtEmail.becomeFirstResponder()
            }else if (strTextFieldSelected == "txtEmail"){
                _ = txtEmail.resignFirstResponder()
                _ = txtLastName.becomeFirstResponder()
            }else if (strTextFieldSelected == "txtLastName"){
                _ = txtLastName.resignFirstResponder()
                _ = txtFirstName.becomeFirstResponder()
            }else if (strTextFieldSelected == "txtFirstName"){
                _ = txtFirstName.resignFirstResponder()
            }
        }
    }
    
    @objc func resignKeyboard() {
        _ = txtFirstName.resignFirstResponder()
        _ = txtLastName.resignFirstResponder()
        _ = txtEmail.resignFirstResponder()
        _ = txtPassword.resignFirstResponder()
        _ = txtConfirmPassword.resignFirstResponder()
        _ = txtDOB.resignFirstResponder()
        _ = txtPhoneNumber.resignFirstResponder()
    }
    
    //MARK:- Action Events
    @IBAction func TapBack(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ctrlTermsAndConditions(_ sender:Any){
        if !flagTermsAndConditions{
            flagTermsAndConditions = true
            imgCheckTermsAndConditions.image = UIImage(named: "checkCircle")
        }else{
            flagTermsAndConditions = false
            imgCheckTermsAndConditions.image = UIImage(named: "checkBorder")
        }
    }
    
    @IBAction func TapSignUp(_ sender:Any){
        resignKeyboard()
        let str = validationForm()
        if str.count > 0{
           appDelegateShared.showToastMessage(str)
        }else{
            appDelegateShared.showHudder()
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            let emailPredicate = NSPredicate(format: "email = %@", txtEmail.text!)
            fetchRequest.predicate = emailPredicate
            
            do {
                let result = try managedContext.fetch(fetchRequest)
                appDelegateShared.hideHudder()
                if result.count > 0{
                   appDelegateShared.showToastMessage(NSLocalizedString("String18", comment:"Email has been already used"))
                }else{
                    let userObject = User(context: managedContext)
                    userObject.firstname = txtFirstName.text!
                    userObject.lastname = txtLastName.text!
                    userObject.email = txtEmail.text!
                    userObject.phone = txtPhoneNumber.text!
                    userObject.password = txtPassword.text!
                    userObject.dob = txtDOB.text!
                    
                    do {
                        try managedContext.save()
                        appDelegateShared.showToastMessage(NSLocalizedString("String19", comment:"Please login to use the app"))
                        TapBack(self)
                    } catch {
                        appDelegateShared.showToastMessage(NSLocalizedString("String20", comment:"Please try again!"))
                    }
                }
            }catch{
                appDelegateShared.hideHudder()
            }
        }
    }
    
//MARK:- Validation Form
    func validationForm() -> String{
        var errorMessage = ""
        
        if isEmpty(text1: txtFirstName.text!) {
            errorMessage = NSLocalizedString("String1", comment: "Please enter a valid firstname")
        }else if isEmpty(text1: txtLastName.text!){
            errorMessage = NSLocalizedString("String2", comment: "Please enter a valid lastname")
        }else if !(txtEmail.text!.emailValidation()) {
            errorMessage = NSLocalizedString("String3", comment: "Please enter a valid email")
        }else if isEmpty(text1: txtDOB.text!){
            errorMessage = NSLocalizedString("String7", comment: "Please enter a valid date of birth")
        }else if isEmpty(text1: txtPassword.text!) {
            errorMessage = NSLocalizedString("String4", comment: "Please enter a valid password")
        }else if !(txtPassword.text!.passwordValidation()) {
            errorMessage = NSLocalizedString("String13", comment: "You must enter a valid minimum 6 characters password which consists of at least one uppercase, one lowercase, one number and one special character")
        }else if txtConfirmPassword.text != txtPassword.text {
            errorMessage = NSLocalizedString("String5", comment: "Confirm password doesnot match")
        }else if !(txtPhoneNumber.text!.PhoneNumberValidation()){
            errorMessage = NSLocalizedString("String6", comment: "Please enter a valid phone number")
        }else if !flagTermsAndConditions{
            errorMessage = NSLocalizedString("String11", comment: "Please agree to the Terms and Conditions")
        }else{
            errorMessage = ""
        }
        return errorMessage
    }
    
//MARK:- Show Terms and Conditions View
    @objc func tapLblTnC(){
        self.resignKeyboard()
        
        let TermsConditionsView:TnCView = Bundle.main.loadNibNamed("TnCView", owner: nil, options: nil)![0] as! TnCView
        TermsConditionsView.show(self.view) { (value) in
            self.flagTermsAndConditions = (value == 1) ? false:true
            self.ctrlTermsAndConditions(self)
        }
    }
    
//MARK:- Get Date From Picker
    @objc func getDateFromPicker(_ sender: UIDatePicker) {
        let dateOfBirth = datePicker.date
        let today = NSDate()
        
        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let age = gregorian.components([.year], from: dateOfBirth, to: today as Date, options: [])
        if age.year! >= 18 {
            txtDOB.text = formatter.string(from: sender.date)
        }else {
            txtDOB.text = ""
            appDelegateShared.showToastMessage(NSLocalizedString("String7", comment: "Please enter a valid date of birth"))
        }
    }
}
