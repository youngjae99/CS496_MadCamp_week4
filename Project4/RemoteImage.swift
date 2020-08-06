//
//  RemoteImage.swift
//  Project4
//
//  Created by Youngjae Jang on 2020/08/06.
//  Copyright © 2020 Youngjae Jang. All rights reserved.
//

import SwiftUI

struct RemoteImage: View {
    @ObservedObject var imageLoader = ImageLoader()
    
    var placeholder: Image
    
    init(url: String, placeholder:Image = Image(systemName: "photo")){
        self.placeholder = placeholder
        imageLoader.fetchImg(url: url)
    }
     
    var body: some View {
        if let image = self.imageLoader.downloadImage{
            Image(uiImage: image)//.resizable().scaledToFit().frame(width: 100, height: 100)
        }
        return placeholder
    }
}

struct RemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImage(url:"")
    }
}
