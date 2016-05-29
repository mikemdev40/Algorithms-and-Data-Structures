//
//  LinkedList.swift
//  AlgorithmsDataStructures
//
//  Created by Michael Miller on 5/29/16.
//  Copyright © 2016 MikeMiller. All rights reserved.
//

import Foundation

class LinkedList {
    
    private var root: Node?
    private var count = 0
    
    //O(1) time (no loops, etc.)
    func addNodeToBeginning(node: Node) {
        if root == nil {
            root = node
        } else {
            node.nextNode = root
            root = node
        }
        count += 1
    }
    
    //O(N) time (makes a recursive call)
    func addNodeToEnd(node: Node) {
        if root == nil {
            root = node
        } else {
            insertAtEnd(node, currentNode: root!)
        }
        count += 1
    }
    
    //O(1) time (no loops, etc.)
    func removeFirstNode() {
        if root == nil {
            return
        }
        
        var nodeToRemove = root
        root = root?.nextNode  //sets root to the next node; if it's nil, then nil!
        nodeToRemove = nil
        count -= 1
    }
    
    //NEED TO FIX TO ACCOUNT FOR IF ONLY ONE NODE
    //O(N) time (single while loop that iterates throgh)
    func removeLastNode() {
        if root == nil {
            return
        }
        
        var currentNode: Node? = root!
        var previousNode: Node?
        
        while currentNode != nil {
            if let nextNode = currentNode?.nextNode {
                previousNode = currentNode
                currentNode = nextNode
            } else {
                currentNode = nil
                previousNode?.nextNode = nil  //delete the current one, and breaking loop
            }
        }
        
        count -= 1
    }
    //O(N) time (will have to iterate through, stopping at first node if found; at WORST O(N) time, at best, O(1) time)
    func findAndRemoveFirstInstanceOf(node: Node) {
        
    }
    
    //O(N) time (will have to iterate through ALL nodes)
    func findAndRemoveAllInstancesOf(node: Node) {
        
    }
    
    //O(N) time (iterate through ALL nodes)
    func traverse() {
        if root == nil {
            print("no nodes in list")
            return
        }
        
        var node: Node? = root!
        while node != nil {
            print(node!.data)
            node = node!.nextNode
        }
        print("\n")
        
    }
    
    //O(N) time (has to iterate through ALL nodes to find end)
    private func insertAtEnd(nodeToInsert: Node, currentNode: Node){
        if let nextNode = currentNode.nextNode {
            insertAtEnd(nodeToInsert, currentNode: nextNode)
        } else {
            currentNode.nextNode = nodeToInsert
        }
    }
    
    func getCount() -> Int {
        return count
    }
    
}
