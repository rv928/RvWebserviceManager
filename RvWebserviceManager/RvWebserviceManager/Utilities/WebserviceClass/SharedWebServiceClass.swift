//
//  SharedWebServiceClass.swift
//  RvWebserviceManager
//
//  Created by Ravi Vora on 18/03/16.
//  Copyright © 2016 Ravi Vora. All rights reserved.
//

import UIKit

class SharedWebServiceClass {
    
    static let sharedInstance : SharedWebServiceClass = {
        let instance = SharedWebServiceClass()
        return instance
    }()
    
    
    func PostWeb_Service_Body(_ url:String,authToken:String,httpMethod:String,parameters:[String:AnyObject],completionHandler: @escaping (Data?,URLResponse?,Error?) -> Void) {
        
        let defaultConfigObject: URLSessionConfiguration = URLSessionConfiguration.default
        let delegateFreeSession: URLSession = URLSession(configuration: defaultConfigObject)
        let url: URL = URL(string: "\(url)")!
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.addValue(AppConstants.requestConstants.kAcceptType, forHTTPHeaderField: AppConstants.requestConstants.kContentType)
        
        urlRequest.addValue(AppConstants.requestConstants.kAcceptType, forHTTPHeaderField: AppConstants.requestConstants.kAccept)
        if authToken.characters.count>0 {
            urlRequest.addValue(authToken, forHTTPHeaderField: AppConstants.requestConstants.kauthorization)
        }
        urlRequest.httpMethod = httpMethod
        var jsonData: Data?
         do {
            try jsonData = JSONSerialization .data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
           
         } catch {
            print("error: \(error)")
        }
        var jsonString: String
        jsonString = String(data: jsonData!, encoding: String.Encoding.utf8)!
        print("======================================================================")
        print("url\n \(url)")
        print("======================================================================")
        print("jsonString\n \(jsonString)")
        print("======================================================================")
        urlRequest.httpBody = jsonString.data(using: String.Encoding.utf8)
        
        var dataTask: URLSessionDataTask
        dataTask = delegateFreeSession.dataTask(with: urlRequest, completionHandler: {(data : Data?, response : URLResponse?, error :Error?) in
            
            completionHandler(data,response,error)
            
        });
        dataTask.resume()
    }
    
    func PostWeb_Service(_ url:String,authToken:String,httpMethod:String,parameters:[String:AnyObject],completionHandler: @escaping (Data?,URLResponse?,Error?) -> Void) {
        
        let defaultConfigObject: URLSessionConfiguration = URLSessionConfiguration.default
        let delegateFreeSession: URLSession = URLSession(configuration: defaultConfigObject)
        let url: URL = URL(string: "\(url)")!
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.addValue(AppConstants.requestConstants.kApplicationHeader, forHTTPHeaderField: AppConstants.requestConstants.kContentType)
        urlRequest.setValue(authToken, forHTTPHeaderField:AppConstants.requestConstants.kAuthToken)
        if authToken.characters.count>0 {
            urlRequest.addValue(authToken, forHTTPHeaderField: AppConstants.requestConstants.kauthorization)
        }


        urlRequest.httpMethod = httpMethod
        var jsonData: Data
        jsonData = "\(url)&\(parameters.stringFromHttpParameters())".data(using: String.Encoding.ascii)!
        var jsonString: String
        jsonString = String(data: jsonData, encoding: String.Encoding.utf8)!
        urlRequest.httpBody = jsonString.data(using: String.Encoding.utf8)
        var dataTask: URLSessionDataTask
        dataTask = delegateFreeSession.dataTask(with: urlRequest, completionHandler: {(data : Data?, response : URLResponse?, error : Error?) in
            
            completionHandler(data,response,error)
            
        } );
        dataTask.resume()
    }
    
     func GetWeb_Service(_ url:String,authToken:String,httpMethod:String,completionHandler: @escaping (Data?,URLResponse?,Error?) -> Void) {
        
        let defaultConfigObject: URLSessionConfiguration = URLSessionConfiguration.default
        let delegateFreeSession: URLSession = URLSession(configuration: defaultConfigObject)
        let url: URL = URL(string: "\(url)")!
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.addValue(AppConstants.requestConstants.kApplicationHeader, forHTTPHeaderField: AppConstants.requestConstants.kContentType)
        if authToken.characters.count>0 {
            urlRequest.addValue(authToken, forHTTPHeaderField: AppConstants.requestConstants.kauthorization)
        }

        urlRequest.httpMethod = httpMethod
        var dataTask: URLSessionDataTask
        dataTask = delegateFreeSession.dataTask(with: urlRequest, completionHandler: {(data : Data?, response : URLResponse?, error : Error?) in
            
            completionHandler(data,response,error)
            
        } );
        dataTask.resume()
    }
    
    func downloadImage(_ url:String,defaultImageName:String,completion: @escaping (UIImage?) -> Void )
    {
        var image = UIImage.init(named:defaultImageName)
        
        if url.characters.count > 0
        {
            let urlStr = URL.init(string: url)
            let session = URLSession.shared
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let documentsDirectoryURL = URL(fileURLWithPath: documentsPath)
            
            let filename = documentsDirectoryURL.appendingPathComponent((urlStr?.lastPathComponent)!).path
            print(filename)
            print("File Not exits")
            
            if let url = URL(string: url) {
                // Create Request
                let request = URLRequest(url: url)
                
                // Create Data Task
                let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                    
                    if let data = data, let img = UIImage(data: data)
                    {
                        
                        if (error == nil  && data.count == 0)
                        {
                            image = UIImage.init(named:defaultImageName)
                            completion(image!)
                        }
                        else
                        {
                            completion(img)
                        }
                        
                    }
                    else
                    {
                        completion(image)
                    }
                    
                })
                
                dataTask.resume()
            }
        }
        else
        {
            completion(image!)
        }
    }
    func downloadZip(_ url:String,completion: @escaping (String?) -> Void )
    {
        var path = ""
        
        if url.characters.count > 0
        {
            let urlStr = URL.init(string: url)
            let session = URLSession.shared
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let documentsDirectoryURL = URL(fileURLWithPath: documentsPath)
            
            let filename = documentsDirectoryURL.appendingPathComponent((urlStr?.lastPathComponent)!).path
            print(filename)
            
            if FileManager.default.fileExists(atPath: filename) == true
            {
                print("File exits")
                completion(path)
            }
            else
            {
                print("File Not exits")
                
                if let url = URL(string: url) {
                    // Create Request
                    let request = URLRequest(url: url)
                    
                    // Create Data Task
                    let dataTask = session.downloadTask(with: request, completionHandler: { (location, response, error) -> Void in
                        
                        let documentURL = documentsDirectoryURL.appendingPathComponent((response?.suggestedFilename!)!)
                        do {
                            try FileManager.default.moveItem(at: location!, to: documentURL)
                            path = documentURL.path
                            completion(path)
                        }
                        catch{}
                        
                    })
                    
                    dataTask.resume()
                }
                
            }
        }
        else
        {
            completion(path)
        }
    }
}

