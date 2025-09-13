//
//  TaskViewModel.swift
//  MyTask
//
//  Created by Abhit Sharma on 13/09/25.
//

import Foundation


final class TaskViewModel :ObservableObject{
    @Published var tasks : [Task] = []
    
    func getTask(isActive:Bool){
        tasks = Task.createMockTask().filter({$0.isActive == isActive})
    }
}
