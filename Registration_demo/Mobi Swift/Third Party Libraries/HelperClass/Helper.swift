//
//  Helper.swift
//
//
//  Created by TBS02 on 23/05/17.
//  Copyright © 2017 Sazzad Iproliya. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import LocalAuthentication

//MARK:- Alert Messages
struct alertDefault {
    static let webServiceFail:String = "Server could not connect. Please try again later."
    static let connectionFail:String = "Please enable your internet connection."
}

//MARK:- App Theme Color
let ThemeYellow = setColor(r: 232, g: 166, b: 0, alpha: 1)
let ThemeGreen = setColor(r: 40, g: 190, b: 175, alpha: 1)
let ThemeOrange = setColor(r: 244, g: 156, b: 0, alpha: 1)
let ThemeRed = setColor(r: 255, g: 0, b: 0, alpha: 1)

//MARK:- Show Alert
func showAlert(msg:String){
    let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    appDelegateShared.window?.rootViewController?.present(alert, animated: true, completion: nil)
}

func showAlertWithDelegate(_ title:String, msg:String, withBlocks block: @escaping (_ status: Int) -> Void){
    let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (Finish) in
        block(1)
    }))
    appDelegateShared.window?.rootViewController?.present(alert, animated: true, completion: nil)
}

//MARK:- Device Type
enum UIUserInterfaceIdiom : Int {
    case Unspecified
    case Phone
    case Pad
}

struct DeviceType {
    static let IS_IPHONE_4_OR_LESS    = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5            = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6            = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6PLUS        = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X_OR_XS      = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    static let IS_IPHONE_XR_OR_XSMax  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 896.0
    static let IS_IPAD                = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    static let IS_IPAD_PRO_10         = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1112.0
    static let IS_IPAD_PRO_12         = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
}

//MARK:- Device iOS Version
struct DeviceVersion {
    static let Device = UIDevice.current
    static let iosVersion = NSString(string: Device.systemVersion).doubleValue
    static let iOS9 = iosVersion >= 9
    static let iOS10 = iosVersion >= 10
    static let iOS11 = iosVersion >= 11
    static let iOS12 = iosVersion >= 12
}

//MARK: - AppDelagate Object
var appDelegateShared = UIApplication.shared.delegate as! AppDelegate

//MARK: - Screen Size
struct ScreenSize {
    static let WIDTH         = UIScreen.main.bounds.size.width
    static let HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.WIDTH, ScreenSize.HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.WIDTH, ScreenSize.HEIGHT)
}

//MARK: - Font Layout
struct FontName {
    //Font Name List
    static let HelveticaNeueBoldItalic = "HelveticaNeue-BoldItalic"
    static let HelveticaNeueLight = "HelveticaNeue-Light"
    static let HelveticaNeueUltraLightItalic = "HelveticaNeue-UltraLightItalic"
    static let HelveticaNeueCondensedBold = "HelveticaNeue-CondensedBold"
    static let HelveticaNeueMediumItalic = "HelveticaNeue-MediumItalic"
    static let HelveticaNeueThin = "HelveticaNeue-Thin"
    static let HelveticaNeueMedium = "HelveticaNeue-Medium"
    static let HelveticaNeueRegular = "HelveticaNeue"
    static let HelveticaNeueThinItalic = "HelveticaNeue-ThinItalic"
    static let HelveticaNeueLightItalic = "HelveticaNeue-LightItalic"
    static let HelveticaNeueUltraLight = "HelveticaNeue-UltraLight"
    static let HelveticaNeueBold = "HelveticaNeue-Bold"
    static let HelveticaNeue = "HelveticaNeue"
    static let HelveticaNeueCondensedBlack = "HelveticaNeue-CondensedBlack"
}

func setFontLayout(strFontName:String,fontSize:CGFloat) -> UIFont {
    //Set auto font size in different devices.
    return UIFont(name: strFontName, size: (ScreenSize.WIDTH / 375) * fontSize)!
}

//MARK:- Remove WhiteSpace and New Line Space
func TrimString(_ string:String) -> String
{
    var trimmedString:String?
    trimmedString = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    return trimmedString!
}

//MARK:- Set Color Method
func setColor(r: Float, g: Float, b: Float, alpha: Float)-> UIColor {
  return UIColor(red: CGFloat(Float(r / 255.0)), green: CGFloat(Float(g / 255.0)) , blue: CGFloat(Float(b / 255.0)), alpha: CGFloat(alpha))
}

