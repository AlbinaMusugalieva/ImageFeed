//
//  ImageListPresenter.swift
//  ImageFeed
//
//  Created by Albina Musugalieva on 03.05.2026.
//

import UIKit

protocol ImageListPresenterProtocol {
    var view: ImagesListViewControllerProtocol? { get set}
    var photos:[Photo]{ get}
    
    func viewDidLoad()
    func load()
    func tapLike(_ index: IndexPath, _ cell: ImagesListCell)
    
}

final class ImageListPresenter: ImageListPresenterProtocol {
    var view: ImagesListViewControllerProtocol?
    private let imagesListService = ImagesListService.shared
    private var imagesListServiceObserver: NSObjectProtocol?
    var photos:[Photo] = []
    
    func viewDidLoad() {
        imagesListServiceObserver = NotificationCenter.default.addObserver(
            forName: ImagesListService.didChangeNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            guard let self else { return }
            let oldCount = photos.count
            photos = imagesListService.photos
            let newCount = imagesListService.photos.count
            view?.updateTableViewAnimated(oldCount: oldCount, newCount: newCount)
        }
        
        load()
    }
    
    func load(){
        
        imagesListService.fetchPhotosNextPage()
    }
    
    func tapLike(_ index: IndexPath, _ cell: ImagesListCell){
        let photo = photos[index.row]
        imagesListService.changeLike(photoId: photo.id, isLike: !photo.isLiked) { result in
            switch result {
            case .success:
                self.photos = self.imagesListService.photos
                
                cell.setIsLiked(self.photos[index.row].isLiked)
                
                UIBlockingProgressHUD.dismiss()
            case .failure:
                
                UIBlockingProgressHUD.dismiss()
                self.view?.showError()
            }
        }
    }
}
