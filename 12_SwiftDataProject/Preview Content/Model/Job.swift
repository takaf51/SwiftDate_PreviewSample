//
//  Job.swift
//  12_SwiftDataProject
//
//  Created by Taka on 2024-10-23.
//

import Foundation
import SwiftData


@Model
class Job: Identifiable, Hashable, Equatable {
    var id: UUID
    var name: String
    var priority: Int
    weak var owner: User?
    
    init(name: String, priority: Int, owner: User? = nil, id: UUID = .init()) {
        self.name = name
        self.priority = priority
        self.owner = owner
        self.id = id
    }
    
    static func == (lhs: Job, rhs: Job) -> Bool {
        lhs.id == rhs.id
    }
}


extension Job  {
    static let sampleData: [Job] = [
        .init(name: "Wash dishes", priority: 1, id: UUID(uuidString: "0CBBB9BC-20CA-4613-AD5E-5F30FF2A9EC9")!),
        .init(name: "Clean room", priority: 2, id: UUID(uuidString: "4CB83EA8-70A1-45B5-AC5B-7FAE19AAD3C1")!),
        .init(name: "Wash clothes", priority: 3, id: UUID(uuidString: "5B28BF63-2B9E-45CE-A434-D6256B4EFE74")!),
        .init(name: "Pick up mail", priority: 4, id: UUID(uuidString: "87F979E0-C171-4079-A4B6-EDFAE7694370")!),
        .init(name: "Organize desk", priority: 5, id: UUID(uuidString: "591D35EF-7ED7-4E5D-BEF0-66DBC4AD9E96")!),
    ]
}

//[0CBBB9BC-20CA-4613-AD5E-5F30FF2A9EC9, 4CB83EA8-70A1-45B5-AC5B-7FAE19AAD3C1, 5B28BF63-2B9E-45CE-A434-D6256B4EFE74, 87F979E0-C171-4079-A4B6-EDFAE7694370, 591D35EF-7ED7-4E5D-BEF0-66DBC4AD9E96]