func setDisplayP3Color(r: Float, g: Float, b: Float, alpha: Float)-> UIColor {
    return UIColor(displayP3Red: CGFloat(Float(r / 255.0)), green: CGFloat(Float(g / 255.0)) , blue: CGFloat(Float(b / 255.0)), alpha: CGFloat(alpha))
}

//MARK:- Set Color With RGB Method
func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

//MARK: - Scaling
struct DeviceScale {
    static let SCALE_X = ScreenSize.WIDTH / 375.0
    static let SCALE_Y = ScreenSize.HEIGHT / 812.0
}

//MARK: - Helper Class
class Helper {
    //MARK: - Shared Instance
    static let sharedInstance : Helper = {
        let instance = Helper()
        return instance
    }()
    
    static let isDevelopmentBuild:Bool = true
    
    //MARK: - Convert Second TO Hours,Minutes and Seconds
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    //MARK: - Add zero before single digit
    func addZeroBeforeDigit(number: Int) -> String {
        return ((number > 9) ? (String.init(format: "%d", number)) : (String.init(format: "0%d", number)))
    }
}

//MARK: - UILabel Extension
extension UILabel {
    //Set line spacing between two lines.
    func setLineHeight(lineHeight: CGFloat) {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            
            style.lineSpacing = lineHeight
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, text.count))
            self.attributedText = attributeString
        }
    }
    //Set notification counter with dynamic width calculate
    func setNotificationCounter(counter: String) {
        if counter.length == 0 {
            self.isHidden = true
        }else {
            self.isHidden = false
            let strCounter:String = ":\(counter)|"
            
            self.clipsToBounds = true
            self.layer.cornerRadius = self.frame.size.height / 2.0
            
            let string_to_color1 = ":"
            let range1 = (strCounter as NSString).range(of: string_to_color1)
            let attributedString1 = NSMutableAttributedString(string:strCounter)
            attributedString1.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.clear , range: range1)
            
            let string_to_color2 = "|"
            let range2 = (strCounter as NSString).range(of: string_to_color2)
            attributedString1.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.clear , range: range2)
            self.attributedText = attributedString1
        }
    }
    //Get notification counter
    func getNotificationCounter() -> String {
        if self.text?.length == 0 {
            return ""
        }else{
            var strCounter = self.text
            strCounter = strCounter?.replacingOccurrences(of: ":", with: "")
            strCounter = strCounter?.replacingOccurrences(of: "|", with: "")
            return strCounter!
        }
    }
    //Get dynamic height
    func requiredHeight() -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: self.frame.width, height : CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = self.font
        label.text = self.text
        label.sizeToFit()
        return label.frame.height
    }
    //Get dynamic width
    func requiredWidth() -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: self.frame.width,height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = self.font
        label.text = self.text
        label.sizeToFit()
        return label.frame.width
    }
}

//Get dynamic label width
func widthForLabel(label:UILabel,text:String) ->CGFloat
{
    let fontName = label.font.fontName;
    let fontSize = label.font.pointSize;
    
    let attributedText = NSMutableAttributedString(string: text,attributes: [NSAttributedString.Key.font:UIFont(name: fontName,size: fontSize)!])
    let rect: CGRect = attributedText.boundingRect(with: CGSize(width: label.frame.size.width, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
    
    return ceil(rect.size.width)
}
//MARK: - UIApplication Extension
extension UIApplication {
    class func topViewController(viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(viewController: nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(viewController: selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(viewController: presented)
        }
        return viewController
    }
}
//MARK: - String Extension
extension String {
    //Get string length
    var length: Int {
        return count
    }
    
    //Remove white space in string
    func removeWhiteSpace() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).capitalized + dropFirst()
    }
}

//MARK: - NSString Extension
extension NSString {
    //Remove white space in string
    func removeWhiteSpace() -> NSString {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces) as NSString
    }
}

//MARK: - UISearchBar Class Modify
extension UISearchBar
{
    //UISearchBar Text Color
    func setTextColor(color: UIColor) {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf.textColor = color
    }
    //UISearchBar Set Font
    func setFont(font: UIFont) {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf.font = font
    }
    //UISearchBar Placeholder Text Color
    func setPlaceholderColor(color: UIColor) {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf .setValue(color, forKeyPath: "_placeholderLabel.textColor")
    }
}

