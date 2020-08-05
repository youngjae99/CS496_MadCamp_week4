//
//  SearchView.swift
//  Project4
//
//  Created by Youngjae Jang on 2020/08/05.
//  Copyright © 2020 Youngjae Jang. All rights reserved.
//

import SwiftUI

struct SearchTab : View {
    let testclass = Test()
    
    @State private var showScanner = false
    @ObservedObject var recognizedText: RecognizedText = RecognizedText()
    
    var body: some View{
        VStack{
            Text(recognizedText.value)
            .lineLimit(nil)
            .padding(.bottom, 40)
            
            Button(action: {
                //hehehe()
                self.showScanner = true
            }) {
                Text("Go to Scan")
            }
            .padding(.bottom, 40)
            
            NavigationLink(destination: ScanningView(recognizedText: $recognizedText.value)) {
                Text("Scan document")
            }
        }
        .sheet(isPresented: $showScanner){
            ScanningView(recognizedText: self.$recognizedText.value)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

