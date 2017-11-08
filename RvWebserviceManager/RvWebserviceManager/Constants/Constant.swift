//
//  Constant.swift
//  RvWebserviceManager
//
//  Created by Ravi Vora on 18/03/16.
//  Copyright © 2016 Ravi Vora. All rights reserved.
//

import Foundation
import UIKit



class AppConstants  {
    
    static let APP_NAME = "RvWebserviceManager"
    static let deviceTypeValue = "ios"

    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    enum UIUserInterfaceIdiom : Int {
        case unspecified
        case phone
        case pad
    }
    
    struct ScreenSize {
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    struct DeviceType {
        static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 480.0
        static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    }

    
    struct globalFunctions {
        static func GET_IMAGE(_ imageName:String) -> UIImage
        {
            let imageN: UIImage = UIImage(named: imageName)!
            return imageN
        }
    }
    
    
    struct webserviceConstants {
        
        //developement URL

        static let kBaseURL = "http://192.168.4.41:3065/"
        static let serverURL = "http://192.168.4.41:3065"

        static let primaryTokenExt = "Basic"
        static let secondaryTokenExt = "Bearer"
        
        static let DEVICE_TYPE = "IOS"
        
        static let API_GETTOKEN = "gettoken"
        static let API_LOGIN = "signin"
        static let API_GETDEVICES = "api/site/userdevicegroups"
        static let API_ADD_DEVICE = "api/site/thing"
        static let API_PROFILE = "api/site/getProfile"
        static let API_REFRESH_TOKEN = "refresh_token"
    }
    
   
    struct requestConstants {
        static let kApplicationHeader        =  "application/x-www-form-urlencoded"
        static let kAuthToken                =  "authorization"
        static let kContentType              =  "Content-Type"
        static let kJSONContent              =  "application/json; charset=UTF-8"
        static let kAccept                   =  "Accept"
        static let kAcceptType               =  "application/json"
        static let kContentLength            =  "Content-Length"
        static let kGET                      =  "GET"
        static let kPOST                     =  "POST"
        static let kauthorization            =  "Authorization"
    }

}

