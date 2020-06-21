//
//  ImageDownloaderManager.swift
//  TelstraiOSExercise
//
//  Created by Digvijay.digvijay on 6/21/20.
//  Copyright © 2020 Digvijay.digvijay. All rights reserved.
//

import Foundation
import UIKit
// MARK: -   TELSTRA IMAGE DOWNLOAD MANAGER
/// Used to Download image from given url and save the image in cache for further use
class ImageDownloaderManager {
    
    //MARK: -  IMAGE DOWNLOADER VARRIBALE DECLARATION
    var task : URLSessionDataTask? = URLSessionDataTask()
    var session : URLSession? = URLSession.shared
    var cache : NSCache<NSString, UIImage>? = NSCache()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
       /*
        @description: - Fetch image data with path
        @parameter:- path: String
        completionHandler: taking parameter Data
        @return: -      Void
        */
    
    func getImageFor(path: String, completion: @escaping ((Data?) -> ())) {
        guard let url = URL(string: path) else {completion(nil);return}
        task = session?.dataTask(with: url, completionHandler: { (data, response, error) in
            if error == nil {
                completion(data)
            }
        })
        task?.resume()
    }
    
    
    /*
    @description: - Checks if the image is in cache or else download
    @parameter:- path: String
    completionHandler: taking parameter Data
    @return: -      Void
    */
    func checkImage(path: String, completion: @escaping ((UIImage?) -> ())) {
        if let image = self.cache?.object(forKey: path as NSString) {
            DispatchQueue.main.async {
                completion(image)
            }
        } else {
            getImageFor(path: path, completion: { (data) in
                guard let imageData = data else {completion(nil);return}
                guard let image = UIImage(data: imageData) else {completion(nil);return}
                self.cache?.setObject(image, forKey: path as NSString)
                DispatchQueue.main.async {
                    completion(image)
                }
            })
            
        }
    }
}
