//
//  LoginModel.swift
//  Registration_demo
//
//  Created by TBS17 on 16/09/19.
//  Copyright © 2019 Sazzadhusen Iproliya. All rights reserved.
//

import Foundation

class LoginModel: NSObject, NSCoding {

    var userId:Int!
    var firstName:String!
    var lastName:String!
    var email:String!
    var mobile:String!
    var dob:String!
    
    override init() {}

    required init(coder aDecoder: NSCoder) {
        self.userId = aDecoder.decodeObject(forKey: kuserId) as? Int ?? aDecoder.decodeInteger(forKey: kuserId)
   
        if let obj = aDecoder.decodeObject(forKey: kfirstName) as? String {
            self.firstName = obj
        }
        if let obj = aDecoder.decodeObject(forKey: klastName) as? String {
            self.lastName = obj
        }
        if let obj = aDecoder.decodeObject(forKey: kemail) as? String {
            self.email = obj
        }
        if let obj = aDecoder.decodeObject(forKey: kmobile) as? String {
            self.mobile = obj
        }
        if let obj = aDecoder.decodeObject(forKey: kdob) as? String {
            self.dob = obj
        }
    }

    func encode(with aCoder: NSCoder) {
        if let obj = self.userId {
            aCoder.encode(obj, forKey: kuserId)
        }
        if let obj = self.firstName {
            aCoder.encode(obj, forKey: kfirstName)
        }
        if let obj = self.lastName {
            aCoder.encode(obj, forKey: klastName)
        }
        if let obj = self.email {
            aCoder.encode(obj, forKey: kemail)
        }
        if let obj = self.mobile {
            aCoder.encode(obj, forKey: kmobile)
        }
        if let obj = self.dob {
            aCoder.encode(obj, forKey: kdob)
        }
    }

    func initWithDictionary(_ dict:NSDictionary){
        let dictionary = removeNSNull(dict) as! NSDictionary
        userId = dictionary.value(forKey: kuserId) as? Int
        firstName = dictionary.value(forKey: kfirstName) as?  String ?? ""
        lastName = dictionary.value(forKey: klastName) as?  String ?? ""
        email = dictionary.value(forKey: kemail) as? String ?? ""
        mobile = dictionary.value(forKey: kmobile) as?  String ?? ""
        dob = dictionary.value(forKey: kdob) as?  String ?? ""
    }
}

