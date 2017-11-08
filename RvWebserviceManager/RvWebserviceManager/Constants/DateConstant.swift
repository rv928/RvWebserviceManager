//
//  DateConstant.swift
//  RvWebserviceManager
//
//  Created by Ravi Vora on 30/03/17.
//  Copyright © 2017 Ravi Vora. All rights reserved.
//

import Foundation



class DateConstant  {
    
    
    struct configuration
    {
        static let roundUpDuration = 30
        static let defaultDuration = "15 Mins"
        static let dayInterval = "21 days"
    }
    
    struct dateformatters
    {
        static let mediumDateStyle = "MMMM dd, yyyy"  //Display date style using this formater
        static let shortTimeStyle = "hh:mm a"
        static let utcDateFormater = "yyyy-MM-dd HH:mm:ss"
        static let mergeDateTimeFormat = "MMMM dd,yyyy hh:mm a"
        static let utcDateOnlyFormater = "yyyy-MM-dd"
        static let monthOnlyFormatter = "MM/dd/yyyy"
    }
}
