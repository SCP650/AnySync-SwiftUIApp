//
//  UIButton.swift
//  AnySync
//
//  Created by Atlas on 3/5/21.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .padding()
                       .foregroundColor(Color.white)
                       .background(
                           RoundedRectangle(cornerRadius: 10)
                               .stroke(lineWidth: 2)
                               .background(Color.green)
                       )
    }
}
