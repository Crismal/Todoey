//
//  Item.swift
//  Todoey
//
//  Created by Cristian Misael Almendro Lazarte on 8/4/19.
//  Copyright © 2019 Cristian Misael Almendro Lazarte. All rights reserved.
//


import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date = Date()
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
