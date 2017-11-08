//
//  WebServiceManger.swift
//  RvWebserviceManager
//
//  Created by Ravi Vora on 18/03/16.
//  Copyright © 2016 Ravi Vora. All rights reserved.
//

import UIKit


class RvWebserviceManager{

    static let sharedManager : RvWebserviceManager = {
        let instance = RvWebserviceManager()
        return instance
    }()
    
   

    
    // MARK: - Fetch Online Data


    func fetchData(_ viewController:UIViewController?, dictparamters : Dictionary<String, AnyObject>? ,APIName:String?,HTTPType :String?,completion: @escaping (_ responseDictionary : Dictionary<String, AnyObject>) -> Void) {
        
        SharedClass.sharedInstance.hasConnectivity(completion: { (checkConnection:String?) -> Void in
            
            if  checkConnection == "Not reachable" {
                
                print("Internet connection FAILED")
                
                if viewController != nil {
                    SharedClass.sharedInstance.showAlertController(viewController!, Message:MessageConstant.commonMessages.noInternetConn)
                }
                SharedClass.sharedInstance.showProgressHUD(false)
                return
            }
        })
       
        
        let strBase:String = AppConstants.webserviceConstants.kBaseURL
        let authToken:String = ""
        let strApiName:String = APIName!
        
        let finalURLString:String =  strApiName == "index/lights" ? strBase.replace("mobservices/", replacement: "") + strApiName : strBase + strApiName
        
        if HTTPType == "POST" {
            
            SharedWebServiceClass.sharedInstance.PostWeb_Service_Body(finalURLString as String, authToken:authToken, httpMethod: HTTPType! as String, parameters:dictparamters!, completionHandler:{(data : Data?, response : URLResponse?, error :Error?) in
                
                if response != nil {
                    
                    let responseHttp:HTTPURLResponse = response as! HTTPURLResponse
                    
                    if responseHttp.statusCode == 200 {
                        
                       // if (data != nil) {
                            do {
                                
                              //  let convertedString = String(data: data!, encoding:.utf8)
                                
                              //  print(convertedString)
                                
                                let JSON = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                           
                                
                                let JSONDictionary:Dictionary<String,AnyObject> = JSON
                                
                                print("JSONDictionary! \(JSONDictionary)")
                                SharedClass.sharedInstance.showProgressHUD(false)

                                completion(JSONDictionary)
                            }
                            catch let JSONError as Error? {
                                print("\(String(describing: JSONError))")
                                
                                SharedClass.sharedInstance.showProgressHUD(false)
                                
                                SharedClass.sharedInstance.showAlertController(viewController!, Message: (JSONError?.localizedDescription)!)
                            }
                        }
                    }
                    else {
                        SharedClass.sharedInstance.showProgressHUD(false)
                        SharedClass.sharedInstance.showAlertController(viewController!, Message: MessageConstant.commonMessages.serverFailed)
                    }
               // }
            })

        }
        else if HTTPType == "GET" || HTTPType == "PUT" || HTTPType == "DELETE" {
            
            SharedWebServiceClass.sharedInstance.GetWeb_Service(finalURLString as String, authToken: authToken, httpMethod: HTTPType!, completionHandler:{(data : Data?, response : URLResponse?, error :Error?) in
                
                if response != nil {
                    
                   // let responseHttp:HTTPURLResponse = response as! HTTPURLResponse
                    
                    // patch from server side

                   // if responseHttp.statusCode == 200 {
                        
                        if (data != nil)
                        {
                            do {
                                
                                let convertedString = String(data: data!, encoding:.utf8)
                                
                                let JSON = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : Any]
                                
                                completion(JSON as Dictionary<String,AnyObject>)
                            }
                            catch let JSONError as Error? {
                                print("\(String(describing: JSONError))")
                            }
                        }
                        else {
                            SharedClass.sharedInstance.showAlertController(viewController!, Message: MessageConstant.commonMessages.serverFailed)
                        }
                   // }
                }
            })
        }
    }
    
    
    // MARK: - Fetch Offline Data

    
    func saveAndFetchOfflineData(_ filename:String,jsonString:String,completion: (_ cachedDictionary:Dictionary <String,AnyObject>?) -> Void) {
        
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first {
            let path = URL(fileURLWithPath: dir).appendingPathComponent(filename)
            
            //writing
            do {
                try jsonString.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            }
            catch {/* error handling here */}
            
            //reading
            do {
                let JSON : Dictionary <String,AnyObject>?
                let outputjsonString = try NSString(contentsOf: path, encoding: String.Encoding.utf8.rawValue)
                 JSON = convertStringToDictionary(outputjsonString as String)
             //   print("JSON! \(JSON)")
                completion(JSON)
            }
            catch {/* error handling here */}
        }
    }
    
    
    func convertStringToDictionary(_ text: String) -> [String:AnyObject]? {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }

}
