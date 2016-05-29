//
//  ViewController.swift
//  AlgorithmsDataStructures
//
//  Created by Michael Miller on 5/29/16.
//  Copyright © 2016 MikeMiller. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let myList = LinkedList()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let node = Node(data: 5)
        myList.addNodeToBeginning(node)
        let node2 = Node(data: 10)
        myList.addNodeToBeginning(node2)
        let node3 = Node(data: -9)
        myList.addNodeToEnd(node3)
        let node4 = Node(data: -7)
        myList.addNodeToEnd(node4)
        let node5 = Node(data: 90)
        myList.addNodeToEnd(node5)
        myList.traverse()
        
        myList.removeFirstNode()
        myList.traverse()
        
        myList.removeLastNode()
        myList.traverse()
        
        myList.removeLastNode()
        myList.traverse()
        
        myList.removeLastNode()
        myList.traverse()
        
        print("\(myList.getCount())")
    }

}

