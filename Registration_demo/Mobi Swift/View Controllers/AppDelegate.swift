//
//  AppDelegate.swift
//  Registration_demo
//
//  Created by TBS17 on 16/09/19.
//  Copyright © 2019 Sazzadhusen Iproliya. All rights reserved.
//

import UIKit
import CoreData

//MARK:- Storyboard Object
let mainSB = UIStoryboard(name: "Main", bundle: nil)
var loginObj = LoginModel()

//Coredata
let managedContext = appDelegateShared.persistentContainer.viewContext

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var HUD: MBProgressHUD!
    var SVHUD: SVProgressHUD!
    var reachability:Reachability!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if getValueFromDefault(key: UDKey.isLogin) is String && (getValueFromDefault(key: UDKey.isLogin) as! String) == "Yes"{
            loginObj = getModelDataInUserDefaults(UDKey.modelLogin) as! LoginModel
            
            let initVC = mainSB.instantiateViewController(withIdentifier: "TabBarVC") as! UITabBarController
            appDelegateShared.window?.rootViewController = initVC
        }
        deleteAllData("Item")
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Mobi_Swift")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    //MARK:- MBProgressHUD Toast Message
    func showToastMessage(_ message:String) -> Void {
        HUD = MBProgressHUD.showAdded(to: self.window, animated: true)
        HUD?.mode = MBProgressHUDModeText
        HUD?.detailsLabelText = message
        HUD?.detailsLabelColor = UIColor.white
        HUD?.yOffset = Float(50.0 * DeviceScale.SCALE_Y)
        HUD?.detailsLabelFont = UIFont.systemFont(ofSize: (17 * DeviceScale.SCALE_X))
        HUD?.dimBackground = false
        HUD?.sizeToFit()
        HUD?.color = ThemeYellow
        HUD?.margin = 10.0
        HUD?.removeFromSuperViewOnHide = true
        HUD?.hide(true, afterDelay: 2.0)
    }
    
    //MARK:- SVProgressHUD Hudder Method
    func showHudder(){ 
        SVProgressHUD.setDefaultAnimationType(.flat)
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setBackgroundColor(ThemeYellow)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setContainerView(appDelegateShared.window!)
        SVProgressHUD.show()
    }
    
    func hideHudder() {
        SVProgressHUD.dismiss()
    }
    
    //MARK:- Reachability Network Connection
    func isNetworkAvailable() -> Bool {
        reachability = Reachability.forInternetConnection()
        reachability?.startNotifier()
        
        var status: NetworkStatus?
        status = reachability?.currentReachabilityStatus()
        
        if status == NotReachable {
            return false
        }else if (status == ReachableViaWiFi){
            return true
        }else if (status == ReachableViaWWAN){
            return true
        }else{
            return false
        }
    }
    
    //MARK:- Delete All Data
    func deleteAllData(_ entityName: String){
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
        }catch{
            print((error as NSError).userInfo)
        }
    }

    //MARK:- Logout
    func logOut(){
        
        let alert = UIAlertController.init(title: NSLocalizedString("String22", comment:"Logout"), message: NSLocalizedString("String23", comment:"Are you sure you want to logout?"), preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("String24", comment:"Cancel"), style: .cancel, handler: { (action) -> Void in })
        let okBtn = UIAlertAction(title: NSLocalizedString("String25", comment:"Ok"), style: .default, handler: { (action) -> Void in
            
            let initVC = mainSB.instantiateViewController(withIdentifier: "mainNavigation") as! UINavigationController
            setValueToDefault(value: "false", key: UDKey.isLogin)
            appDelegateShared.window?.rootViewController = initVC
        })
        
        alert.addAction(okBtn)
        alert.addAction(cancel)
        self.window?.rootViewController!.present(alert, animated: true, completion: nil)
    }
}

