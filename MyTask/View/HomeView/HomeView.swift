//
//  HomeView.swift
//  MyTask
//
//  Created by Abhit Sharma on 13/09/25.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var taskViewModel:TaskViewModel = TaskViewModel()
    @State private var pickerFilter = ["Active","Closed"]
    @State private var defaultPickerFilter = "Active"
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
                    
                }
                
            }.onAppear{
                taskViewModel.getTask(isActive: true)
            }
            .listStyle(.plain)
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView()
}
