//
//  ThirdTab.swift
//  Project4
//
//  Created by Youngjae Jang on 2020/08/06.
//  Copyright © 2020 Youngjae Jang. All rights reserved.
//

import SwiftUI
import ModalView

struct ThirdTab: View {
    @Environment(\.colorScheme) var scheme

    var body: some View {
        ModalPresenter {
            ModalLink(destination: Text("Modal View")) {
                Text("Main view")
                    .foregroundColor(Color.primary)
            }
        }
        .frame(maxWidth:.infinity, maxHeight:.infinity)
        .padding(.horizontal, 50)
        .background(Color.blue)
    }
}

struct ThirdTab_Previews: PreviewProvider {
    static var previews: some View {
        ThirdTab()
    }
}
