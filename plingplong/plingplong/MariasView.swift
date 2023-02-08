//
//  MariasView.swift
//  plingplong
//
//  Created by Filip Palmqvist on 2023-02-05.
//

import SwiftUI

struct MariasView: View {
    @State var hasSent = false
    
    private struct Payload: Codable {
        var user: String
    }
    
    private func sendFilipMessage() async {
        guard let payload = try? JSONEncoder().encode(Payload(user: "Filip")) else {
            print("Failed to encode payload")
            return
        }
        
        let url = URL(string: "https://us-central1-plingplong-19030.cloudfunctions.net/sendHttpPushNotification")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (_, res) = try await URLSession.shared.upload(for: request, from: payload)
            hasSent = (res as? HTTPURLResponse)?.statusCode == 200
            
        } catch {
            print("Failed to send message")
        }
        
    }
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            Text("Filip är underrättad.")
                .foregroundColor(.red)
                .opacity(hasSent ? 1 : 0)
            
            Spacer()
            Button {
                hasSent = false
                Task {
                    await sendFilipMessage()
                }
                print("pushed!")
            } label: {
                Text("Pling Plong Filip")
                    .font(Font.title)
                    .bold()
                    .foregroundColor(.white)
                    .padding(70)
                    .background {
                        ZStack{
                            Image("MariasDefaultImage")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                            Circle()
                                .strokeBorder(Color.white, lineWidth: 5)
                                .background(content: {
                                    Circle().fill(LinearGradient(gradient: Gradient(colors: [.blue, .blue.opacity(0.7)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .opacity(0.7)
                                })
                                .shadow(radius: 10)
                        }
                    }
            }
            Spacer()
            Spacer()
        }
    }
}

struct MariasView_Previews: PreviewProvider {
    static var previews: some View {
        MariasView()
    }
}