//MARK: - Create thumbnail image
    func smallImageWithImage(sourceImage: UIImage) -> UIImage {
        var width:Int = 0
        var height:Int = 0
        let y = sourceImage.size.height
        let x = sourceImage.size.width
        
        if sourceImage.size.height > 175 || sourceImage.size.width > 175 {
            if sourceImage.size.height > sourceImage.size.width {
                height = 175
                width = 0
            }else {
                height = 0
                width = 175
            }
        }
        
        var factor:Double = 1.0
        if width > 0 {
            factor = (Double(width) / Double(x) ) as Double
        }
        else if height > 0 {
            factor = Double(height) / Double(y)
        }
        
        let newHeight = Double(y) * factor
        let newWidth = Double(x) * factor
        
        UIGraphicsBeginImageContext(CGSize(width : CGFloat(newWidth),height :  CGFloat(newHeight)))
        sourceImage.draw(in: CGRect(x : 0,y : 0,width : CGFloat(newWidth),height : CGFloat(newHeight)))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }

//MARK: - NSDate Extention for UTC date
extension Date {
    var getAppThemeDateFormateInString: String {
        let dateFormatter = DateFormatter()
        let timeZone = NSTimeZone(name: "UTC")
        dateFormatter.timeZone = timeZone as TimeZone?
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: self)
    }
    
    var getAppThemeDateFormateInDate: Date {
        let dateFormatter = DateFormatter()
        let timeZone = NSTimeZone(name: "UTC")
        dateFormatter.timeZone = timeZone as TimeZone?
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: self).getAppThemeDateFormateInDate1
    }
    
    var getSystemFormateDate: String {
        let dateFormatter = DateFormatter()
        let timeZone = NSTimeZone.system
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = "dd/MM/yy hh:mma"
        return dateFormatter.string(from: self)
    }
}

extension String {
    var getAppThemeDateFormateInDate: Date {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        format.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        return format.date(from: self)!
    }
    
    var getAppThemeDateFormateInDate1: Date {
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy"
        format.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        return format.date(from: self)!
    }
    
    var stringLocalized:String {
        return NSLocalizedString(self, comment: self)
    }
}

//MARK: - UIView Extension
extension UIView {

//MARK: - IBInspectable
    //Set Corner Radious
    @IBInspectable var cornerRadius:CGFloat {
        set {
            self.layer.cornerRadius = newValue
        }
        get {
            return self.layer.cornerRadius
        }
    }
    //Set Round
    @IBInspectable var Round:Bool {
        set {
            self.layer.cornerRadius = self.frame.size.height / 2.0
        }
        get {
            return self.layer.cornerRadius == self.frame.size.height / 2.0
        }
    }
    //Set Border Color 
    @IBInspectable var borderColor:UIColor {
        set {
            self.layer.borderColor = newValue.cgColor
        }
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
    }
    //Set Border Width
    @IBInspectable var borderWidth:CGFloat {
        set {
            self.layer.borderWidth = newValue
        }
        get {
            return self.layer.borderWidth
        }
    }
    
    //Set Shadow Color
    @IBInspectable var ShdwColor:UIColor {
        set {
            self.layer.shadowColor = newValue.cgColor
        }
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
    }
    
    //Set Shadow Offset
    @IBInspectable var ShdwOffset:CGSize  {
        set {
            self.layer.shadowOffset = newValue
        }
        get {
            return self.layer.shadowOffset
        }
    }
    
    //Set Shadow Opacity
    @IBInspectable var ShdwOpacity:CGFloat {
        set {
            self.layer.shadowOpacity = Float(newValue)
        }
        get {
            return CGFloat(self.layer.shadowOpacity)
        }
    }
    
    //Set Shadow Radius
    @IBInspectable var ShdwRadius:CGFloat {
        set {
            self.layer.shadowRadius = newValue
        }
        get {
            return self.layer.shadowRadius
        }
    }
    
    //Set Shadow in View
    func addShadowView(width:CGFloat=0.2, height:CGFloat=0.2, Opacidade:Float=0.7, maskToBounds:Bool=false, radius:CGFloat=0.5){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = Opacidade
        self.layer.masksToBounds = maskToBounds
    }
    struct NLInnerShadowDirection: OptionSet {
        let rawValue: Int
        
