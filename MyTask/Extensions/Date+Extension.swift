//
//  Date+Extension.swift
//  MyTask
//
//  Created by Abhit Sharma on 13/09/25.
//
import Foundation

extension Date{
    func toString() -> String{
        let dateformater = DateFormatter()
        dateformater.dateStyle = .short
        dateformater.timeStyle = .short
        return dateformater.string(from: self)
    }
}
