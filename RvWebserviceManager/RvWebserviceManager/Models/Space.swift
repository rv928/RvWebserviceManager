//
//  Spaces.swift
//  RvWebserviceManager
//
//  Created by Ravi Vora on 09/09/16.
//  Copyright © 2016 Ravi Vora. All rights reserved.
//

import UIKit

class Space {
    
    var spaceID: String!
    var spaceName: String!
    var floorID: String!
    var spaceCapacity: Int!
    var spaceTypeID: String!
    var spaceSize: String!
    var isBookable: Int!
    var isPrivate: Int!
    var spaceNotes: String!
    var spaceImage: String!
    var spaceAvailable: Int!
    var isMaintenance: Int!
    var buildingName: String!
    var floorName: String!

    var status: Int!
    var created: String!
    var updated: String!
    var deleted: String!

    

    
    init(dictionary: Dictionary<String,AnyObject>) {
        
        if dictionary.isEmpty == false {
            
            spaceID = dictionary[ObjectConstant.SpaceKeys.keyspaceID.toKey()] as! String
            spaceName = dictionary[ObjectConstant.SpaceKeys.keyspaceName.toKey()] as? String
            floorID = dictionary[ObjectConstant.SpaceKeys.keyfloorID.toKey()] as! String
            spaceCapacity = (Int)(dictionary[ObjectConstant.SpaceKeys.keyspaceCapacity.toKey()] as! Int)
            spaceTypeID = dictionary[ObjectConstant.SpaceKeys.keyspaceID.toKey()] as! String
            spaceSize = dictionary[ObjectConstant.SpaceKeys.keyspaceSize.toKey()] as! String
            
            if (dictionary[ObjectConstant.SpaceKeys.keyisBookable.toKey()] != nil) {
                
                if (dictionary[ObjectConstant.SpaceKeys.keyisBookable.toKey()] is NSNull) {
                    isBookable = 0
                }
                else {
                    isBookable = (Int)(dictionary[ObjectConstant.SpaceKeys.keyisBookable.toKey()] as! Int)
                }
            }
            
            if (dictionary[ObjectConstant.SpaceKeys.keyisPrivate.toKey()] != nil) {
                
                if (dictionary[ObjectConstant.SpaceKeys.keyisBookable.toKey()] is NSNull) {
                    isPrivate = 0
                }
                else {
                    isPrivate = (Int)(dictionary[ObjectConstant.SpaceKeys.keyisPrivate.toKey()] as! Int)
                }
            }
            
            
            if (dictionary[ObjectConstant.SpaceKeys.keyspaceNotes.toKey()] is NSNull) {
                spaceNotes = ""
            }
            else {
                spaceNotes = dictionary[ObjectConstant.SpaceKeys.keyspaceNotes.toKey()] as! String
            }
            
            if (dictionary[ObjectConstant.SpaceKeys.keyspaceImage.toKey()] is NSNull) {
                spaceImage = ""
            }
            else {
                spaceImage = dictionary[ObjectConstant.SpaceKeys.keyspaceImage.toKey()] as! String
            }
            
            
            if (dictionary[ObjectConstant.SpaceKeys.keyspaceAvailable.toKey()] is NSNull) {
                spaceAvailable = 0
            }
            else {
                spaceAvailable = (Int)(dictionary[ObjectConstant.SpaceKeys.keyspaceAvailable.toKey()] as! Int)
            }
            
            
            
            if (dictionary[ObjectConstant.SpaceKeys.keyisMaintenance.toKey()] != nil) {
                
                if (dictionary[ObjectConstant.SpaceKeys.keyisMaintenance.toKey()] is NSNull) {
                    isMaintenance = 0
                }
                else {
                    isMaintenance = (Int)(dictionary[ObjectConstant.SpaceKeys.keyisMaintenance.toKey()] as! Int)
                }
            }
            
            
            if (dictionary[ObjectConstant.SpaceKeys.keybuildingName.toKey()] is NSNull) {
                buildingName = ""
            }
            else {
                buildingName = dictionary[ObjectConstant.SpaceKeys.keybuildingName.toKey()] as! String
            }
            
            
            if (dictionary[ObjectConstant.SpaceKeys.keyfloorName.toKey()] is NSNull) {
                floorName = ""
            }
            else {
                floorName = dictionary[ObjectConstant.SpaceKeys.keyfloorName.toKey()] as! String
            }
            
            status = (Int)(dictionary[ObjectConstant.SpaceKeys.keystatus.toKey()] as! Int)
            
            created = dictionary[ObjectConstant.SpaceKeys.keycreated.toKey()] as! String
            
            if (dictionary[ObjectConstant.SpaceKeys.keyupdated.toKey()] is NSNull) {
                updated = ""
            }
            else {
                updated = dictionary[ObjectConstant.SpaceKeys.keyupdated.toKey()] as! String
            }
            
            if (dictionary[ObjectConstant.SpaceKeys.keydeleted.toKey()] is NSNull) {
                deleted = ""
            }
            else {
                deleted = dictionary[ObjectConstant.SpaceKeys.keydeleted.toKey()] as! String
            }
       
        }
        
    }
    
    
    deinit {
        
    }
    
  }