        static let None = NLInnerShadowDirection(rawValue: 0)
        static let Left = NLInnerShadowDirection(rawValue: 1 << 0)
        static let Right = NLInnerShadowDirection(rawValue: 1 << 1)
        static let Top = NLInnerShadowDirection(rawValue: 1 << 2)
        static let Bottom = NLInnerShadowDirection(rawValue: 1 << 3)
        static let All = NLInnerShadowDirection(rawValue: 15)
    }
    
    func removeInnerShadow() {
        for view in self.subviews {
            if (view.tag == 2639) {
                view.removeFromSuperview()
                break
            }
        }
    }
    
    func addInnerShadow() {
        let c = UIColor()
        let color = c.withAlphaComponent(0.5)
        
        self.addInnerShadowWithRadius(radius: 3.0, color: color, inDirection: NLInnerShadowDirection.All)
    }
    
    func addInnerShadowWithRadius(radius: CGFloat, andAlpha: CGFloat) {
        let c = UIColor()
        let color = c.withAlphaComponent(alpha)
        
        self.addInnerShadowWithRadius(radius: radius, color: color, inDirection: NLInnerShadowDirection.All)
    }
    
    func addInnerShadowWithRadius(radius: CGFloat, andColor: UIColor) {
        self.addInnerShadowWithRadius(radius: radius, color: andColor, inDirection: NLInnerShadowDirection.All)
    }
    
    func addInnerShadowWithRadius(radius: CGFloat, color: UIColor, inDirection: NLInnerShadowDirection) {
        self.removeInnerShadow()
        
        let shadowView = self.createShadowViewWithRadius(radius: radius, andColor: color, direction: inDirection)
        
        self.addSubview(shadowView)
    }
    
    func createShadowViewWithRadius(radius: CGFloat, andColor: UIColor, direction: NLInnerShadowDirection) -> UIView {
        let shadowView = UIView(frame: CGRect(x: 0,y: 0,width: self.bounds.size.width,height: self.bounds.size.height))
        shadowView.backgroundColor = UIColor.clear
        shadowView.tag = 2639
        
        let colorsArray: Array = [ andColor.cgColor, UIColor.clear.cgColor ]
        
        if direction.contains(.Top) {
            let xOffset: CGFloat = 0.0
            let topWidth = self.bounds.size.width
            
            let shadow = CAGradientLayer()
            shadow.colors = colorsArray
            shadow.startPoint = CGPoint(x:0.5,y: 0.0)
            shadow.endPoint = CGPoint(x:0.5,y: 1.0)
            shadow.frame = CGRect(x: xOffset,y: 0,width: topWidth,height: radius)
            shadowView.layer.insertSublayer(shadow, at: 0)
        }
        
        if direction.contains(.Bottom) {
            let xOffset: CGFloat = 0.0
            let bottomWidth = self.bounds.size.width
            
            let shadow = CAGradientLayer()
            shadow.colors = colorsArray
            shadow.startPoint = CGPoint(x:0.5,y: 1.0)
            shadow.endPoint = CGPoint(x:0.5,y: 0.0)
            shadow.frame = CGRect(x:xOffset,y: self.bounds.size.height - radius, width: bottomWidth,height: radius)
            shadowView.layer.insertSublayer(shadow, at: 0)
        }
        
        if direction.contains(.Left) {
            let yOffset: CGFloat = 0.0
            let leftHeight = self.bounds.size.height
            
            let shadow = CAGradientLayer()
            shadow.colors = colorsArray
            shadow.frame = CGRect(x:0,y: yOffset,width: radius,height: leftHeight)
            shadow.startPoint = CGPoint(x:0.0,y: 0.5)
            shadow.endPoint = CGPoint(x:1.0,y: 0.5)
            shadowView.layer.insertSublayer(shadow, at: 0)
        }
        
        if direction.contains(.Right) {
            let yOffset: CGFloat = 0.0
            let rightHeight = self.bounds.size.height
            
            let shadow = CAGradientLayer()
            shadow.colors = colorsArray
            shadow.frame = CGRect(x:self.bounds.size.width - radius,y: yOffset,width: radius,height: rightHeight)
            shadow.startPoint = CGPoint(x:1.0,y: 0.5)
            shadow.endPoint = CGPoint(x:0.0,y: 0.5)
            shadowView.layer.insertSublayer(shadow, at: 0)
        }
        return shadowView
    }
}
//MARK: - Bundle Information
extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}

