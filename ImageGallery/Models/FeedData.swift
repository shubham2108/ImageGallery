//
//  FeedData.swift
//  ImageGallery
//
//  Created by Shubham Choudhary on 24/09/17.
//  Copyright © 2017 Shubham Choudhary. All rights reserved.
//

import Foundation
import ObjectMapper

class FeedData: Mappable {
    
    
    var has_more: Bool?
    var users: [FeedUser]?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        self.has_more <- map["has_more"]
        self.users <- map["users"]
    }
    
}
