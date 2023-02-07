//
//  MariasView.swift
//  plingplong
//
//  Created by Filip Palmqvist on 2023-02-05.
//

import SwiftUI

struct MariasView: View {
    var body: some View {
        Button {
            print("pushed!")
        } label: {
            Text("Pling Plong Filip")
                .foregroundColor(.white)
                .padding(100)
                .background {
                    ZStack{
                        Image("MariasDefaultImage")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                        Circle()
                            .fill(LinearGradient(gradient: Gradient(colors: [.blue, .blue.opacity(0.7)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .opacity(0.7)
                    }
                }
        }

    }
}

struct MariasView_Previews: PreviewProvider {
    static var previews: some View {
        MariasView()
    }
}
