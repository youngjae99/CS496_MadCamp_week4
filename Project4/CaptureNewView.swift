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
    @State var text = "test text"
    //@State var text = recognizedText.value
    
    
    init(){
        self.showScanner=true
    }
    
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
                    //var text = recognizedText.value
                    VStack(spacing:0){
                        TextField("Title", text: self.$title)
                                .frame(height: 40)
                                .padding(.horizontal, 20)
                                .background(Color.primary.opacity(0.12))
                                .cornerRadius(12)
                        
                        ScrollView{
                            Text(recognizedText.value)
                            .lineLimit(nil)
                            .background(Color.primary.opacity(0.06))
                            .cornerRadius(12)
                            .padding(.bottom, 20)
                        }
                        .padding(.bottom, 20)
                        .frame(maxHeight: .infinity)
                        

//                        Write(txt: $text)
//                            .border(Color.gray.opacity(0.5), width: 200)

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
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 150)
                                .background(Color.blue)
                                .cornerRadius(40)
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
                
            }
        }
        .navigationBarTitle("New Scan")
        .padding(.top,0)
        .background(Color.blue)
        
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


struct Write: UIViewRepresentable {
  @Binding var txt : String
  func makeCoordinator() -> Write.Coordinator {
    return Write.Coordinator(parent1: self)
  }
    
  func makeUIView(context: UIViewRepresentableContext<Write>) -> UITextView {
    let tview = UITextView()
    tview.isEditable = true
    tview.isUserInteractionEnabled = true
    tview.isScrollEnabled = true
    tview.text = txt//"Type Something"
    tview.textColor = .gray
    tview.font = .systemFont(ofSize: 20)
    tview.delegate = context.coordinator
    return tview
  }
  func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<Write>) {
  }
    
  class Coordinator : NSObject, UITextViewDelegate{
    var parent : Write
    init(parent1 : Write) {
      parent = parent1
    }
    func textViewDidChange(_ textView: UITextView) {
      self.parent.txt = textView.text
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
      textView.text = ""
      textView.textColor = .label
    }
  }
}


