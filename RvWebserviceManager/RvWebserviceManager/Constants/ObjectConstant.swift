//
//  ObjectConstant.swift
//  RvWebserviceManager
//
//  Created by Ravi Vora on 17/08/16.
//  Copyright © 2016 Ravi Vora. All rights reserved.
//

import Foundation


class ObjectConstant {
    
    
    // MARK: SpaceKeys
    
    enum SpaceKeys :Int {
        case keyspaceID,keyspaceName,keyfloorID,keyspaceCapacity,keyspaceTypeID,keyspaceSize,keyisBookable,keyisPrivate,keyspaceNotes,keyspaceImage,keyspaceAvailable,keyisMaintenance,keybuildingName,keyfloorName,keystatus,keycreated,keyupdated,keydeleted;
        func toKey() -> String! {
            switch self {
            case .keyspaceID:
                return "space_id"
            case .keyspaceName:
                return "space_name"
            case .keyfloorID:
                return "floor_id"
            case .keyspaceCapacity:
                return "space_capacity"
            case .keyspaceTypeID:
                return "space_type_id"
            case .keyspaceSize:
                return "space_size"
            case .keyisBookable:
                return "space_bookable"
            case .keyisPrivate:
                return "space_is_private"
            case .keyspaceNotes:
                return "space_notes"
            case .keyspaceImage:
                return "space_image"
            case .keyspaceAvailable:
                return "space_availability"
            case .keyisMaintenance:
                return "is_maintenance"
            case .keybuildingName:
                return "building_name"
            case .keyfloorName:
                return "floor_name"
            case .keystatus:
                return "status"
            case .keycreated:
                return "created_at"
            case .keyupdated:
                return "updated_at"
            case .keydeleted:
                return "deleted_at"
            }
        }
    }
}
