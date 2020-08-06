struct TabView3 : View {
  @State var index = 0
  @Environment(\.colorScheme) var scheme
  @State var showMenu = false
  @State var dark = false
  @State var show = false
  var body: some View{
    // swiping
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
        GeometryReader{ geometry in
          // alignment: .leading을 안하면 보이지 않음
          ZStack(alignment: .leading){
            Home(showMenu: self.$showMenu)
              .opacity(self.index == 0 ? 1 : 0)
              .offset(x: self.showMenu ? UIScreen.main.bounds.width / 1.5 : 0)
              .disabled(self.showMenu ? true : false)
            if self.showMenu{
              HStack{
                MenuView(dark: self.$dark, show: self.$show)
                .transition(.move(edge: .leading))
              }
//              .background(Color.primary.opacity(self.showMenu ? (self.dark ? 0.05 : 0.2) : 0).edgesIgnoringSafeArea(.all))
            }
          }
          .gesture(drag)
        }
        Search()
          .opacity(self.index == 1 ? 1 : 0)
        Cart()
          .opacity(self.index == 2 ? 1 : 0)
        Account()
          .opacity(self.index == 3 ? 1 : 0)
      }
      HStack{
        Button(action: {
          self.index = 0
        }) {
          HStack(spacing: 6){
            Image("home")
              // dark mode adoption...
              .foregroundColor(self.index == 0 ? .white : .primary)
            if self.index == 0{
              Text("Home")
                .foregroundColor(.white)
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
            Image("search")
              // dark mode adoption...
              .foregroundColor(self.index == 1 ? .white : .primary)
            if self.index == 1{
              Text("Search")
                .foregroundColor(.white)
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
            Image("cart")
              // dark mode adoption...
              .foregroundColor(self.index == 2 ? .white : .primary)
            if self.index == 2{
              Text("Cart")
                .foregroundColor(.white)
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
            Image("account")
              // dark mode adoption...
              .foregroundColor(self.index == 3 ? .white : .primary)
            if self.index == 3{
              Text("Account")
                .foregroundColor(.white)
            }
          }
          .padding(.vertical,10)
          .padding(.horizontal)
          .background(self.index == 3 ? Color("Color") : Color.clear)
          .clipShape(Capsule())
        }
      }
      .padding(.horizontal,25)
      .padding(.top)
      // based on device bottom padding will be changed...
      .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 10 : UIApplication.shared.windows.first?.safeAreaInsets.bottom)
      // for shadow...
      .background(self.scheme == .dark ? Color.black : Color.white)
      .shadow(color: Color.primary.opacity(0.08), radius: 5, x: 5, y: -5)
    }
    .edgesIgnoringSafeArea(.bottom)
  }
}
