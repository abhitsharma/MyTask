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
    @Binding  var refreshTaskList:Bool
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
                        if taskViewModel.deleteTask(task: selectedTask){
                            showTaskDetailView.toggle()
                            refreshTaskList.toggle()
                        }
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
                        if taskViewModel.updateTasdk(task: selectedTask){
                            showTaskDetailView.toggle()
                            refreshTaskList.toggle()
                        }
                    }label: {
                        Text("Update")
                    }
                }
            }
        }
    }
}

#Preview {
    TaskDetailView(taskViewModel: TaskViewModel(), selectedTask: .constant(Task.createMockTask().first!), showTaskDetailView: .constant(false), refreshTaskList: .constant(false))
}
