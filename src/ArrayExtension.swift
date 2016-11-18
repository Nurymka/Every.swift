//
//  ArrayExtension.swift
//  Every
//
//  Created by Pierre TACCHI on 06/01/16.
//  Copyright © 2016 Samhan. All rights reserved.
//

public extension Array where Element : Equatable {
    mutating func removeObject(_ object : Iterator.Element) {
        if let index = self.index(of: object) {
            self.remove(at: index)
        }
    }
}
