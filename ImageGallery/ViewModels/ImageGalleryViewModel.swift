//
//  ImageGalleryViewModel.swift
//  ImageGallery
//
//  Created by Shubham Choudhary on 24/09/17.
//  Copyright © 2017 Shubham Choudhary. All rights reserved.
//

import UIKit

class ImageGalleryViewModel: NSObject {
    
    //Type Properties
    var publicFeed : FeedJSON? = nil
    
    // Get Images
    func getImages(offset: Int, limit: Int, completion: @escaping (_ success: Bool, _ error: String?) -> ()) {
        ServiceLayerManager.getImages(offset: offset, limit: limit) { [weak self] (feed, error) in
            guard let strongSelf = self else { return }
            if let feed = feed {
                if offset > 0 {
                    strongSelf.appendImages(feed)
                }else {
                    strongSelf.publicFeed = feed
                }
                completion(true, nil)
            }else {
                guard let error = error else {return}
                completion(false, error)
            }
        }
    }
    
    func appendImages(_ feed: FeedJSON) {
        publicFeed?.data?.has_more = feed.data?.has_more
        if let oldUsers = publicFeed?.data?.users, let newUsers = feed.data?.users {
            publicFeed?.data?.users = oldUsers + newUsers
        }
    }
    
    // MARK: - Values to display in CollectionView
    func numberOfSections() -> Int {
        return publicFeed?.data?.users?.count ?? 0
    }
    
    func numberOfItems(in section: Int) -> Int {
        return publicFeed?.data?.users?[section].items?.count ?? 0
    }
    
    func imageUrl(for indexPath: IndexPath) -> String? {
        return publicFeed?.data?.users?[indexPath.section].items?[indexPath.row]
    }
    
    func userImageUrl(for indexPath: IndexPath) -> String? {
        return publicFeed?.data?.users?[indexPath.section].image
    }
    
    func userName(for indexPath: IndexPath) -> String? {
        return publicFeed?.data?.users?[indexPath.section].name
    }
    
    func itemSize(_ collectionView: UICollectionView, for indexPath: IndexPath) -> CGSize {
        if numberOfItems(in: indexPath.section) % 2 == 1 && indexPath.row == 0 {
            return CGSize(width: collectionView.frame.size.width - 40, height: collectionView.frame.size.width - 40)
        }else {
            return CGSize(width: (collectionView.frame.size.width - 60)/2, height: (collectionView.frame.size.width - 60)/2)
        }
    }
    
    func hasMore() -> Bool {
        return publicFeed?.data?.has_more ?? false
    }
    
}
