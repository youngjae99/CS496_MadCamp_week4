//
//  CaptureNewView.swift
//  Project4
//
//  Created by Youngjae Jang on 2020/08/06.
//  Copyright © 2020 Youngjae Jang. All rights reserved.
//

import SwiftUI

struct CaptureNewView: View {
    @State private var showScanner = false
    @ObservedObject var recognizedText: RecognizedText = RecognizedText()
    
    var body: some View {
        NavigationView {
            Text(recognizedText.value)
            .lineLimit(nil)
            .padding(.bottom, 20)
                
            
            Button(action: {self.showScanner = true}) {
                Image(systemName: "doc.text.viewfinder")
                .font(.system(size: 30.0))
                .foregroundColor(.primary)
            }.sheet(isPresented: $showScanner){
                ScanningView(recognizedText: self.$recognizedText.value)
            }
            
            /*
            .navigationBarItems(trailing:
                Button("Help") {
                    print("Help tapped!")
                }
            )*/
            
        }
        .navigationBarTitle("Scan Page")
        
    }
}

struct CaptureNewView_Previews: PreviewProvider {
    static var previews: some View {
        CaptureNewView()
    }
}
