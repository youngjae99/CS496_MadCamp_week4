/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing the details for a landmark.
*/

import SwiftUI
import UIKit

struct PageDetail: View {
    var data: ThreadDataType

    var body: some View {
        /*
        VStack {
            VStack(alignment: .leading) {
                Text(data.title)
                    .font(.title)

                HStack(alignment: .top) {
                    Text(data.sentence)
                        .font(.subheadline)
                    Spacer()
                    Text(data.userID)
                        .font(.subheadline)
                }
            }
            .padding()

            Spacer()
        }
        .navigationBarTitle(Text(data.title), displayMode: .inline)
        */
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack{
                HStack{
                    Text(data.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Spacer()
                }
                .padding(.top)
                .padding(.horizontal)
                                    
                Text(data.sentence)
                    .multilineTextAlignment(.leading)
                    .padding(.top)
                    .padding(.horizontal)
                    // Button..
                

                    
                Button(action: {
                    print("copied text")
                    UIPasteboard.general.string = self.data.sentence // 클립보드에 복사
                }) {
//                    Text("Make Decoration")
//                        .fontWeight(.bold)
//                        .foregroundColor(.white)
//                        .padding(.vertical)
//                        .frame(width: UIScreen.main.bounds.width - 150)
//                        .background(Color.yellow)
//                        .cornerRadius(40)
                    
                    Text("Make Decoration")
                        .fontWeight(.medium)
                        .padding()
                        .background(Color.primary)
                        .cornerRadius(40)
                        .foregroundColor(.white)
                        .padding(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.yellow, lineWidth: 5)
                        )
                }
                .padding(.top,25)
                .padding(.bottom)
            }
        }
    }
}

/*
struct PageDetail_Previews: PreviewProvider {
    static var previews: some View {
        PageDetail(page: pageData[0])
    }
}
*/

struct PageDetail_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
