//
//  HomeView.swift
//  MyTask
//
//  Created by Abhit Sharma on 13/09/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var taskViewModel:TaskViewModel = TaskViewModel()
    @State private var pickerFilter = ["Active","Closed"]
    @State private var defaultPickerFilter = "Active"
    @State private var showAddTaskView :Bool = false
    @State private var showTaskDetailView :Bool = false
    @State private var selectedTask :Task = Task(id: 0, name: "", description: "", isCompleted: false, finishDate: Date())

    var body: some View {
        NavigationStack{
            Picker("Picker Filter", selection: $defaultPickerFilter){
                ForEach(pickerFilter,id: \.self){
                    Text($0)
                }
            }.pickerStyle(.segmented)
                .onChange(of: defaultPickerFilter){
                    taskViewModel.getTask(isActive: defaultPickerFilter == "Active")
                }
            List(taskViewModel.tasks, id: \.id){ task in
                VStack(alignment: .leading){
                    Text(task.name)
                        .font(.title)
                    HStack{
                        Text(task.description)
                            .lineLimit(2)
                        Spacer()
                        Text(task.finishDate.toString())
                    }
                    .font(.subheadline)
                    
                }.onTapGesture{
                    selectedTask = task
                    showTaskDetailView.toggle()
                }
                
            }.onAppear{
                taskViewModel.getTask(isActive: true)
            }
            .listStyle(.plain)
            .navigationTitle("Home")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        showAddTaskView = true
                    }label:{
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddTaskView){
                AddTaskView(taskViewModel: taskViewModel, showAddTaskView: $showAddTaskView)
            }
            .sheet(isPresented: $showTaskDetailView){
                TaskDetailView(taskViewModel: taskViewModel, selectedTask: $selectedTask, showTaskDetailView: $showTaskDetailView)
            }
        }
    }
}

#Preview {
    HomeView()
}
