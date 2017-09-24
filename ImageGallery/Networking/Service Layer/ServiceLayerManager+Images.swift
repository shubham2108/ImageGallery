//
//  ServiceLayerManager+Images.swift
//  ImageGallery
//
//  Created by Shubham Choudhary on 24/09/17.
//  Copyright © 2017 Shubham Choudhary. All rights reserved.
//

import Foundation
import ObjectMapper

extension ServiceLayerManager {
    
    // Get Images
    class func getImages(offset: Int, limit: Int, completionHandler: @escaping (_ feed: FeedJSON?, _ error: String?) -> ()) {
        let url = BASE_URL + "api/users?offset=\(offset)&limit=\(limit)"
        request(url) { (resultValue, errorString) in
            if let resultValue = resultValue {
                print(resultValue)
                let feed = Mapper<FeedJSON>().map(JSONObject: resultValue)
                completionHandler(feed, nil)
            }else {
                completionHandler(nil, errorString)
            }
        }
    }
}
