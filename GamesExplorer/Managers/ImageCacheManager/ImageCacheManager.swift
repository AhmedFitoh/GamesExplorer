//
//  ImageCacheManager.swift
//  GamesExplorer
//
//  Created by AhmedFitoh on 26/5/2023.
//

import UIKit

final class ImageCacheManager {
    static let shared = ImageCacheManager()
    
// MARK: Public funcs
    
    func loadImage(withUrl url: URL, to imageView: UIImageView){
        DispatchQueue.main.async {
            imageView.image = UIImage(contentsOfFile: url.path)
        }
    }

    func save(image: Data, withUrl url: URL){
        DispatchQueue.global(qos: .background).async {
            guard let fileUrl = self.createUrl(fileName: url.path) else {
                return
            }
            do {
                try image.write(to: fileUrl, options: .withoutOverwriting)
            } catch{
                print(error)
            }
        }
    }

    func save(image: UIImage, withUrl url: URL){
        DispatchQueue.global(qos: .background).async {
            guard let fileUrl = self.isImageAvailable(forUrl: url) else {
                // Image already saved
                return
            }
            var imageData: Data?
            if url.path.lowercased().hasSuffix("jpg") {
                imageData = image.jpegData(compressionQuality: 1)
            } else if url.path.lowercased().hasSuffix("png"){
                imageData = image.pngData()
            }
            
            do {
                try imageData?.write(to: fileUrl)
            } catch{
                print(error)
            }
        }
        
    }

    func isImageAvailable(forUrl fileName: URL) -> URL? {
        guard let url = createUrl(fileName: fileName.path) else {
            return nil
        }
        if FileManager.default.fileExists(atPath: url.path){
            return url
        }
        return nil
    }

// MARK: Private funcs
    
    private func createUrl(fileName: String) -> URL? {
        guard let documentURL = FileManager.default.urls(for: .documentDirectory,
                                                         in: .userDomainMask).first else {
            print("Can't get document URL")
            return nil }
        
        if let fileEncodedName = fileName.addingPercentEncoding(withAllowedCharacters: .urlUserAllowed){
            return documentURL.appendingPathComponent(fileEncodedName)
        }
        return nil
    }
}
