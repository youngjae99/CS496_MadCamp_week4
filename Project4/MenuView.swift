import SwiftUI
struct MenuView: View {
  @Binding var dark : Bool
  @Binding var show : Bool
  @Environment(\.colorScheme) var scheme
    
  var body: some View {
    VStack{
      Text("My Profile")
        .font(.title)
        .fontWeight(.bold)
        .padding(.top, 25)
        .padding(.bottom)
      // 프로필 수정
//      HStack{
//        Button(action: {
//          self.show.toggle()
//        }) {ㅠ
//          Image(systemName: "chevron.left")
//            .resizable()
//            .frame(width: 12, height: 20)
//            .font(.title)
//            .foregroundColor(Color("Color"))
//        }
//        Spacer()
//      }
      Image("profile")  // 넣어야되는거
      .resizable()
      .frame(width: 100, height: 100)
      .clipShape(Circle())
        
      VStack(spacing: 12){
        Text("Irene")
            .fontWeight(.bold)
        Text("Red Velvet")
            .font(.caption)
      }
      .padding(.top, 20)
        
      Group{
        
        Button(action: {
            
        }){
          HStack(spacing: 5){
            Image(systemName: "arrow.left.square")
              .resizable()
              .frame(width: 15, height: 15)
                .foregroundColor(self.scheme == .dark  ? Color.black: Color.white)
            Text("Logout")
          }
        }
        .padding(25)
        
        Divider()
        Button(action: {
        }){
          HStack(spacing: 22){
            Image("idea")
              .resizable()
              .frame(width: 30, height: 30)
              .foregroundColor(.green)
            Text("About Application")
            Spacer()
          }
        }
        .padding(25)
      }
      Spacer()
      Image("banner")
      .resizable()
      .scaledToFit()
      .frame(width: UIScreen.main.bounds.width / 1.5)
    }
    .foregroundColor(self.scheme == .dark  ? Color.black: Color.white)
    .padding(.horizontal, 20)
    .frame(width: UIScreen.main.bounds.width / 1.5)
    .background(Color.primary)
    .edgesIgnoringSafeArea(.all)
    .overlay(Rectangle()
    .stroke(Color.primary.opacity(0.2), lineWidth: 0)
    .shadow(radius: 4).edgesIgnoringSafeArea(.all))
//    VStack{
//      Image("banner")
//    }
    //Image("banner")
    }
}
