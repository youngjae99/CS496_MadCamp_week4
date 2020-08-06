//
//  CaptureNewView.swift
//  Project4
//
//  Created by Youngjae Jang on 2020/08/06.
//  Copyright © 2020 Youngjae Jang. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct CaptureNewView: View {
    @State var showScanner = false
    @ObservedObject var recognizedText: RecognizedText = RecognizedText()
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var showingAlert = false
    @State private var showingAlert_2 = false
    @State var title = ""
    
    var body: some View {
        
        NavigationView {
            VStack{
                if(recognizedText.value=="Scan the page you like"){
                    VStack{
                        Button(action: {self.showScanner = true}) {
                            Image(systemName: "doc.text.viewfinder")
                            .font(.system(size: 50.0))
                            .foregroundColor(.primary)
                        }.sheet(isPresented: $showScanner){
                            ScanningView(recognizedText: self.$recognizedText.value)
                        }
                        .padding(.bottom, 20)
                        Image("arrow_image")
                            .resizable()
                            .scaledToFit()
                            .frame(width:200)
                            .colorMultiply(.primary)
                        
                    }
                }
                else{
                    VStack{
                        TextField("Title", text: self.$title)
                            .padding(.vertical,10)
                            .padding(.horizontal, 20)
                            .background(Color.primary.opacity(0.12))
                            .cornerRadius(12)
                        
                        Text(recognizedText.value)
                        .lineLimit(nil)
                        .background(Color.primary.opacity(0.06))
                        .cornerRadius(12)
                        .padding(.bottom, 40)
                        
                        
                        Button(action:{
                            if(self.title==""){
                                self.showingAlert_2 = true
                            }
                            else{
                                self.showingAlert = true
                            }
                        })
                        {
                            Text("Save")
                        }
                        .alert(isPresented: $showingAlert){
                            Alert(title: Text("Save to your list"), message: Text("There is no undo"), primaryButton: .default(Text("Save")) {
                                
                                print("Saving...")
                                firebaseData.createData(msg1: self.title, msg2: self.recognizedText.value)
                                self.mode.wrappedValue.dismiss()
                                
                            }, secondaryButton: .cancel())
                        }
                        .alert(isPresented: $showingAlert_2){
                            Alert(title: Text("Warning"), message: Text("Please enter title"), dismissButton: .default(Text("OK")))
                        }
                        Spacer()
                    }
                }
                
                Spacer()
            }
        }
        .navigationBarTitle("New Scan")
        
    }
}

struct MultilineTextView: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}

struct CaptureNewView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
