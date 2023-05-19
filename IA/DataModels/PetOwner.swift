//
//  PetOwner.swift
//  IA
//
//  Created by Snigdha Tiwari  on 15/05/23.
//


import Foundation
import RealmSwift

class PetOwner: Object {
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var petName: String = ""
    @objc dynamic var dateCreated: Date? = Date()
    
}
