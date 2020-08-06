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
                Text("Bookly")
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

struct Login : View {
  @State var color = Color.black.opacity(0.7)
  @State var email = ""
  @State var pass = ""
  @State var visible = false
  @Binding var show : Bool
  @State var alert = false
  @State var error = ""
  var body: some View{
    ZStack{
      ZStack(alignment: .topTrailing){
        GeometryReader{_ in
          VStack{
            Image("logo")
            Text("Log in to your account")
              .font(.title)
              .fontWeight(.bold)
              .foregroundColor(self.color)
              .padding(.top, 35)
            TextField("Email", text: self.$email)
            .autocapitalization(.none)
            .padding()
            .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Color") : self.color,lineWidth: 2))
            .padding(.top, 25)
            HStack(spacing: 15){
              VStack{
                if self.visible{
                  TextField("Password", text: self.$pass)
                  .autocapitalization(.none)
                }
                else{
                  SecureField("Password", text: self.$pass)
                  .autocapitalization(.none)
                }
              }
              Button(action: {
                self.visible.toggle()
              }) {
                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                  .foregroundColor(self.color)
              }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 4).stroke(self.pass != "" ? Color("Color") : self.color,lineWidth: 2))
            .padding(.top, 25)
            HStack{
              Spacer()
              Button(action: {
                self.reset()
              }) {
                Text("Forget password")
                  .fontWeight(.bold)
                  .foregroundColor(Color("Color"))
              }
            }
            .padding(.top, 20)
            Button(action: {
              self.verify()
            }) {
              Text("Log in")
                .foregroundColor(.white)
                .padding(.vertical)
                .frame(width: UIScreen.main.bounds.width - 50)
            }
            .background(Color("Color"))
            .cornerRadius(10)
            .padding(.top, 25)
          }
          .padding(.horizontal, 25)
        }
        Button(action: {
          self.show.toggle()
        }) {
          Text("Register")
            .fontWeight(.bold)
            .foregroundColor(Color("Color"))
        }
        .padding()
      }
      if self.alert{
        ErrorView(alert: self.$alert, error: self.$error)
      }
    }
  }
  // 빈 칸인지 확인하는 함수
  func verify(){
    if self.email != "" && self.pass != ""{
      Auth.auth().signIn(withEmail: self.email, password: self.pass){ (res, err) in
        if err != nil{
          self.error = err!.localizedDescription
          self.alert.toggle()
          return
        }
        print("Success!")
        UserDefaults.standard.set(true, forKey: "status")
        NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
      }
    }
    else{
      self.error = "Please fill all the contents properly"
      self.alert.toggle()
    }
  }
  // 비밀번호 찾기 시 reset
  func reset() {
    if self.email != ""{
      Auth.auth().sendPasswordReset(withEmail: self.email) { (err) in
        if err != nil{
          self.error = err!.localizedDescription
          self.alert.toggle()
          return
        }
        self.error = "RESET"
        self.alert.toggle()
      }
    }
    else{
      self.error = "Email Id is empty"
      self.alert.toggle()
    }
  }
}

struct SignUp : View {
  @State var color = Color.black.opacity(0.7)
  @State var email = ""
  @State var pass = ""
  @State var repass = ""
  @State var visible = false
  @State var revisible = false
  @Binding var show : Bool
  @State var alert = false
  @State var error = ""
  var body: some View{
    ZStack{
      ZStack(alignment: .topLeading){
        GeometryReader{_ in
          VStack{
            Image("logo")
            Text("Log in to your account")
              .font(.title)
              .fontWeight(.bold)
              .foregroundColor(self.color)
              .padding(.top, 35)
            TextField("Email", text: self.$email)
            .autocapitalization(.none)
            .padding()
            .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Color") : self.color,lineWidth: 2))
            .padding(.top, 25)
            HStack(spacing: 15){
              VStack{
                if self.visible{
                  TextField("Password", text: self.$pass)
                  .autocapitalization(.none)
                }
                else{
                  SecureField("Password", text: self.$pass)
                  .autocapitalization(.none)
                }
              }
              Button(action: {
                self.visible.toggle()
              }) {
                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                  .foregroundColor(self.color)
              }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 4).stroke(self.repass != "" ? Color("Color") : self.color,lineWidth: 2))
            .padding(.top, 25)
            HStack(spacing: 15){
              VStack{
                if self.revisible{
                  TextField("Re-enter", text: self.$repass)
                  .autocapitalization(.none)
                }
                else{
                  SecureField("Re-enter", text: self.$repass)
                  .autocapitalization(.none)
                }
              }
              Button(action: {
                self.revisible.toggle()
              }) {
                Image(systemName: self.revisible ? "eye.slash.fill" : "eye.fill")
                  .foregroundColor(self.color)
              }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 4).stroke(self.pass != "" ? Color("Color") : self.color,lineWidth: 2))
            .padding(.top, 25)
            Button(action: {
              self.register()
            }) {
              Text("Register")
                .foregroundColor(.white)
                .padding(.vertical)
                .frame(width: UIScreen.main.bounds.width - 50)
            }
            .background(Color("Color"))
            .cornerRadius(10)
            .padding(.top, 25)
          }
          .padding(.horizontal, 25)
        }
        Button(action: {
          self.show.toggle()
        }) {
          Image(systemName: "chevron.left")
            .font(.title)
            .foregroundColor(Color("Color"))
        }
        .padding()
      }
      if self.alert{
        ErrorView(alert: self.$alert, error: self.$error)
      }
    }
    .navigationBarBackButtonHidden(true)
  }
  func register(){
    if self.email != ""{
      if self.pass == self.repass{  // 비밀번호 입력과 확인 입력이 같을 때 등록
        Auth.auth().createUser(withEmail: self.email, password: self.pass){
          (res, err) in
          if err != nil{
            self.error = err!.localizedDescription
            self.alert.toggle()
            return
          }
          print("Success")
          UserDefaults.standard.set(true, forKey: "status")
          NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
        }
      }
      else{  // 입력과 확인이 일치하지 않았을 때
        self.error = "Password mismatch"
        self.alert.toggle()
      }
    }
    else{
      self.error = "Please fill all the contents properly"
      self.alert.toggle()
    }
  }
}
struct ErrorView : View {
  @State var color = Color.black.opacity(0.7)
  @Binding var alert : Bool
  @Binding var error : String
  var body: some View{
    GeometryReader{_ in
      VStack{
        HStack{
          Text(self.error == "RESET" ? "Message" : "Error")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(self.color)
          Spacer()
        }
        .padding(.horizontal, 25)
        Text(self.error == "RESET" ? "Password reset link has been sent successfully" : self.error)
        .foregroundColor(self.color)
        .padding(.top)
        .padding(.horizontal, 25)
        Button(action: {
          self.alert.toggle()   // 클릭 시 꺼짐
        }) {
          Text(self.error == "RESET" ? "Ok" : "Cancel")
            .foregroundColor(.white)
          .padding(.vertical)
          .frame(width: UIScreen.main.bounds.width - 120)
        }
        .background(Color("Color"))
        .cornerRadius(10)
        .padding(.top, 25)
      }
      .padding(.vertical, 25)
      .frame(width: UIScreen.main.bounds.width - 70)
      .background(Color.white)
      .cornerRadius(15)
    }
    .background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
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
