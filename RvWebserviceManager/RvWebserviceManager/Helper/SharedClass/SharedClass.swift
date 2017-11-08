//
//  SharedClass.swift
//  RvWebserviceManager
//
//  Created by Ravi Vora on 08/11/17.
//  Copyright © 2017 Ravi Vora. All rights reserved.
//

import Foundation
import ReachabilitySwift
import SVProgressHUD
import Foundation


class SharedClass {
    
    static let sharedInstance : SharedClass = {
        let instance = SharedClass()
        return instance
    }()
    
    var urlIdentifier:String = ""
    
    
    
    // MARK: Reachability methods
    
    func hasConnectivity(completion: @escaping (_ interConnected:String) -> Void) {
        
        let reachability = Reachability()!
        
        reachability.whenReachable = { reachability in
            
            DispatchQueue.main.async {
                if reachability.isReachableViaWiFi {
                    print("Reachable via WiFi")
                    completion("Reachable via WiFi")
                    
                } else {
                    print("Reachable via Cellular")
                    completion("Reachable via Cellular")
                }
            }
        }
        
        reachability.whenUnreachable = { reachability in
            
            DispatchQueue.main.async {
                print("Not reachable")
                completion("Not reachable")
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    
    func checkServerReachability(completion: @escaping (_ serverConnected:Bool) -> Void) {
        
        let reachability = Reachability(hostname:AppConstants.webserviceConstants.serverURL)
        
        reachability?.whenReachable = { reachability in
            
            DispatchQueue.main.async {
                if reachability.isReachable {
                    print("Server is Reachable")
                    completion(true)
                }
            }
        }
        
        reachability?.whenUnreachable = { reachability in
            
            DispatchQueue.main.async {
                print("Server is not reachable")
                completion(false)
            }
        }
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
            completion(false)
        }
    }
    
    
    
    // MARK: AlertController methods
    
    
    func showAlertController(_ controllerObj:UIViewController,Message:String) {
        
        DispatchQueue.main.async(execute: {
            let alert = UIAlertController(title: AppConstants.APP_NAME, message: Message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            controllerObj.present(alert, animated: true, completion: nil)
            //  appde.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
        })
    }
    
    
    // MARK: ProgressHUD methods
    
    func showProgressHUD(_ isShow:Bool) {
        
        if isShow == true {
            
            SVProgressHUD.setBackgroundColor(self.colorWithHexStringAndAlpha(UIConstant.ProgressHUD.backgroundColor, alpha: 1.0))
            SVProgressHUD.setForegroundColor(self.colorWithHexStringAndAlpha(UIConstant.ProgressHUD.forgroundColor, alpha: 1.0))
            SVProgressHUD.setDefaultStyle(.custom)
            SVProgressHUD.setDefaultMaskType(.black)
            SVProgressHUD.show()
        }
        else {
            SVProgressHUD.dismiss()
        }
    }
    
    
    // MARK: UIColor Modification methods
    
    
    func colorWithHexStringAndAlpha(_ hexString: String, alpha:CGFloat) -> UIColor {
        
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha
        
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    func intFromHexString(_ hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
}
