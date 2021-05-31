//
//  ViewController.swift
import RxSwift
import UIKit

class CameraViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    var photoImage : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        img.clipsToBounds = true
        img.isHidden = true
        return img
    }()
    
    fileprivate func seUpNavigationBar() {
        navigationItem.title = "Camera Filter"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapped))
    }
    
    
        
    
    
    fileprivate func setUpView() {
        view.addSubview(photoImage)
        photoImage.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seUpNavigationBar()
        setUpView()
    }
        @objc fileprivate func tapped() {
            
            let flowLayout = UICollectionViewFlowLayout()
            let photoAlbumCollection = PhotoCollection(collectionViewLayout: flowLayout)
            photoAlbumCollection.modalPresentationStyle = .fullScreen
            photoAlbumCollection.selectedPhoto.subscribe(onNext: { [weak self] image in
                    self?.photoImage.image = image
                    self?.photoImage.isHidden = false
            }).disposed(by: disposeBag)
            navigationController?.present(photoAlbumCollection, animated: true)
    }
}


