//
//  XmarkView.swift
//  SwiftCryptoApp
//
//  Created by Rahul Gupta on 26/03/23.
//

import SwiftUI

struct XmarkView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        },
               label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

struct XmarkView_Previews: PreviewProvider {
    static var previews: some View {
        XmarkView()
    }
}
