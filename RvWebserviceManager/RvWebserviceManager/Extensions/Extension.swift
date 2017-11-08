//
//  Extension.swift
//  RvWebserviceManager
//
//  Created by Ravi Vora on 24/08/16.
//  Copyright © 2016 Ravi Vora. All rights reserved.
//

import Foundation
import UIKit



extension String {
    
    func stringByAddingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
    
    func replace(_ string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhitespace() -> String {
        return self.replace(" ", replacement: "")
    }
    
    func checkNil() -> String {
        if self.isEmpty == true {
            return ""
        }else {
            return self
        }
    }
    
    mutating func addPrefix(_ prefix:String) -> String {
        let tmpNumber = (Int)(self)
        if tmpNumber!<10 {
            self = prefix+self
            return self
        }
        else {
            return self
        }
    }
    
    func toDateTime(_ format:String) -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let dateFromString : Date = dateFormatter.date(from: self)!
        return dateFromString
    }
    
}


// MARK: Dictionary to String Encoding


extension Dictionary {
    
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).stringByAddingPercentEncodingForURLQueryValue()!
            let percentEscapedValue = (value as! String).stringByAddingPercentEncodingForURLQueryValue()!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        
        return parameterArray.joined(separator: "&")
    }
    
}

extension UITextField {
    class func connectFields(_ fields:[UITextField]) -> Void {
        guard let last = fields.last else {
            return
        }
        for i in 0 ..< fields.count - 1 {
            fields[i].returnKeyType = .next
            fields[i].addTarget(fields[i+1], action: #selector(UIResponder.becomeFirstResponder), for: .editingDidEndOnExit)
        }
        last.returnKeyType = .done
        last.addTarget(last, action: #selector(UIResponder.resignFirstResponder), for: .editingDidEndOnExit)
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
    
    func addpaddingView() -> UIView {
        
        let paddingView = UIView(frame:CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = UITextFieldViewMode.always
        return paddingView
    }
}


// MARK: Shift Objects in Array



extension Array {
    func shiftedLeft(by rawOffset: Int = 1) -> Array {
        let clampedAmount = rawOffset % count
        let offset = clampedAmount < 0 ? count + clampedAmount : clampedAmount
        return Array(self[offset ..< count] + self[0 ..< offset])
    }
    
    func shiftedRight(by rawOffset: Int = 1) -> Array {
        return self.shiftedLeft(by: -rawOffset)
    }
    
    mutating func shiftLeft(by rawOffset: Int = 1) {
        self = self.shiftedLeft(by: rawOffset)
    }
    
    mutating func shiftRight(by rawOffset: Int = 1) {
        self = self.shiftedRight(by: rawOffset)
    }
    
    func contains<T>(_ obj: T) -> Bool where T : Equatable {
        return self.filter({$0 as? T == obj}).count > 0
    }
    
   }

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        
        return result
    }
}




@objc public protocol DictionarySerializable {
    func serializeToDictionary() -> [String:AnyObject]
}

class DictionarySerializableObject: NSObject {
}

extension NSObject: DictionarySerializable {
    public func serializeToDictionary() -> [String:AnyObject] {
        let aClass: AnyClass? = type(of: self)
        var propertiesCount: CUnsignedInt = 0
        let properties = class_copyPropertyList(aClass, &propertiesCount)
        var dictionary = [String: AnyObject]()
        for i in 0 ..< Int(propertiesCount) {
            if let name = NSString(cString: property_getName(properties![i]), encoding: String.Encoding.utf8.rawValue) as String? {
                dictionary[name] = getDictionaryValueForObject(self.value(forKey: name) as AnyObject?)
            }
        }
        free(properties)
        return dictionary
    }
    
    fileprivate func getDictionaryValueForObject(_ object: AnyObject?) -> AnyObject {
        if let object: AnyObject = object {
            if let object = object as? DictionarySerializableObject {
                return object.serializeToDictionary() as AnyObject
            } else if let object = object as? [AnyObject] {
                var array = [AnyObject]()
                for item in object {
                    array.append(getDictionaryValueForObject(item))
                }
                return array as AnyObject
            } else if let object = object as? Data {
                return object.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0)) as AnyObject
            } else {
                return object
            }
        } else {
            return NSNull()
        }
    }
}

extension UIButton {
    func centerTextAndImage(_ spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
}


extension UIViewController {
    func configureChildViewController(childController: UIViewController, onView: UIView?) {
        var holderView = self.view
        if let onView = onView {
            holderView = onView
        }
        addChildViewController(childController)
        holderView?.addSubview(childController.view)
        constrainViewEqual(holderView: holderView!, view: childController.view)
        childController.didMove(toParentViewController: self)
    }
    
    
    func constrainViewEqual(holderView: UIView, view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        //pin 100 points from the top of the super
        let pinTop = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal,
                                        toItem: holderView, attribute: .top, multiplier: 1.0, constant: 0)
        let pinBottom = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal,
                                           toItem: holderView, attribute: .bottom, multiplier: 1.0, constant: 0)
        let pinLeft = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal,
                                         toItem: holderView, attribute: .left, multiplier: 1.0, constant: 0)
        let pinRight = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal,
                                          toItem: holderView, attribute: .right, multiplier: 1.0, constant: 0)
        
        holderView.addConstraints([pinTop, pinBottom, pinLeft, pinRight])
    }
}

extension NSMutableData {
    
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
    
}


extension UIImage {
    
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
}
