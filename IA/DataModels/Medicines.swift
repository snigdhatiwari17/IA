//
//  Medicines.swift
//  IA
//
//  Created by Snigdha Tiwari  on 16/05/23.
//


import Foundation
import RealmSwift

class Medicines: Object {
    @objc dynamic var medicineName: String?
    @objc dynamic var petSpecies: String?
    @objc dynamic var commonName: String?
    @objc dynamic var dateCreated: Date? = Date()
    
}
