//
//  ListVC.swift
//  Registration_demo
//
//  Created by TBS17 on 17/09/19.
//  Copyright © 2019 Sazzadhusen Iproliya. All rights reserved.
//

import UIKit
import CoreData

class cellTopRated : SICollectionCell {
    
    @IBOutlet var lblTitle: SILabel!
    @IBOutlet var lblDesc: SILabel!
    @IBOutlet var imgProfile: UIImageView!
}

class ListVC: SIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectTopRated: UICollectionView!
    
    var arrList = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAllData("Item")
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
    
    //MARK:- Fetch All Data
    func fetchAllData(_ entityName : String){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let sorter: NSSortDescriptor = NSSortDescriptor(key: "id" , ascending: true)
        fetchRequest.sortDescriptors = [sorter]
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            arrList = result as! [NSManagedObject]
            collectTopRated.reloadData()
        }catch{
            print((error as NSError).userInfo)
        }
    }
    
    //MARK:- UICollectionView delegate methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellTopRated", for: indexPath) as! cellTopRated
        
        let dict = arrList[indexPath.row] as! Item
        cell.lblTitle.text = dict.title
        cell.lblDesc.text = dict.desc
        cell.imgProfile.image = UIImage(named: dict.image!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 0 || indexPath.row == 3{
            return CGSize(width: UIScreen.main.bounds.width - 15, height: UIScreen.main.bounds.width / 2)
        }
        return CGSize(width: (UIScreen.main.bounds.width / 2) - 15, height: UIScreen.main.bounds.width / 2)
    }
}
