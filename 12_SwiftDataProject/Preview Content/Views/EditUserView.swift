//
//  EditUserView.swift
//  12_SwiftDataProject
//
//  Created by Taka on 2024-10-22.
//

import SwiftUI
import SwiftData

struct EditUserView: View {
    @Environment(\.modelContext) private var modelContext
    var jobs = Job.sampleData
    
    @Bindable var user: User
    @State private var selectedJobs: Set<Job>
    
    init(user: User) {
        _user = Bindable(user)
        _selectedJobs = State(initialValue: Set(user.jobs))
    }
    
    var body: some View {
        Form {
            TextField("Name", text: $user.name)
            TextField("City", text: $user.city)
            DatePicker("Join Date", selection: $user.joinDate, displayedComponents: [.date])
            
            DisclosureGroup() {
                List(jobs) { job in
                    HStack {
                        Text(job.name)
                        Spacer()
                        if selectedJobs.map(\.id).contains(job.id) {
                            Image(systemName: "checkmark")  /// Display check mark @ row if selected
                        }
                    }
                    .contentShape(Rectangle()) // Extend tap area
                    .onTapGesture {
                        if selectedJobs.contains(job) { 
                            selectedJobs.remove(job)
                        } else {
                            selectedJobs.insert(job)
                        }
                        user.jobs = Array(selectedJobs)
                        /// update data
                        try? modelContext.save()
                    }
                }
            }label:{
                HStack {
                    Text("Select Jobs")
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
        .navigationTitle("Edit User")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview(traits: .sampleData) {
    @Previewable @Query var users: [User]

    NavigationStack{
        EditUserView(user: users.first!)
    }
}