//MARK: - SIViewController
class SIViewController : UIViewController {
    //Outlet for auto resizing constraint constant set in different devices
    @IBOutlet var arrWidthConstraint : [NSLayoutConstraint]!
    @IBOutlet var arrHeightConstraint : [NSLayoutConstraint]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if arrWidthConstraint != nil
        {
            //Auto resizing constraint constant set in different devices
            for const in arrWidthConstraint {
                const.constant = const.constant * DeviceScale.SCALE_X
            }
        }
        
        if arrHeightConstraint != nil
        {
            //Auto resizing constraint constant set in different devices
            for const in arrHeightConstraint {
                const.constant = const.constant * DeviceScale.SCALE_Y
            }
        }
    }
}

//MARK: - SIView
class SIView : UIView {
    //Outlet for auto resizing constraint constant set in different devices
    @IBOutlet var arrWidthConstraint : [NSLayoutConstraint]!
    @IBOutlet var arrHeightConstraint : [NSLayoutConstraint]!
    
   override func awakeFromNib() {
    
        if arrWidthConstraint != nil
        {
            //Auto resizing constraint constant set in different devices
            for const in arrWidthConstraint {
                const.constant = const.constant * DeviceScale.SCALE_X
            }
        }
    
        if arrHeightConstraint != nil
        {
            //Auto resizing constraint constant set in different devices
            for const in arrHeightConstraint {
                const.constant = const.constant * DeviceScale.SCALE_Y
            }
        }
    }
}

//MARK: - SICollectionCell
class SICollectionCell: UICollectionViewCell
{
    @IBOutlet var arrCellWidthConstants: [NSLayoutConstraint]!
    @IBOutlet var arrCellHeightConstants: [NSLayoutConstraint]!
    
    override func awakeFromNib() {
     
        if arrCellWidthConstants != nil
        {
            for const in arrCellWidthConstants {
                const.constant = const.constant * DeviceScale.SCALE_X
            }
        }
        
        if arrCellHeightConstants != nil
        {
            for const in arrCellHeightConstants {
                const.constant = const.constant * DeviceScale.SCALE_Y
            }
        }
    }
}

//MARK: - SITableCell
class SITableCell: UITableViewCell
{
    @IBOutlet var arrTableCellWidthConstants: [NSLayoutConstraint]!
    @IBOutlet var arrTableCellHeightConstants: [NSLayoutConstraint]!
    
    override func awakeFromNib() {
        
        if arrTableCellWidthConstants != nil
        {
            for const in arrTableCellWidthConstants {
                const.constant = const.constant * DeviceScale.SCALE_X
            }
        }
        
        if arrTableCellHeightConstants != nil
        {
            for const in arrTableCellHeightConstants {
                const.constant = const.constant * DeviceScale.SCALE_Y
            }
        }
    }
}


//MARK: - SIButton
class SIButton : UIButton {
    override func awakeFromNib() {
        //Font size auto resizing in different devices
        self.titleLabel?.font = self.titleLabel?.font.withSize((self.titleLabel?.font.pointSize)! * DeviceScale.SCALE_X)
    }
}
//MARK: - SILabel
class SILabel : UILabel {
    override func awakeFromNib() {
        //Font size auto resizing in different devices
        self.font = self.font.withSize(self.font.pointSize * DeviceScale.SCALE_X)
    }
}

//MARK: - SISegmentedControl
class SISegmentedControl : UISegmentedControl {
    override func awakeFromNib() {
        //Font size auto resizing in different devices
        let font:[AnyHashable : Any] = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15.0 * DeviceScale.SCALE_X)]
        self.setTitleTextAttributes((font as! [NSAttributedString.Key : Any]), for: .normal)
    }
}


//MARK: - SITextView
class SITextView: UITextView
{
    override open func awakeFromNib() {
        self.font = self.font?.withSize((self.font?.pointSize)! * DeviceScale.SCALE_X)
    }
}

//MARK: - SITextField
class SITextField: UITextField
{
    override open func awakeFromNib() {
        self.font = self.font?.withSize((self.font?.pointSize)! * DeviceScale.SCALE_X)
    }
}

class CPITextField: SITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) || action == #selector(UIResponderStandardEditActions.copy(_:)) || action == #selector(UIResponderStandardEditActions.cut(_:)) || action == #selector(UIResponderStandardEditActions.select(_:)) || action == #selector(UIResponderStandardEditActions.selectAll(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}

//MARK: - UITextfield Extension

extension UITextField {
   
