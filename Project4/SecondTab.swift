//
//  SecondTab.swift
//  Project4
//
//  Created by Youngjae Jang on 2020/08/06.
//  Copyright © 2020 Youngjae Jang. All rights reserved.
//

import SwiftUI
import ModalView
import Firebase
import FirebaseStorage

struct SecondTab: View {
    @ObservedObject var recognizedText: RecognizedText = RecognizedText()
    @Environment(\.colorScheme) var scheme
    @ObservedObject private var datas = firebaseData
    
    var body: some View {
        NavigationView {
            VStack {
                
                NavigationLink(destination: CaptureNewView()) {
                    HStack{
                        /*Image(systemName: "doc.text.viewfinder")
                        .font(.system(size: 25.0))
                        .foregroundColor(.primary)*/
                        Text("New Scan")
                            .foregroundColor(self.scheme == .dark  ? Color.black: Color.white)
                    }
                    .frame(width: 200, height: 50)
                    .background(Color.primary)
                    .clipShape(Capsule())
                    
                }.navigationBarTitle("List")
                
                /*
                List(pageData) { page in
                    ModalPresenter {
                        ModalLink(destination: PageDetail(page: page)) {
                            PageRow(page: page)
                        }
                    }
                }*/
                List(datas.data) { data in
                    ModalPresenter {
                        ModalLink(destination: PageDetail(data: data)) {
                            PageRow(data: data)
                        }
                    }
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding(.horizontal, 30)
    }
}
/*
struct SecondTab_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            
            NavigationLink(destination: CaptureNewView()) {
                HStack{
                    Image(systemName: "doc.text.viewfinder")
                    .font(.system(size: 25.0))
                    .foregroundColor(.primary)
                    
                    Text("New Scan")
                        .foregroundColor(.primary)
                }
                .frame(width: 230, height: 50)
                .background(Color.black)
                .clipShape(Capsule())
                
            }.navigationBarTitle("List")
            
            List(pageData) { page in
                /*
                NavigationLink(destination: PageDetail(page: page)) {
                    PageRow(page: page)
                }*/
                ModalPresenter {
                    ModalLink(destination: PageDetail(page: page)) {
                        PageRow(page: page)
                    }
                }
            }
        }
    }
}
*/
