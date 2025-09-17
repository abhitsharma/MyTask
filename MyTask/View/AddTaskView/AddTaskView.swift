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
    @State  var showDirtyCheckAlert:Bool = false
    var pickerDateRange: ClosedRange<Date> {
         let calendar = Calendar.current
         let currentDateComponent = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: Date())
         
         let startDateComponent = DateComponents(year: currentDateComponent.year, month: currentDateComponent.month, day: currentDateComponent.day, hour: currentDateComponent.hour, minute: currentDateComponent.minute)
         
         let endDateComponent = DateComponents(year: 2026, month: 12, day: 31)
         
         return calendar.date(from: startDateComponent)!...calendar.date(from: endDateComponent)!
         
     }
    var body: some View {
        NavigationStack{
            List{
                Section("Task Detail") {
                    TextField("Task Name", text: $taskToAdd.name)
                    TextField("Task Description", text: $taskToAdd.description)
                }
                
                Section("Task Date/Time"){
                    DatePicker("Task Date", selection: $taskToAdd.finishDate,in: pickerDateRange)
                }
                
            }
            .navigationTitle("Add Task")
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button{
                        if !taskToAdd.name.isEmpty {
                            showDirtyCheckAlert.toggle()
                        } else {
                            showAddTaskView.toggle()
                        }
                    }label: {
                        Text("Cancel")
                    }.alert("Save Task", isPresented: $showDirtyCheckAlert){
                        Button{
                            showAddTaskView.toggle()
                        }label: {
                            Text("cancel")
                        }
                        Button{
                            addTask()
                        }label: {
                            Text("Save")
                        }
                    }message: {
                        Text("would you like to save the task")
                    }
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        addTask()
                    }label: {
                        Text("Add")
                    }
                    .disabled(taskToAdd.name.isEmpty)
                }
            }
            
        }
    }
    
    private func addTask(){
        if taskViewModel.addTask(task: taskToAdd){
            showAddTaskView.toggle()
            refreshTaskList.toggle()
        }
    }
}

#Preview {
    AddTaskView(taskViewModel: TaskViewModel(), showAddTaskView: .constant(false), refreshTaskList: .constant(false))
}
