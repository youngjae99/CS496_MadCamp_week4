import SwiftUI
import Firebase
import FirebaseAuth


struct Login : View {
  @State var color = Color.primary.opacity(0.85)
  @Environment(\.colorScheme) var scheme
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
            .resizable()
            .scaledToFit()
            .frame(height: 150)
            
            Text("Log in to your account")
              .font(.title)
              .fontWeight(.bold)
                .foregroundColor(.primary)
              .padding(.top, 35)
            
            
                TextField("Email", text: self.$email)
                .autocapitalization(.none)
                .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color.primary.opacity(0.5) : self.color,lineWidth: 2))
                .padding(.top, 25)
                .keyboardType(.emailAddress)
            //}
             //.modifier(DismissingKeyboard())
            
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
            .background(RoundedRectangle(cornerRadius: 4).stroke(self.pass != "" ? Color.primary.opacity(0.5) : self.color ,lineWidth: 2))
            .padding(.top, 25)
            .modifier(DismissingKeyboard())
            
            HStack{
              Spacer()
              Button(action: {
                self.reset()
              }) {
                Text("Forget password")
                  .fontWeight(.bold)
                    .foregroundColor(self.color)
              }
            }
            .padding(.top, 20)
            Button(action: {
              self.verify()
            }) {
              Text("Log in")
                .fontWeight(.bold)
                .foregroundColor(self.scheme == .dark ? Color.black: Color.white)
                .padding(.vertical)
                .frame(width: UIScreen.main.bounds.width - 50)
            }
            .background(Color.primary)
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
            .foregroundColor(Color.primary.opacity(0.7))
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

