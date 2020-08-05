//
//  SecondTab.swift
//  Project4
//
//  Created by Youngjae Jang on 2020/08/06.
//  Copyright © 2020 Youngjae Jang. All rights reserved.
//

import SwiftUI
import ModalView

struct SecondTab: View {
    
    @State private var showScanner = false
    @ObservedObject var recognizedText: RecognizedText = RecognizedText()
    
    var body: some View {
        NavigationView {
            VStack {
                
                NavigationLink(destination: CaptureNewView()) {
                    HStack{
                        Image(systemName: "doc.text.viewfinder")
                        .font(.system(size: 25.0))
                        .foregroundColor(.primary)
                        
                        Text("New Scan")
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    .background(Color("Color"))
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
            .sheet(isPresented: $showScanner){
                ScanningView(recognizedText: self.$recognizedText.value)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationBarTitle("움직여")
        .padding(.horizontal, 30)
    }
}

struct SecondTab_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