    //Set placeholder font
    func setPlaceholderFont(font: UIFont) {
        let lblPlaceHolder:UILabel = self.value(forKey: "_placeholderLabel") as! UILabel
        lblPlaceHolder.font = font
    }
    //Set placeholder text color
    func setPlaceholderTextColor(color: UIColor) {
        let lblPlaceHolder:UILabel = self.value(forKey: "_placeholderLabel") as! UILabel
        lblPlaceHolder.textColor = color
    }
}

//MARK: - String Empty or not

func isEmpty(text1: String) -> Bool {
    var isBlank: Bool {
        return text1.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    return isBlank
}

//MARK: - Protocol Oriented Programming Language
protocol Shakeable { }

extension Shakeable where Self: UIView {
    
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.03
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x:self.center.x - 4.0, y:self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x:self.center.x + 4.0, y:self.center.y))
        layer.add(animation, forKey: "position")
    }
}
class SIImageView: UIImageView, Shakeable {
    
}
//MARK: - NSMutableArray Extension
extension NSMutableArray {
    func shuffle () {
        for i in (0..<self.count).reversed() {
            let ix1 = i
            let ix2 = Int(arc4random_uniform(UInt32(i+1)))
            (self[ix1], self[ix2]) = (self[ix2], self[ix1])
        }
    }
}
//MARK : - UIColor Extension
extension UIColor {
    static var keyboardColor:UIColor {
        return UIColor(red: 26.0 / 255.0, green: 26.0 / 255.0, blue: 25.0 / 255.0, alpha: 1.0)
    }
}

//MARK : - DispatchQueue Extension (Background Call)
extension DispatchQueue {
    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
    
   /* Different Background Call Method
     
     DispatchQueue.background(delay: 3.0, background: {
     // do something in background
     }, completion: {
     // when background job finishes, wait 3 seconds and do something in main thread
     })
    
    DispatchQueue.background(background: {
    // do something in background
    }, completion:{
    // when background job finished, do something in main thread
    })
    
    DispatchQueue.background(delay: 3.0, completion:{
    // do something in main thread after 3 seconds
    })
     */
}

//MARK:- Check Face ID or Touch ID with Owner BioMetric Authentication
func touchIDAuthentications(vc: SIViewController, withBlocks block: @escaping (_ isAvailable: Int, _ status: Bool, _ index: Int) -> Void) {
    
    let context = LAContext()
    var errorCode: NSError?
    let reason = " "
    context.localizedFallbackTitle = " "
    
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &errorCode) {
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
            (success, authenticationError) in
            if authenticationError == nil{
                block(1,success,10000)
            }
            else{
                block(1,success,authenticationError!._code)
            }
        }
    }
    else{
        block(0,false,0)
    }
}

//MARK:- Check Wheather Face ID Available or Touch ID
extension LAContext {
    enum BiometricType: String {
        case none
        case touchID
        case faceID
    }
    
    var biometricType: BiometricType {
        var error: NSError?
        
        guard self.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return .none
        }
        
        if #available(iOS 11.0, *) {
            switch self.biometryType {
            case .none:
                return .none
            case .touchID:
                return .touchID
            case .faceID:
                return .faceID
            @unknown default: 
                return .none
            }
        } else {
            return  self.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touchID : .none
        }
    }
}

extension UINavigationController {
    func backToViewController(_ viewController: AnyClass) {
        for element in viewControllers as Array {
            if element.isKind(of: viewController) {
                self.popToViewController(element, animated: true)
                break
            }
        }
    }
    
    func backToViewControllerWithPush(_ viewController: AnyClass, storyBoardName:UIStoryboard, viewControllerName:String) {
        var isBack:Bool = false
        for element in viewControllers as Array {
            if element.isKind(of: viewController) {
                self.popToViewController(element, animated: true)
                isBack = true
                break
            }
        }
        
        if !isBack {
            let initVC = storyBoardName.instantiateViewController(withIdentifier: viewControllerName)
            self.navigationController?.pushViewController(initVC, animated: false)
        }
    }
    
    func removeViewControllerFromStack(_ vcClass: AnyClass) -> Bool  {
        for element in viewControllers as Array {
            if element.isKind(of: vcClass) {
                return true
            }
        }
        return false
    }
}

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}

