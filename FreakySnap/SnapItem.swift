//
//  SnapItem.swift
//  FreakySnap
//
//  Created by Alexander Kotik on 10.08.17.
//  Copyright © 2017 Alexander Kotik. All rights reserved.
//

import Foundation
class SnapItem {
    var imageUrl = ""
    var imageName = ""
    var message = ""
    var from = ""
    var key = ""
    
    init(url :String, name : String, message : String, from :String) {
        imageUrl = url
        imageName = name
        self.message = message
        self.from = from
    }
    
    init() {
        
    }
}
