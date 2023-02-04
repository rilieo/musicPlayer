//
//  Extension.swift
//  um
//
//  Created by riley dou on 2023/1/10.
//

import Foundation

extension DateComponentsFormatter{
    static let abbreviated: DateComponentsFormatter = {
        print("Initializing DateComponentFormatter.abbreviated")
        let formatter = DateComponentsFormatter()
        
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        
        return formatter
        
    }()
    
    static let positions: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
        return formatter
    }()
}
