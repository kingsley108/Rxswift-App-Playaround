//
//  PhotoCollection.swift
//  RXSwiftPhotoApp
//
//  Created by Kingsley Charles on 18/03/2021.
//

import UIKit
import Photos
import RxSwift

private let reuseIdentifier = "Cell"

class PhotoCollection: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var latestPhotoAssetsFetched: PHFetchResult<PHAsset>? = nil
    let selectedPhotoSubject = PublishSubject<UIImage>()
    var selectedPhoto: Observable<UIImage> {
        return selectedPhotoSubject.asObservable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        self.collectionView!.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.latestPhotoAssetsFetched = self.fetchLatestPhotos(forCount: 6)
        self.collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
    }
    
    //Implementation of photos
    func fetchLatestPhotos(forCount count: Int?) -> PHFetchResult<PHAsset> {
        
        // Create fetch options.
        let options = PHFetchOptions()
        
        // If count limit is specified.
        if let count = count { options.fetchLimit = count }
        
        // Add sortDescriptor so the lastest photos will be returned.
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        options.sortDescriptors = [sortDescriptor]
        
        // Fetch the photos.
        return PHAsset.fetchAssets(with: .image, options: options)
        
    }
    
    
    //Implementation of collectionView
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = view.frame.width
        return CGSize(width: screenWidth/4, height: screenWidth/4)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionCell
        guard let asset = self.latestPhotoAssetsFetched?[indexPath.item] else {
            return cell
        }
        // Here we bind the asset with the cell.\
        // Request the image.
        PHImageManager.default().requestImage(for: asset,
                                              targetSize: cell.frame.size,
                                              contentMode: .aspectFill,
                                              options: nil) { (image, _) in
            // By the time the image is returned, the cell may has been recycled.
            // We update the UI only when it is still on the screen.
            guard let image = image else {return}
            cell.imageCotainer.image = image
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let asset = self.latestPhotoAssetsFetched?[indexPath.item] else {return}
        PHImageManager.default().requestImage(for: asset,
                                              targetSize: view.frame.size,
                                              contentMode: .aspectFill,
                                              options: nil) { (image, _) in
            guard let image = image else {return}
            self.selectedPhotoSubject.onNext(image)
            self.dismiss(animated: true, completion: nil)
        }
        
    }

}
