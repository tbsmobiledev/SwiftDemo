//
//  CommonData.swift
//  Registration_demo
//
//  Created by TBS17 on 16/09/19.
//  Copyright © 2019 Sazzadhusen Iproliya. All rights reserved.
//

import UIKit

class commonData: NSObject {
    
//MARK:- Response Model
    var msg:String?
    var data:NSArray?
    var status:Bool?
    
//MARK:- Method Initialization
    override init() {}
    
    required init(coder aDecoder: NSCoder) {
        
        if let msgObj = aDecoder.decodeObject(forKey: kMsg) as? String {
            self.msg = msgObj
        }
        
        self.status = aDecoder.decodeObject(forKey: kStatus) as? Bool ?? aDecoder.decodeBool(forKey: kStatus)
        
        
        if let dataObj = aDecoder.decodeObject(forKey: kData) as? NSArray {
            self.data = dataObj
        }
    }
    
    func encode(with aCoder: NSCoder) {
        if let msgObj = self.msg {
            aCoder.encode(msgObj, forKey: kMsg)
        }
        
        if let dataObj = self.data {
            aCoder.encode(dataObj, forKey: kData)
        }
        
        if let statusObj = self.status {
            aCoder.encode(statusObj, forKey: kStatus)
        }
    }
    
    //MARK:-
    func initWithDictionary(_ dict:NSDictionary){
        let dictionary = removeNSNull(dict) as! NSDictionary
        status = dictionary.value(forKey: kStatus ) as?  Bool
        data = dictionary.value(forKey: kData) as? NSArray
        msg = dictionary.value(forKey: kMsg) as? String
    }
}
