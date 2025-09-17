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
    @Binding  var refreshTaskList:Bool
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
                        showAddTaskView.toggle()
                    }label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        if taskViewModel.addTask(task: taskToAdd){
                            showAddTaskView.toggle()
                            refreshTaskList.toggle()
                        }
                    }label: {
                        Text("Add")
                    }
                }
            }
            
        }
    }
}

#Preview {
    AddTaskView(taskViewModel: TaskViewModel(), showAddTaskView: .constant(false), refreshTaskList: .constant(false))
}
