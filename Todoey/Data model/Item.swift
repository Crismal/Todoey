//
//  Item.swift
//  Todoey
//
//  Created by Cristian Misael Almendro Lazarte on 6/23/19.
//  Copyright © 2019 Cristian Misael Almendro Lazarte. All rights reserved.
//

import Foundation


class Item : Encodable, Decodable {
    
    var item : String = ""
    var selected : Bool = false
}
