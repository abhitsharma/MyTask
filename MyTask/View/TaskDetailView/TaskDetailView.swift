//
//  TaskDetailView.swift
//  MyTask
//
//  Created by Abhit Sharma on 14/09/25.
//

import SwiftUI

struct TaskDetailView: View {
    @ObservedObject var taskViewModel : TaskViewModel
    @Binding var selectedTask:Task
    @Binding var showTaskDetailView:Bool
    var body: some View {
        NavigationStack{
            List{
                Section("Task Detail") {
                    TextField("Task Name", text: $selectedTask.name)
                    TextField("Task Description", text: $selectedTask.description)
                    Toggle("Mark Completed", isOn: $selectedTask.isCompleted)
                }
                
                Section("Task Date/Time"){
                    DatePicker("Task Date", selection: $selectedTask.finishDate)
                }
                Section(){
                    Button{
                        print("delete")
                    }label:{
                        Text("Delete")
                            .fontWeight(.bold)
                            .foregroundStyle(.red)
                            .frame(maxWidth: .infinity,alignment: .center)
                            
                    }
                    
                }
                
            }
            .navigationTitle("Task Detail")
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button{
                        showTaskDetailView.toggle()
                    }label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        print("Update Task")
                    }label: {
                        Text("Update")
                    }
                }
            }
        }
    }
}

#Preview {
    TaskDetailView(taskViewModel: TaskViewModel(), selectedTask: .constant(Task.createMockTask().first!), showTaskDetailView: .constant(false))
}
