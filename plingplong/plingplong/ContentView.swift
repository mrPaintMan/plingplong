//
//  ContentView.swift
//  plingplong
//
//  Created by Filip Palmqvist on 2023-02-05.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Spacer()
                Text("Välj användare")
                Spacer()
                
                HStack {
                    NavigationLink {
                        FilipsView()
                    } label: {
                        Text("Filip")
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal)
                        .background {
                            Rectangle()
                                .fill(LinearGradient(gradient: Gradient(colors: [.blue, .blue.opacity(0.7)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            
                            }
                        .cornerRadius(15)
                        .padding(.vertical)
                    }
                    
                    NavigationLink {
                        MariasView()
                    } label: {
                        Text("Maria")
                            .foregroundColor(.white)
                            .padding()
                            .padding(.horizontal)
                            .background {
                                Rectangle()
                                    .fill(LinearGradient(gradient: Gradient(colors: [.red, .red.opacity(0.7)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                
                                }
                            .cornerRadius(15)
                            .padding(.vertical)
                    }
                }
                
                Spacer()
                Spacer()
            }
        }
    }
}


private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
