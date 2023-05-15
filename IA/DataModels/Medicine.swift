//
//  Medicine.swift
//  IA
//
//  Created by Snigdha Tiwari  on 15/05/23.
//

import Foundation
import RealmSwift

class Medicine: Object {
    @objc dynamic var brandName: String = ""
    @objc dynamic var dose: String = ""
    @objc dynamic var sideEffects: String = ""
    @objc dynamic var dateCreated: Date? = Date()
    
}


