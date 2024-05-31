//
//  Entity+CoreDataProperties.swift
//  
//
//  Created by ladmin on 15/05/2024.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }


}
