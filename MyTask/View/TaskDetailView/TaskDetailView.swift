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
    @State  var showDeleteAlert:Bool = false
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
                        showDeleteAlert.toggle()
                    }label:{
                        Text("Delete")
                            .fontWeight(.bold)
                            .foregroundStyle(.red)
                            .frame(maxWidth: .infinity,alignment: .center)
                            
                    }.alert("Delete Task?", isPresented: $showDeleteAlert){
                        Button{
                            showTaskDetailView.toggle()
                        }label: {
                            Text("no")
                        }
                        Button(role: .destructive){
                            if taskViewModel.deleteTask(task: selectedTask){
                                showTaskDetailView.toggle()
                                refreshTaskList.toggle()
                            }
                        }label: {
                            Text("Delete")
                        }
                    }message: {
                        Text("Do you want to delete this task ")
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
                    }.disabled(selectedTask.name.isEmpty)
                }
            }
        }
    }
}

#Preview {
    TaskDetailView(taskViewModel: TaskViewModel(), selectedTask: .constant(Task.createMockTask().first!), showTaskDetailView: .constant(false), refreshTaskList: .constant(false))
}
