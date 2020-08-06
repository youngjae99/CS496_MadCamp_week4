//
//  ImageLoader.swift
//  Project4
//
//  Created by Youngjae Jang on 2020/08/06.
//  Copyright © 2020 Youngjae Jang. All rights reserved.
//


import Foundation
import SwiftUI
import Combine

class ImageLoader:ObservableObject{
    @Published var downloadImage: UIImage?
    
    func fetchImg(url:String){
        guard let imageURL = URL(string:url) else{
            fatalError("The url string is invalid")
        }
        
        URLSession.shared.dataTask(with:imageURL){ data, response, error in
            guard let data = data, error == nil else{
                fatalError("error rendering the image")
            }
            
            DispatchQueue.main.async{
                self.downloadImage = UIImage(data:data)
            }
        }.resume()
        
    }
}
