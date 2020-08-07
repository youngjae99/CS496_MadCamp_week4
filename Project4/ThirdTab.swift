//
//  CustomTab.swift
//  MadCampPr4
//
//  Created by 이현진 on 2020/08/06.
//  Copyright © 2020 이현진. All rights reserved.
//

import SwiftUI
//import ModalView
import Photos

struct DecorateTab: View {
    @State var txt = ""
    @State var show = false
    @State var showingImg = ""
    @State var writed = ""
    
//    @State var txtColor = .black
    @State var txtFont = 1
    
    @State var btn = 1
    
    @State private var uiImage: UIImage? = nil;
    
    //private var imageHelper = ImageSaver()
    
    var body: some View {
        
        VStack(spacing: 15){
            HStack{
                Button(action: {
                    self.btn = 1
                }){
                    Image("edit")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .padding()
                        .foregroundColor(.black)
                    
                    
                }
            
                
                Button(action: {
                    self.show.toggle()
                    self.btn = 2
                }){
                    Image("load")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .padding()
                    .foregroundColor(.black)
                }
                .sheet(isPresented: $show){
                    LoadImages(selectedImg: self.$showingImg)
                }
                
                Button(action: {
                    self.btn = 3
                }){
                    Image("color")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .padding()
                    .foregroundColor(.black)
//                    Text("Save").padding()
                }
                
                Button(action: {
                    
                }){
                    Image("download")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .padding()
                    .foregroundColor(.black)
//                    Text("Save").padding()
                }
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .clipShape(Capsule())
            }
            
            if self.btn == 1 {
                Write(txt: self.$txt).border(Color.gray.opacity(0.5), width: 1)
            }
            else if self.btn == 2 {
                Image(self.showingImg)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay(Text(self.txt))
            }
            else if self.btn == 3{
                Image(self.showingImg)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay(Text(self.txt).foregroundColor(.white))

            }
//            Write(txt: $txt).border(Color.gray.opacity(0.5), width: 1)
            
//                .overlay(Text("배경화면 만들기 중"))

        }.padding()
    }
}


struct LoadImages: View {
//    @State var selectedImg : String
//    @Binding var data : BgImage
//    @Binding var show : Bool
    @Binding var selectedImg : String
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack{
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    
                    ForEach(images,id: \.self){image in
                        
                        HStack(spacing: 5){
                            
                            ForEach(image){i in
                                Image(i.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width / 3 - 8)
                                .onTapGesture{
                                    print(i.image)
                                    self.selectedImg = i.image
                                    self.mode.wrappedValue.dismiss()
//                                    self.selectedImg = i.image
//                                    print(self.selectedImg)
//                                    //Image(i.image)
                                }
//                                .onTapGesture {
//                                    self.data.selected = true
//                                    print(self.data.id)
//                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .padding(.horizontal, 5)
            Spacer()
        }
    }
//    func getImage() {
//        let req = PHAsset.fetchAssets(with: .image, options: .none)
//
//        DispatchQueue.global(qos: .background).async {
//            req.enumerateObjects{ (asset, _, _) in
//
//                let options = PHImageRequestOptions()
//                options.isSynchronous = true
//
//                PHCachingImageManager.default().requestImage(for: asset, targetSize: .init(), contentMode: .default, options: options){ (image, _) in
//
//                    print(image?.pngData())
//                }
//            }
//        }
//    }
    
}

struct BgImage : Identifiable,Hashable{
    
    var id : Int
    var image : String
    var selected : Bool
}

//struct Card : View {
//    var data : BgImage
//    var body: some View{
//        Image(id: self.data.id)
//
//    }
//}

// 2D array For Grid FUnction....

var images = [
    [
    BgImage(id: 0, image: "bg1", selected: false),
    BgImage(id: 1, image: "bg2", selected: false),
    BgImage(id: 2, image: "bg3", selected: false)
    ],
    
    [
    BgImage(id: 3, image: "bg4", selected: false),
    BgImage(id: 4, image: "bg5", selected: false),
    BgImage(id: 5, image: "bg6", selected: false)
    ],
    
    [
    BgImage(id: 6, image: "bg7", selected: false),
    BgImage(id: 7, image: "bg8", selected: false),
    BgImage(id: 8, image: "bg9", selected: false)
    ]
]

//
//
//struct DecorateTab_Previews: PreviewProvider {
//    static var previews: some View {
//        DecorateTab()
//    }
//}
//
