/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing the details for a landmark.
*/

import SwiftUI

struct PageDetail: View {
    var page: Page

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(page.name)
                    .font(.title)

                HStack(alignment: .top) {
                    Text(page.park)
                        .font(.subheadline)
                    Spacer()
                    Text(page.state)
                        .font(.subheadline)
                }
            }
            .padding()

            Spacer()
        }
        .navigationBarTitle(Text(page.name), displayMode: .inline)
    }
}

struct PageDetail_Previews: PreviewProvider {
    static var previews: some View {
        PageDetail(page: pageData[0])
    }
}
