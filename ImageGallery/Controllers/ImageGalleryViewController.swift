//
//  ImageGalleryViewController.swift
//  ImageGallery
//
//  Created by Shubham Choudhary on 24/09/17.
//  Copyright © 2017 Shubham Choudhary. All rights reserved.
//

import UIKit

class ImageGalleryViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet var galleryViewModel: ImageGalleryViewModel!
    
    // MARK: - Properties
    
    // Constant Properties
    let reuseIdentifier = "feedCell"
    let cellNibName = "ImageCollectionViewCell"
    let headerReuseIdentifier = "headerView"
    let headerNibName = "HeaderReusableView"
    
    let pageSize = 10
    let preloadMargin = 5
    var startPage = 0
    
    //Collection View Layout
    let edgeInsets = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
    let headerHeight: CGFloat = 80.0
    let minimumLineSpacing: CGFloat = 20.0
    let minimumInteritemSpacing: CGFloat = 20.0
    
    
    // Variable Properties
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFeeds(offset: startPage, limit: pageSize)
    }
    
    // Initialize the view of the controller
    func initializeViewController() {
        registerCollectionViewCell()
    }
    
    // Register custom cell with CollectionView
    fileprivate func registerCollectionViewCell() {
        let cellNib = UINib(nibName: cellNibName, bundle:nil)
        let headerNib = UINib(nibName: headerNibName, bundle: nil)
        imageCollectionView.register(cellNib, forCellWithReuseIdentifier: reuseIdentifier)
        imageCollectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
    }
    
    // Get public feed from Flicker
    func getFeeds(offset: Int, limit: Int) {
        galleryViewModel?.getImages(offset: offset, limit: limit, completion: { [weak self] (success, error) in
            guard let strongSelf = self else { return }
            strongSelf.isLoading = false
            if success {
                strongSelf.imageCollectionView.reloadData()
            }else {
                guard let error = error else {return}
                strongSelf.showAlert(title: ERROR, message: error, completionHandler: { action in
                    strongSelf.handleAlertActions(actoin: action)
                })
            }
        })
    }
    
    func loadMoreFeeds(_ indexPath: IndexPath) {
        if galleryViewModel.hasMore() && !isLoading {
            let numberOfSection = galleryViewModel.numberOfSections()
            let currentSeciton = indexPath.section
            if currentSeciton > numberOfSection - preloadMargin {
                isLoading = true
                getFeeds(offset: numberOfSection, limit: pageSize)
            }
            
        }
    }
    
    //Handle alert actions
    func handleAlertActions(actoin: UIAlertAction) {
        switch actoin.style {
        case .default:
            getFeeds(offset: startPage, limit: pageSize)
        default:
            navigationController?.popViewController(animated: true)
        }
    }
}
