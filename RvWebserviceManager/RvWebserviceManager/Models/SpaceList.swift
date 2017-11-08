//
//  SpaceList.swift
//  RvWebserviceManager
//
//  Created by Ravi Vora on 12/09/16.
//  Copyright © 2016 Ravi Vora. All rights reserved.
//

import UIKit


class SpaceList {
    
    var spaceList = [Space]()
    
    init(array: Array<AnyObject>) {
        
        for (_, value) in array.enumerated() {
            
            let itemDictionary = value as! Dictionary<String,AnyObject>
            let objSpace = Space(dictionary: itemDictionary)
            spaceList.append(objSpace)
        }
    }
    
    deinit {
        spaceList.removeAll()
    }
}

