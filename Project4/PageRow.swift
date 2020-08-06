//
//  PageRow.swift
//  Project4
//
//  Created by Youngjae Jang on 2020/08/06.
//  Copyright © 2020 Youngjae Jang. All rights reserved.
//

import SwiftUI

struct PageRow: View {
    var data: ThreadDataType
    
    var body: some View {
        HStack {
            /*page.image
                .resizable()
                .frame(width: 50, height: 50)*/
            Image("3dbook")
                .resizable()
                .frame(width: 50, height: 50)
            VStack(alignment: .leading){
                Text(data.title)
                    .font(.title)
                    .frame(alignment: .leading)
                Text(data.sentence)
                    //.font(.system(size: 50, weight: .bold))
                    .foregroundColor(Color.gray)
                    .frame(height:40,alignment:.leading)
                
            }
            //.background(Color.blue)
            .cornerRadius(10)
            Spacer()
        }
    }
}

/*
struct PageRow_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            PageRow(data: {title:"movidic"; sentence:"qwleqwlkaksdkasjdawqwqw"; userID:"youngjae"})
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
*/
