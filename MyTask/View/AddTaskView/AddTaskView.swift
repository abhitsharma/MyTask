//
//  AddTaskView.swift
//  MyTask
//
//  Created by Abhit Sharma on 14/09/25.
//

import SwiftUI

struct AddTaskView: View {
    @ObservedObject var taskViewModel : TaskViewModel
    @State private var taskToAdd:Task = Task(id: 0, name: "", description: "", isCompleted: true, finishDate: Date())
    @Binding  var showAddTaskView :Bool

    var body: some View {
        NavigationStack{
            List{
                Section("Task Detail") {
                    TextField("Task Name", text: $taskToAdd.name)
                    TextField("Task Description", text: $taskToAdd.description)
                }
                
                Section("Task Date/Time"){
                    DatePicker("Task Date", selection: $taskToAdd.finishDate)
                }
                
            }
            .navigationTitle("Add Task")
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button{
                        showAddTaskView = false
                    }label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        print("cancell button")
                    }label: {
                        Text("Add")
                    }
                }
            }
            
        }
    }
}

#Preview {
    AddTaskView(taskViewModel: TaskViewModel(), showAddTaskView: .constant(false))
}
