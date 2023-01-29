//
//  UIImageView+Extensions.swift
//  TrackX
//
//  Created by Oliver Stenning on 07/06/2022.
//

import UIKit

extension UIImageView {
        func imageFromURL(_ URLString: String, placeHolder: UIImage?) {

        self.image = nil
        //If imageurl's imagename has space then this line going to work for this
        let imageServerUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        if let url = URL(string: imageServerUrl) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

                guard error == nil else {
                    print("Image loading error: \(String(describing: error))")
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                       
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
    
    func imageFromYouTubeId(id: String, placeholder: UIImage?) {
        imageFromURL("https://img.youtube.com/vi/\(id)/maxresdefault.jpg", placeHolder: placeholder)
    }
    
    func imageFromFullLaunch(fullLaunch: FullLaunch?) {
//        let placeholder = R.image.placeholder()
        let placeholder = UIImage(named: "")
        if let flickr = fullLaunch?.launch.links?.flickr?.original {
            if !flickr.isEmpty {
                imageFromURL(flickr[0], placeHolder: placeholder)
                return
            }
        }
        if let youtubeID = fullLaunch?.launch.links?.youtubeId {
            imageFromYouTubeId(id: youtubeID, placeholder: placeholder)
        } else {
            image = placeholder
        }
    }
}
