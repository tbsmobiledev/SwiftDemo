//
//  WebAPI.swift
//  Strongco
//
//  Created by TBS21 on 5/23/18.
//  Copyright © 2018 Sazzad Iproliya. All rights reserved.
//

import Foundation
import UIKit

func getAPIdata(requestType type: String, url apiUrl: String, parameter parameters: NSDictionary, contentType contentTypes: String, isHudShow isHudCall: Bool, withBlocks block: @escaping (_ jsonObject: NSDictionary, _ status: Int) -> Void){
    
    if appDelegateShared.isNetworkAvailable() {
        
        let urlString = apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlString!)!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(WebURL.headerValue, forHTTPHeaderField: WebURL.headerKey)
        urlRequest.setValue(contentTypes, forHTTPHeaderField: "Content-Type")
        urlRequest.timeoutInterval = 30
        
        if type == "POST" {
            urlRequest.httpMethod = "POST"
            do{
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {}
        }else if type == "GET" {
            urlRequest.httpMethod = "GET"
        }
        
        if isHudCall {
            appDelegateShared.showHudder()
        }
        
        request(urlRequest).responseJSON { response in
            if isHudCall {
                appDelegateShared.hideHudder()
            }
            
            switch response.result{
            case .success:
                if let JSON = response.result.value {
                    block(JSON as! NSDictionary, 1)
                }
            case .failure(let error):
                block([:], 0)
                print(error.localizedDescription)
            }
        }
    }
    else {
        showAlert(msg: alertDefault.connectionFail)
    }
}

func getAPIFormData(requestType type: String, url apiUrl: String, formData datas: NSDictionary, parameter parameters: NSDictionary, contentType contentTypes: String, isHudShow isHudCall: Bool, withBlocks block: @escaping (_ jsonObject: NSDictionary, _ status: Int) -> Void)
{
    if appDelegateShared.isNetworkAvailable() {
        let urlString = apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlString!)!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(WebURL.headerValue, forHTTPHeaderField: WebURL.headerKey)
        urlRequest.setValue(contentTypes, forHTTPHeaderField: "Content-Type")
        urlRequest.timeoutInterval = 60
        urlRequest.httpMethod = type
        
        if isHudCall {
            appDelegateShared.showHudder()
        }
        
        upload(multipartFormData: { multipartFormData in
            for (key, value) in datas{
                multipartFormData.append(value as! Data, withName: key as! String , fileName: String(key as! String + ".png"), mimeType: "image/jpeg")
            }
            
            for (key, value) in parameters{
                
                if value is String {
                    multipartFormData.append((value as! String).data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key as! String)
                }else if value is Int {
                    multipartFormData.append((String(value as! Int)).data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key as! String)
                }else if value is NSDictionary || value is NSArray {
                    let data = try? JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    multipartFormData.append(data!, withName: key as! String)
                }
            }
            
        }, with: urlRequest, encodingCompletion: { encodingResult in
            if isHudCall {
                appDelegateShared.hideHudder()
            }
            
            switch encodingResult{
            case .success(let upload, _, _):
                upload
                    .uploadProgress(closure: { (Progress) in
                    })
                    .validate(statusCode: 200 ..< 300)
                    .responseJSON { response in
                        switch response.result {
                        case .success:
                            if let JSON = response.result.value {
                                block(JSON as! NSDictionary, 1)
                            }
                        case .failure(let error):
                            block([:], 0)
                            showAlert(msg: error.localizedDescription)
                        }
                }
            case .failure(let error):
                block([:], 0)
                showAlert(msg: error.localizedDescription)
            }
        })
    }
    else {
        showAlert(msg: alertDefault.connectionFail)
    }
}
