import SwiftUI
struct MenuView: View {
  @Binding var dark : Bool
  @Binding var show : Bool
  var body: some View {
    VStack{
      Text("My Profile")
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
      Image("irene")  // 넣어야되는거
      .resizable()
      .frame(width: 100, height: 100)
      .clipShape(Circle())
      VStack(spacing: 12){
        Text("Irene")
        Text("Red Velvet")
          .font(.caption)
      }
      .padding(.top, 20)
      Group{
        Button(action: {
        }){
          HStack(spacing: 22){
            Image("logout")
              .resizable()
              .frame(width: 25, height: 25)
              .foregroundColor(.yellow)
            Text("Logout")
            Spacer()
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
    .foregroundColor(.primary)
    .padding(.horizontal, 20)
    .frame(width: UIScreen.main.bounds.width / 1.5)
    .background((self.dark ? Color.black : Color("color")).edgesIgnoringSafeArea(.all))
    .overlay(Rectangle().stroke(Color.primary.opacity(0.2), lineWidth: 2).shadow(radius: 3).edgesIgnoringSafeArea(.all))
//    VStack{
//      Image("banner")
//    }
    //Image("banner")
  }
}
