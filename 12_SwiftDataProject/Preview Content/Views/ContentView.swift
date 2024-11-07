//
//  ContentView.swift
//  12_SwiftDataProject
//
//  Created by Taka on 2024-10-22.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \User.name, order: .forward) var users: [User]
    @State var path: [User] = [User]()
    
    var body: some View {
        NavigationStack(path: $path) {
            List{
                ForEach(users) { user in
                    NavigationLink(value: user) {
                        HStack {
                            Text(user.name)
                            Spacer()
                            Text("\(user.jobs.count)")
                                .fontWeight(.black)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(.indigo.opacity(0.7))
                                .foregroundStyle(.white)
                                .clipShape(Capsule())
                        }
                    }
                }
            }
            .navigationTitle("Users")
            .navigationDestination(for: User.self) { user in
                EditUserView(user: user)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add User", systemImage: "plus") {
                        let user = User(name: "", city: "", joinDate: .now)
                        modelContext.insert(user)
                        path.append(user)
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("clear", systemImage: "trash") {
                        try? modelContext.delete(model:User.self)
                    }
                }
            }
        }
    }
}

#Preview("Model Container") {
    ContentView()
        .modelContainer(previewContainer)
}


#Preview("PreviewModifier", traits: .sampleData) {
//    @Previewable  @Query(sort: \User.name, order: .reverse) var users: [User]
    ContentView()
}