extension NSDecimalNumber {
    public func round(_ decimals:Int) -> NSDecimalNumber {
        return self.rounding(accordingToBehavior:
            NSDecimalNumberHandler(roundingMode: .plain,
                                   scale: Int16(decimals),
                                   raiseOnExactness: false,
                                   raiseOnOverflow: false,
                                   raiseOnUnderflow: false,
                                   raiseOnDivideByZero: false))
    }
}

//MARK:- Replace Comma Character
func replaceCommaCharacter(_ string:String) -> String {
    var replaceValue:String = ""
    replaceValue = string
    replaceValue = replaceValue.replacingOccurrences(of: ",", with: ".")
    return replaceValue
}

//MARK:- Replace Dot Character
func replaceDotCharacter(_ string:String) -> String {
    var replaceValue:String = string
    replaceValue = replaceValue.replacingOccurrences(of: ".", with: ",")
    return replaceValue
}

//MARK:- NumberFromatter
func numberFormatter(_ intValue:Int) -> NumberFormatter {
    let nf = NumberFormatter()
    nf.maximumFractionDigits = intValue
    nf.minimumFractionDigits = intValue
    nf.locale = NSLocale.current
    nf.numberStyle = .currency
    return nf
}

let defaultStd = UserDefaults.standard

//MARK: - Set and Get value from Default
func setValueToDefault(value:Any, key:String){
    defaultStd.set(value, forKey: key)
    defaultStd.synchronize()
}

func getValueFromDefault(key:String) -> Any {
    if defaultStd.value(forKey: key) != nil {
        return defaultStd.value(forKey: key) as Any
    }else{
        return ""
    }
}

func removeValueFromDefault(key:String){
    defaultStd.removeObject(forKey: key)
    defaultStd.synchronize()
}

//MARK:- Remove null value
func removeNSNull(_ data: Any) -> Any {
    if data is NSArray {
        let tempMain = (data as! NSArray).mutableCopy() as! NSMutableArray
        for dict in tempMain {
            if dict is NSNull {
                let Index = tempMain.index(of: dict)
                tempMain.replaceObject(at: Index, with: "")
            }else if dict is NSDictionary {
                let mutableOutDict = removeNSNull(dict)
                let Index = tempMain.index(of: dict)
                tempMain.replaceObject(at: Index, with: mutableOutDict)
            }else if dict is String && (dict as! String == "<null>") {
                let Index = tempMain.index(of: dict)
                tempMain.replaceObject(at: Index, with: "")
            }else if (dict is NSArray) && (dict as! NSArray).count > 0 {
                let tempSub = removeNSNull(dict)
                let Index = tempMain.index(of: dict)
                tempMain.replaceObject(at: Index, with: tempSub)
            }
        }
        return tempMain.mutableCopy() as! NSArray
    }else if data is NSDictionary {
        let mutableDict = (data as! NSDictionary).mutableCopy() as! NSMutableDictionary
        for (key, value) in mutableDict {
            if value is NSNull {
                mutableDict.setValue("", forKey: key as! String)
            }else if value is String && (value as! String == "<null>") {
                mutableDict.setValue("", forKey: key as! String)
            }else if (value is NSArray) && (value as! NSArray).count > 0 {
                let array = removeNSNull(value)
                mutableDict.setValue(array, forKey: key as! String)
            }else if (value is NSDictionary){
                let dict = removeNSNull(value)
                mutableDict.setValue(dict, forKey: key as! String)
            }
        }
        return mutableDict.mutableCopy() as! NSDictionary
    }else if data is String {
        if data is NSNull {
            return ""
        }else {
            return data
        }
    }else {
        return 0
    }
}

//MARK:- Device Model Identifer
func iPhoneDeviceModelIdentifer() -> String {
    if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] { return simulatorModelIdentifier }
    var sysinfo = utsname()
    uname(&sysinfo) // ignore return value
    let modelNumber = String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    let modelArry = modelNumber.components(separatedBy: ",")
    return modelArry[0]
}

//MARK:- Save and Get Model Data from UserDefault
func setModelDataInUserDefaults(_ dataObj:NSObject,  key: String){
    var userData:Data!
    if #available(iOS 11.0, *) {
        do{
            userData = try NSKeyedArchiver.archivedData(withRootObject: dataObj, requiringSecureCoding: false)
        }catch{
            print("Data Model couldnot be saved.")
        }
    }else {
        userData = NSKeyedArchiver.archivedData(withRootObject: dataObj)
    }
    setValueToDefault(value: userData!, key: key)
}

