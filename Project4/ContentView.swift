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
import FirebaseAuth


struct ContentView: View {
    var body: some View {
        // status bar color is changing only when it is embeded in navigation view..
        // WWDC 2020 will solve this...
        NavigationView{
            Main()
                .navigationBarTitle("",displayMode: .inline)
                .navigationBarHidden(true)
            /*
            TabView(showMenu: false)
                .navigationBarTitle("",displayMode: .inline)
                .navigationBarHidden(true)*/
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
    
    @State var showMenu = false
    @State var dark = false
    @State var show = false
    
    //let TR = TextRecognizer("1")
    
    var body: some View{
        
        let drag = DragGesture()
        .onEnded{
          if $0.translation.width < -100 {
            withAnimation{
              self.showMenu = false
            }
          }
        }
        
        return VStack(spacing: 0){
            ZStack{
                HStack(spacing: 15){
                    Button(action: {
                        
                        if self.showMenu==true{
                            withAnimation {self.showMenu = false}
                        }
                        else{
                            withAnimation {self.showMenu = true}
                        }
                    }) {
                        Image("menu")
                            // for dark mode adoption....
                            .foregroundColor(.primary)
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
                Text("Booklip")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
             
            
            GeometryReader{ geometry in
              // alignment: .leading을 안하면 보이지 않음
                ZStack(alignment: .leading){
                    
                    HomeTab()
                        .opacity(self.index == 0 ? 1 : 0)
                        .offset(x: self.showMenu ? UIScreen.main.bounds.width / 1.5 : 0)
                        .disabled(self.showMenu ? true : false)
                    SecondTab()
                        .opacity(self.index == 1 ? 1 : 0)
                    .offset(x: self.showMenu ? UIScreen.main.bounds.width / 1.5 : 0)
                    .disabled(self.showMenu ? true : false)
                    ThirdTab()
                        .opacity(self.index == 2 ? 1 : 0)
                    .offset(x: self.showMenu ? UIScreen.main.bounds.width / 1.5 : 0)
                    .disabled(self.showMenu ? true : false)
                    FourthTab()
                        .opacity(self.index == 3 ? 1 : 0)
                    .offset(x: self.showMenu ? UIScreen.main.bounds.width / 1.5 : 0)
                    .disabled(self.showMenu ? true : false)
                    if self.showMenu{
                      HStack{
                        MenuView(dark: self.$dark, show: self.$show)
                        .transition(.move(edge: .leading))
                      }
                    }
                }
              .gesture(drag)
            }
            /*
            ZStack{
                HomeTab()
                    .opacity(self.index == 0 ? 1 : 0)
                SecondTab()
                    .opacity(self.index == 1 ? 1 : 0)
                ThirdTab()
                    .opacity(self.index == 2 ? 1 : 0)
                FourthTab()
                    .opacity(self.index == 3 ? 1 : 0)
            }*/
            
            HStack{
                Button(action: {
                    self.index = 0
                }) {
                    HStack(spacing: 6){
                        Image(systemName: "house")
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
            .padding(.horizontal, 10)
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






struct Main : View {
  @State var show = false
  @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
  var body: some View{
    NavigationView{
      VStack{
        if self.status{
          NavigationView{
              TabView(showMenu: false)
            .navigationBarTitle("",displayMode: .inline)
            .navigationBarHidden(true)
                }
        }
        else{
          ZStack{
            NavigationLink(destination: SignUp(show: self.$show), isActive: self.$show){
              Text("")
            }
            .hidden()
            Login(show: self.$show)
          }
        }
      }
      .navigationBarTitle("")
      .navigationBarHidden(true)
      .navigationBarBackButtonHidden(true)
      .onAppear(){
        NotificationCenter.default.addObserver(forName: NSNotification.Name("status"), object: nil, queue: .main) {(_) in
          self.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
        }
      }
    }
  }
}

// sample Data...

