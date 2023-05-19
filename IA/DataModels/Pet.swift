//
//  Pet.swift
//  IA
//
//  Created by Snigdha Tiwari  on 15/05/23.
//

import Foundation
import RealmSwift

class Pet: Object {
    @objc dynamic var petName: String = ""
    @objc dynamic var microchip: String = ""
    @objc dynamic var dateCreated: Date? = Date()

}
