//
//  Date.swift
//  RvWebserviceManager
//
//  Created by Ravi Vora on 5/10/17.
//  Copyright © 2017 Ravi Vora. All rights reserved.


import UIKit

extension Date {
    /*
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970).rounded())
    }
    */
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }

    init?(date: String, format :String, timeZone: TimeZone? = nil) {
        let aDtFormatter = DateFormatter()
        aDtFormatter.dateFormat = format
        if let value = timeZone {
            aDtFormatter.timeZone = value
        }
        
        if let date = aDtFormatter.date(from: date) {
            self = date
        } else {
            return nil
        }
    
    }
    
    init(timestamp: TimeInterval, format :String, timeZone: TimeZone? = nil) {
        let aDtFormatter = DateFormatter()
        aDtFormatter.dateFormat = format
        if let value = timeZone {
            aDtFormatter.timeZone = value
        }
        
        self = Date(timeIntervalSince1970: timestamp)
    }
    
    func to(format :String, timeZone: TimeZone) -> String {
        let aDtFormatter = DateFormatter()
        aDtFormatter.dateFormat = format
        aDtFormatter.timeZone = timeZone
        return aDtFormatter.string(from: self)
    }
    
    func to(format :String, timeZone: TimeZone) -> Date? {
        let aDtFormatter = DateFormatter()
        aDtFormatter.dateFormat = format
        aDtFormatter.timeZone = timeZone
        return aDtFormatter.date(from: self.to(format: format, timeZone: timeZone))
    
    }
    
}
