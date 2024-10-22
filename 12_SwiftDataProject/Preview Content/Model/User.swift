//
//  User.swift
//  12_SwiftDataProject
//
//  Created by Taka on 2024-10-22.
//


import SwiftData
import SwiftUI


@Model
class User { //}: Codable {
    var name: String
    var city: String
    var joinDate: Date
    var jobs: [Job] = []

    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}



extension User {
    static let sampleData: [User] = [
        .init(name: "Taka", city: "Tokyo", joinDate: Date.now),
        .init(name: "Yuki", city: "Osaka", joinDate: Date.now),
        .init(name: "Kohei", city: "Sapporo", joinDate: Date.now),
        .init(name: "Masaki", city: "Nagoya", joinDate: Date.now),
        .init(name: "Kazuki", city: "Fukuoka", joinDate: Date.now),
        .init(name: "Yasuhiro", city: "Kanazawa", joinDate: Date.now)
    ]
}

@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(
            for: User.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        let modelContext = container.mainContext
        if try modelContext.fetch(FetchDescriptor<User>()).isEmpty {
            User.sampleData.forEach { modelContext.insert($0) }
        }
        return container
    } catch {
        fatalError("Failed to create preview container")
    }
}()



struct SampleData: PreviewModifier {

    static func makeSharedContext() throws -> ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(
            for: User.self,
            configurations: config
        )
        SampleData.createSampleData(into: container.mainContext)
        return container
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
          content.modelContainer(context)
    }
    
    static func createSampleData(into modelContext: ModelContext) {
        Task { @MainActor in
            if try modelContext.fetch(FetchDescriptor<User>()).isEmpty {
                User.sampleData.forEach { modelContext.insert($0) }
            }
            try? modelContext.save()
        }
    }
    
}

@available(iOS 18.0, *)
extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var sampleData: Self = .modifier(SampleData())
}
