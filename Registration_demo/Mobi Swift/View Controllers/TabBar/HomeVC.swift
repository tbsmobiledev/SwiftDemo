//
//  HomeVC.swift
//  Registration_demo
//
//  Created by TBS17 on 16/09/19.
//  Copyright © 2019 Sazzadhusen Iproliya. All rights reserved.
//

import UIKit
import CoreData

class cellHome: SITableCell {
    
    @IBOutlet var lblTitle: SILabel!
    @IBOutlet var lblDesc: SILabel!
    @IBOutlet var imgProfile: UIImageView!
}

class HomeVC: SIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tblHome: UITableView!

    var arrList = [NSDictionary]()
    var arrtblData = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        arrList = [
            ["id":01,"title":"Vending machine","desc":"Most purchased product","image":"vending-machine"],
            ["id":02,"title":"Hover board","desc":"Most trending product","image":"hoverboard"],
            ["id":03,"title":"Baseball kit","desc":"Sports category","image":"baseball"],
            ["id":04,"title":"Skates","desc":"For fun activity","image":"skateboard"],
            ["id":05,"title":"Vending machine","desc":"Most purchased product","image":"vending-machine"],
            ["id":06,"title":"Hover board","desc":"Most trending product","image":"hoverboard"],
            ["id":07,"title":"Baseball kit","desc":"Sports category","image":"baseball"],
            ["id":08,"title":"Skates","desc":"For fun activity","image":"skateboard"]
            ] as [NSDictionary]

        addLatestData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.clear
    }
    
    //MARK:- UIStatusBar Light
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .default
    }
    
//MARK:- Action Events
    @IBAction func TapLogOut(_ sender:Any){
      appDelegateShared.logOut()
    }
    
    //MARK:- Add Data
    func addLatestData(){
        
        for data in arrList{
            let obj = Item(context: managedContext)
            obj.id = data.value(forKey: "id") as! Int16
            obj.title = data.value(forKey: "title") as? String
            obj.desc = data.value(forKey: "desc") as? String
            obj.image = data.value(forKey: "image") as? String
        }
        
        appDelegateShared.saveContext()
        
        //fetch all data
        fetchAllData("Item")
    }
    
    //MARK:- Fetch All Data
    func fetchAllData(_ entityName : String){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let sorter: NSSortDescriptor = NSSortDescriptor(key: "id" , ascending: true)
        fetchRequest.sortDescriptors = [sorter]
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            arrtblData = result as! [NSManagedObject]
            tblHome.reloadData()
        
        }catch{
            print((error as NSError).userInfo)
        }
    }
    
//MARK:- UITAble View Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrtblData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellHome", for: indexPath) as! cellHome
        
        let dict = arrtblData[indexPath.row] as! Item
        cell.lblTitle.text = dict.title
        cell.lblDesc.text = dict.desc
        cell.imgProfile.image = UIImage(named: dict.image!)
        cell.imgProfile.layer.cornerRadius = 30 * DeviceScale.SCALE_Y
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 * DeviceScale.SCALE_Y
    }
}
