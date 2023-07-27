//
//  Walk.swift
//  IA
//
//  Created by Snigdha Tiwari  on 26/07/23.
//

import Foundation
import RealmSwift

class Walk: Object {
    @objc dynamic public private(set) var id = ""
    @objc dynamic public private(set) var distance = 0.0
    @objc dynamic public private(set) var duration = 0
    @objc dynamic public private(set) var date = Date()
    public private(set) var locations = List<Location>() //list(datatype) of walks locations
    
    override static func primaryKey() -> String? {
        return "id"
    }
    override static func indexedProperties() -> [String] {
        return ["date", "duration" ]
    }
    
    convenience init(distance: Double, duration: Int, locations: List<Location>) {
        self.init()
        self.id = UUID().uuidString.lowercased()
        self.date = Date()
        self.distance = distance
        self.duration = duration
        self.locations = locations
      
    }
    
    static func addWalkToRealm(distance: Double, duration: Int, locations: List<Location>) {
        REALM_QUEUE.sync {
            let walk = Walk(distance: distance, duration: duration, locations: locations)
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add( walk )
                    try realm.commitWrite()
                }
            } catch {
                debugPrint("Error adding object to realm: \(error)")
            }
        }
    }
    
    static func getAllWalks() -> Results<Walk>? { //results data type(similar to dictionary) of type run
        do {
            let realm = try Realm() 
            return realm.objects(Walk.self).sorted(byKeyPath: "date", ascending: false)
            
        } catch {
            debugPrint("Error when getting all walks from realm: \(error)")
            return nil
        }
    }
    
}

    
    
    
   
    
   

