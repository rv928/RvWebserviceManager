//
//  LoginViewController.swift
//  RvWebserviceManager
//
//  Created by Ravi Vora on 08/11/17.
//  Copyright © 2017 Ravi Vora. All rights reserved.
//

import UIKit

class SpaceListController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.callwebserviceForFetchSpaceList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK:- Webservice Methods
    
    func callwebserviceForFetchSpaceList() {
        
        SharedClass.sharedInstance.showProgressHUD(true)
        
        RvWebserviceManager.sharedManager.fetchData(self, dictparamters: nil, APIName: AppConstants.webserviceConstants.API_GETDEVICES, HTTPType: "GET", completion: {(responseDictionary:[String:AnyObject]) -> Void in
            
            let status = responseDictionary[ResponseConstant.status] as AnyObject
            
            if String(describing: status) != ResponseConstant.statusFail {
                
                DispatchQueue.main.async {
                    
                    SharedClass.sharedInstance.showProgressHUD(false)

                    if (responseDictionary[ResponseConstant.data] is NSNull){
                        
                    }
                    else {
                        let objSpaceList:SpaceList = SpaceList(array: responseDictionary[ResponseConstant.data] as! Array<AnyObject>)
                       print(objSpaceList)
                    }
                }
            }
            else {
                
                let msg:String = responseDictionary[ResponseConstant.responseMessage] as! String
                
                if msg == ResponseConstant.statusTokenExpireMessage {
                    
                   /* SharedClass.sharedInstance.callwebserviceForTokens(viewController: self, completion:{ (_ isToken:Bool?) -> Void in
                        
                        if isToken == true {
                            self.callwebserviceForFetchDeviceList()
                        }
                    })
                    */
                }
                else {
                    SharedClass.sharedInstance.showAlertController(self, Message: (responseDictionary[ResponseConstant.responseMessage] as? String)!)
                }
            }
        })
    }
    
   

}
