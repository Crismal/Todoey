//
//  Category.swift
//  Todoey
//
//  Created by Cristian Misael Almendro Lazarte on 8/4/19.
//  Copyright © 2019 Cristian Misael Almendro Lazarte. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = "" 
    let items = List<Item>()
}
