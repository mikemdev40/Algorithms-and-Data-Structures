//
//  Node.swift
//  AlgorithmsDataStructures
//
//  Created by Michael Miller on 5/29/16.
//  Copyright © 2016 MikeMiller. All rights reserved.
//

import Foundation

class Node {
    
    var data: Int = 0
    var nextNode: Node?
    
    init(data: Int) {
        self.data = data
    }
    
    deinit {
        print("gone!")
    }
}