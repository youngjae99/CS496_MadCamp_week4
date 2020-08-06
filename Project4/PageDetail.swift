/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing the details for a landmark.
*/

import SwiftUI

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
                    
                Button(action: {}) {
                    Text("Make Decoration")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 150)
                        .background(Color.yellow)
                        .cornerRadius(40)
                    
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
