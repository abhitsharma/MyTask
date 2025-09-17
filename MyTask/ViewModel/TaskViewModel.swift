//
//  TaskViewModel.swift
//  MyTask
//
//  Created by Abhit Sharma on 13/09/25.
//

import Foundation


final class TaskViewModel :ObservableObject{
    @Published var tasks : [Task] = []
    private var tempTask = Task.createMockTask()
     
    func getTask(isActive:Bool){
        tasks = tempTask.filter({$0.isCompleted == !isActive})
    }
    
    func addTask(task: Task) -> Bool {
        let taskId = Int.random(in: 4...100)
        let taskToAdd = Task(id: taskId,
                             name: task.name,
                             description: task.description,
                             isCompleted: false,
                             finishDate: task.finishDate)
        tempTask.append(taskToAdd)
        return true
    }
    
    func updateTasdk(task: Task) -> Bool{
        if let index = tempTask.firstIndex(where: {$0.id == task.id}) {
            tempTask[index] = task
        }
        return true
    }
    
    func deleteTask(task: Task) -> Bool{
        if let index = tempTask.firstIndex(where: {$0.id == task.id}) {
            tempTask.remove(at: index)
        }
        return true
    }
}
