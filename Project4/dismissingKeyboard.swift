//
//  dismissingKeyboard.swift
//  Project4
//
//  Created by Youngjae Jang on 2020/08/06.
//  Copyright © 2020 Youngjae Jang. All rights reserved.
//

import Foundation
import SwiftUI

struct DismissingKeyboard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                let keyWindow = UIApplication.shared.connectedScenes
                        .filter({$0.activationState == .foregroundActive})
                        .map({$0 as? UIWindowScene})
                        .compactMap({$0})
                        .first?.windows
                        .filter({$0.isKeyWindow}).first
                keyWindow?.endEditing(true)
        }
    }
}
