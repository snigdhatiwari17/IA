//
//  PetDetails.swift
//  IA
//
//  Created by Snigdha Tiwari  on 16/05/23.
//

import Foundation
import RealmSwift

class PetDetails: Object {
    @objc dynamic var width: Double = 0.0
    @objc dynamic var height: Double = 0.0
    @objc dynamic var age: Int = 0
    @objc dynamic var weight: Double = 0.0
    @objc dynamic var medicalHistory: String = ""
    @objc dynamic var dateCreated: Date? = Date()

}
