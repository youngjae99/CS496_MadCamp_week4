//
//  RecognizedText.swift
//  Project4
//
//  Created by Youngjae Jang on 2020/08/05.
//  Copyright © 2020 Youngjae Jang. All rights reserved.
//

import Combine
import SwiftUI

final class RecognizedText: ObservableObject, Identifiable {
    
    let willChange = PassthroughSubject<RecognizedText, Never>()
    
    var value: String = "Scan document to see its contents" {
        willSet {
            willChange.send(self)
        }
    }
    
}

struct RecongizedText_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
