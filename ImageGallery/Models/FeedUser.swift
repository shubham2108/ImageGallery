//
//  FeedUser.swift
//  ImageGallery
//
//  Created by Shubham Choudhary on 24/09/17.
//  Copyright © 2017 Shubham Choudhary. All rights reserved.
//

import Foundation
import ObjectMapper

class FeedUser: Mappable {
    
    var name: String?
    var image: String?
    var items: [String]?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        self.name <- map["name"]
        self.image <- map["image"]
        self.items <- map["items"]
    }
    
}
