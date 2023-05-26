//
//  UIImageView+Ext.swift
//  GamesExplorer
//
//  Created by Ahmed Fitoh on 26/05/2023.
//

import UIKit

extension UIImageView {
    /// Load image contained in reusable cells
    func loadImageUsingCache(withUrl stringUrl: String?,
                             cellIndexPathRow: Int,
                             placeHolderImage: UIImage? = nil) {
        self.image = placeHolderImage
        guard let stringUrl = stringUrl,
        let url = URL(string: stringUrl) else { return }
        self.tag = cellIndexPathRow

        // check cached image is already fetched
        if let imageUrl = ImageCacheManager.shared.isImageAvailable(forUrl: url){
            ImageCacheManager.shared.loadImage(withUrl: imageUrl, to: self)
            return
        }

        NetworkManager.shared.downloadImage(from: url) {[weak self] imageData in
            DispatchQueue.main.async {
                guard let imageData = imageData,
                      let image = UIImage(data: imageData),
                      self?.tag == cellIndexPathRow else {return}
                ImageCacheManager.shared.save(image: imageData, withUrl: url)
                self?.image = image
            }
        }
    }

    func loadImageUsingCache(withUrl stringUrl: String?,
                             placeHolderImage: UIImage? = nil) {
        self.image = placeHolderImage

        guard let stringUrl = stringUrl,
        let url = URL(string: stringUrl) else { return }

            // check cached image is already fetched
            if let imageUrl = ImageCacheManager.shared.isImageAvailable(forUrl: url){
                ImageCacheManager.shared.loadImage(withUrl: imageUrl, to: self)
                return
            }

        // if not, download image from url
        NetworkManager.shared.downloadImage(from: url) {[weak self] imageData in
            DispatchQueue.main.async {
                guard let imageData = imageData,
                      let image = UIImage(data: imageData) else {return}
                ImageCacheManager.shared.save(image: imageData, withUrl: url)
                self?.image = image
            }
        }
    }
}