func getModelDataInUserDefaults(_ key: String)-> NSObject{
    let userData = UserDefaults.standard.object(forKey: key)
    var userDataArray = NSObject()
    if userData != nil {
        if #available(iOS 11.0, *) {
            do{
                userDataArray = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(userData as! Data) as! NSObject
            }catch{
                print("Data Model couldnot be saved.")
            }
        }else {
            userDataArray = NSKeyedUnarchiver.unarchiveObject(with: userData! as! Data) as! NSObject
        }
    }
    return userDataArray
}


extension String {
    func emailValidation() -> Bool {
        let regex = "[^@]+@[A-Za-z0-9.-]+\\.[A-Za-z]+"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", regex)
        
        if !(predicate.evaluate(with: self)) {
            return false
        }else {
            return true
        }
    }
    
    func passwordValidation() -> Bool {
        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{6,}"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", regex)
        
        if !(predicate.evaluate(with: self)) {
            return false
        }else {
            return true
        }
    }
    
    func PhoneNumberValidation() -> Bool {
        let regex = "^[0-9]{8,15}$"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", regex)
        
        if !(predicate.evaluate(with: self)) {
            return false
        }else {
            return true
        }
    }
    
    func zipCodeValidation()-> Bool{
        let regex = "^\\d{3} \\d{2}$"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", regex)
        
        if !(predicate.evaluate(with: self)) {
            return false
        }else {
            return true
        }
    }
    
    func isValidDouble(maxDecimalPlaces: Int) -> Bool {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true // Default is true, be explicit anyways
        let decimalSeparator = formatter.decimalSeparator ?? "."
        if formatter.number(from: self) != nil {
            let split = self.components(separatedBy: decimalSeparator)
            let digits = split.count == 2 ? split.last ?? "" : ""
            
            return digits.count <= maxDecimalPlaces
        }
        return false
    }
    
    var base64Encoded:String {
        return (self.data(using: .utf8)!).base64EncodedString()
    }
    
    var base64Decoded:String {
        return String(data: Data(base64Encoded: self)!, encoding: .utf8)!
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

//MARK:- Check String valid with Regex
func regexMatch(source:String,regexStr:String) -> Bool{
    let regex: NSRegularExpression?
    do{
        try regex = NSRegularExpression(pattern: regexStr, options: .caseInsensitive)
    }catch{
        return false
    }
    
    if let matches = regex?.matches(in: source, options: NSRegularExpression.MatchingOptions(rawValue: 0),range: NSMakeRange(0, source.count)) {
        return matches.count > 0
    } else {
        return false
    }
}

//For gradient color

@IBDesignable
open class GradientView: UIButton {
    
    @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}
    
    override open class var layerClass: AnyClass { return CAGradientLayer.self }
    
    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
    
    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors    = [startColor.cgColor, endColor.cgColor]
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}

//MARK:- Get TopView
func topViewController() -> UIViewController {
    return topViewController(UIApplication.shared.keyWindow!.rootViewController!)
}

func topViewController(_ rootViewController: UIViewController) -> UIViewController {
    if (rootViewController is UINavigationController) {
        let navigationController = rootViewController as? UINavigationController
        return topViewController((navigationController?.viewControllers.last)!)
    }
    if (rootViewController is UITabBarController) {
        let tabController = rootViewController as? UITabBarController
        return topViewController(tabController!.selectedViewController!)
    }
    return rootViewController
}

//MARK:- Password Strength
func passwordStatus(_ password: String) -> Int{
    
    let regex1 = ".*[a-z]+.*"
    let regex2 = ".*[0-9]+.*"
    let regex3 = ".*[A-Z]+.*"
    let regex4 = ".*[!&^%$#@()/]+.*"
    let regex5 = "^(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
    
    var strength = 0
    
    if (password.length > 0) && (password.length < 6){
        return 1
    }
    
    if NSPredicate(format: "SELF MATCHES %@", regex1).evaluate(with: password){
        strength += 1
    }
    
    if NSPredicate(format: "SELF MATCHES %@", regex2).evaluate(with: password){
        strength += 1
    }
    
    if NSPredicate(format: "SELF MATCHES %@", regex3).evaluate(with: password){
        strength += 1
    }
    
    if NSPredicate(format: "SELF MATCHES %@", regex4).evaluate(with: password) {
        strength += 1
    }
    
    if NSPredicate(format: "SELF MATCHES %@", regex5).evaluate(with: password){
        strength += 1
    }
    return strength
}
