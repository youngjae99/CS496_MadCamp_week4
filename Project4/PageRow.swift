//
//  PageRow.swift
//  Project4
//
//  Created by Youngjae Jang on 2020/08/06.
//  Copyright © 2020 Youngjae Jang. All rights reserved.
//

import SwiftUI

struct PageRow: View {
    var page: Page
    
    var body: some View {
        HStack {
            /*page.image
                .resizable()
                .frame(width: 50, height: 50)*/
            Text(page.name)
            Spacer()
        }
    }
}

struct PageRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PageRow(page: pageData[0])
            PageRow(page: pageData[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
