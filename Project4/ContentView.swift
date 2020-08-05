//
//  ContentView.swift
//  Furniture
//
//  Created by Balaji on 21/06/20.
//  Copyright © 2020 Kavsoft. All rights reserved.
//

import SwiftUI
import UIKit
import VisionKit
import Vision
import Firebase

struct ContentView: View {
    var body: some View {
        // status bar color is changing only when it is embeded in navigation view..
        // WWDC 2020 will solve this...
        NavigationView{
            
            TabView()
                .navigationBarTitle("",displayMode: .inline)
                .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .previewDevice("iPhone X")
    }
}

struct TabView : View {
    
    @State var index = 0
    @Environment(\.colorScheme) var scheme // color system -> dark / bright
    @State private var showingAlert = false
    
    //let TR = TextRecognizer("1")
    
    var body: some View{
        VStack(spacing: 0){
            ZStack{
                HStack(spacing: 15){
                    Button(action: {
                        self.showingAlert = true
                    }) {
                        Image("menu")
                            // for dark mode adoption....
                            .foregroundColor(.primary)
                    }
                    .alert(isPresented: $showingAlert){
                        Alert(title:Text("메뉴 기능 개발중"), message:Text("기다리세요 손님 하하"), dismissButton: .default(Text("넹")))
                    }
                    
                    Spacer()
                    
                    Button(action: { // 라이트/다크모드 전환
                        UIApplication.shared.windows.first?.rootViewController?.overrideUserInterfaceStyle = self.scheme == .dark ? .light : .dark
                    }) {
                        Image(systemName: self.scheme == .dark  ? "sun.max.fill" : "moon.fill")
                            .font(.system(size: 22))
                            // for dark mode adoption....
                            .foregroundColor(.primary)
                    }
                }
                .padding(.horizontal)
                
                Text("Bookly")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 10)
            
            ZStack{
                HomeTab()
                    .opacity(self.index == 0 ? 1 : 0)
                SecondTab()
                    .opacity(self.index == 1 ? 1 : 0)
                ThirdTab()
                    .opacity(self.index == 2 ? 1 : 0)
                FourthTab()
                    .opacity(self.index == 3 ? 1 : 0)
            }
            
            HStack{
                Button(action: {
                    self.index = 0
                }) {
                    
                    HStack(spacing: 6){
                     
                        Image(systemName: "questionmark")
                        .font(.system(size: 20.0, weight: .bold))
                        .foregroundColor(self.index == 0 ? .white : .primary)
                        
                        if self.index == 0{
                            
                            Text("Home")
                                .foregroundColor(self.index == 0 ? .white : .primary)
                        }
                        
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    .background(self.index == 0 ? Color("Color") : Color.clear)
                    .clipShape(Capsule())
                }
                
                Spacer(minLength: 0)
                
                Button(action: {
                    self.index = 1
                }) {
                    HStack(spacing: 6){
                        Image(systemName: "book")
                            .font(.system(size: 20.0, weight: .bold))
                            .foregroundColor(self.index == 1 ? .white : .primary)
                        /*
                        Image("heart")
                            // dark mode adoption...
                            .foregroundColor(self.index == 2 ? .white : .primary)*/
                        
                        if self.index == 1{
                            Text("Capture")
                                .foregroundColor(self.index == 1 ? .white : .primary)
                        }
                        
                        
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    .background(self.index == 1 ? Color("Color") : Color.clear)
                    .clipShape(Capsule())
                }
                
                Spacer(minLength: 0)
                
                Button(action: {
                    self.index = 2
                }) {
                    
                    HStack(spacing: 6){
                     
                        Image(systemName: "paintbrush")
                        .font(.system(size: 20.0, weight: .bold))
                        .foregroundColor(self.index == 2 ? .white : .primary)
                        
                        if self.index == 2{
                            
                            Text("Decorate")
                                .foregroundColor(self.index == 2 ? .white : .primary)
                        }
                        
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    .background(self.index == 2 ? Color("Color") : Color.clear)
                    .clipShape(Capsule())
                }
                Spacer(minLength: 0)
                
                Button(action: {
                    self.index = 3
                }) {
                    
                    HStack(spacing: 6){
                     
                        Image(systemName: "person")
                        .font(.system(size: 20.0, weight: .bold))
                        .foregroundColor(self.index == 3 ? .white : .primary)
                        
                        if self.index == 3{
                            
                            Text("Account")
                                .foregroundColor(self.index == 3 ? .white : .primary)
                        }
                        
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    .background(self.index == 3 ? Color("Color") : Color.clear)
                    .clipShape(Capsule())
                }
            }
            .padding(.horizontal, 50)
            .padding(.top)
            // based on device bottom padding will be changed...
            .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 10 : UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            // for shadow...
            .background(self.scheme == .dark ? Color.black : Color.white)
            .shadow(color: Color.primary.opacity(0.08), radius: 5, x: 0, y: 0)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

/*
struct LikeTab : View {
        
    @State private var showScanner = false
    @ObservedObject var recognizedText: RecognizedText = RecognizedText()
    
    var body: some View{
        VStack{
            Text(recognizedText.value)
            .lineLimit(nil)
            .padding(.bottom, 40)
            
            Button(action: {
                self.showScanner = true
            }) {
                Image(systemName: "doc.text.viewfinder")
                    .font(.system(size: 40.0))
                    .foregroundColor(.primary)
            }
            
            HStack{
                
                Text("Captured Page")
                    .fontWeight(.bold)
                    .font(.title)
                Spacer()
            }
            .padding(.horizontal, 50)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    ForEach(furnitures,id: \.self){furniture in
                        HStack(spacing: 15){
                            ForEach(furniture){i in
                                
                                VStack{
                                    
                                    Image(i.image)
                                    
                                    Text(i.title)
                                        .fontWeight(.bold)
                                    
                                    Text(i.price)
                                        .padding(.top, 6)
                                }
                                .padding()
                                .background(Color.primary.opacity(0.06))
                                .cornerRadius(10)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .sheet(isPresented: $showScanner){
            ScanningView(recognizedText: self.$recognizedText.value)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ThirdTab : View {
    var body: some View{
        VStack{
            Text("Third view")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct AccountTab : View {
    
    var body: some View{
        
        VStack{
             
            Text("Account")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}*/

struct HomeTab : View {
    
    @Environment(\.colorScheme) var scheme
    @State var search = ""
    @State private var showingAlert = false
    
    var body: some View{
        VStack{
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    HStack(spacing: 15){
                        
                        TextField("Search", text: self.$search)
                        
                        if self.search != ""{
                            Button(action: {
                                
                            }) {
                                
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal, 20)
                    .background(Color.primary.opacity(0.06))
                    .cornerRadius(12)
                    
                    HStack{
                        
                        Text("Today's Pick")
                            .fontWeight(.bold)
                            .font(.title)
                        Spacer()
                    }
                    .padding()
                    
                    VStack{
                        
                        Image("1")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200.0)
                            .cornerRadius(5)
                        
                        Text("28 Summers")
                            .fontWeight(.bold)
                            .font(.title)
                            .padding(.top,0)
                        
                        Text("$1200")
                            .foregroundColor(.gray)
                            .padding(.top,8)
                            .padding(.bottom)
                    }
                    .background(
                        Color.primary.opacity(0.06)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .cornerRadius(25)
                            .padding(.top,95)
                    )
                    .padding(.top,25)
                    
                    HStack{
                        
                        Text("Recommended For You")
                            .fontWeight(.bold)
                            .font(.title)
                        
                        Spacer()
                    }
                    .padding(.top,30)
                    .padding(.bottom, 20)
                    .padding()
                    
                    ForEach(furnitures,id: \.self){furniture in
                        
                        HStack(spacing: 15){
                            
                            ForEach(furniture){i in
                                
                                VStack{
                                    
                                    Image(i.image)
                                    
                                    Text(i.title)
                                        .fontWeight(.bold)
                                    
                                    Text(i.price)
                                        .padding(.top, 6)
                                }
                                .padding()
                                .background(Color.primary.opacity(0.06))
                                .cornerRadius(10)
                            }
                        }
                    }
                    
                }
                .padding()
            }
            .padding(.horizontal, 20)
            Spacer()
        }
    }
}

// sample Data...

struct Furniture : Identifiable,Hashable{
    
    var id : Int
    var image : String
    var title : String
    var price : String
}

// 2D array For Grid FUnction....

var furnitures = [
    [
    Furniture(id: 0, image: "r11", title: "Wood Frame", price: "$1200"),
    Furniture(id: 1, image: "r12", title: "Yellow Armchair", price: "$600")
    ],
    
    [
    Furniture(id: 2, image: "r21", title: "Modern Armchair", price: "$240"),
    Furniture(id: 3, image: "r22", title: "IKEA Ingolf", price: "$1500")
    ],
    
    [
    Furniture(id: 4, image: "r31", title: "Yellow Wheel", price: "$2200"),
    Furniture(id: 5, image: "r32", title: "Scandinavin", price: "$1650")
    ]
]
