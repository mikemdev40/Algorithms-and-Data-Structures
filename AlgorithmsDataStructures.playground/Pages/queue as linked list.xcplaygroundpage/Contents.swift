//: Mike Miller
//: Working through https://www.udemy.com/algorithms-and-data-structures/learn/v4/content
//: Algorithms & Data Structures In Java, Part I (Udemy)

import Foundation

class Node {
    
    var data: Int = 0
    var nextNode: Node?
    var previousNode: Node?
    
    init(data: Int) {
        self.data = data
    }
}


class Queue {  //doubly linked list implementation
    
    private var start: Node?
    private var end: Node?
    private var count = 0
    
    //O(1) time (no loops, etc.)
    func enqueue(node: Node) {  //re-implementation of addNodeToBeginning
        if start == nil {
            start = node
            end = node
        } else {
            node.nextNode = start
            start?.previousNode = node
            start = node
        }
    
        count += 1
    }

    //O(1) time (no loops, etc.)
    func dequeue() -> Node? {
        if start == nil || end == nil {
            print("no node objects in queue")
            return nil
        }
        
        count -= 1

        let nodeToReturn = end
        
        end = nodeToReturn?.previousNode
        end?.nextNode = nil
        nodeToReturn?.previousNode = nil
        
        return nodeToReturn
    }
    
    //O(N) time (iterate through ALL nodes)
    func traverse() {
        if start == nil || end == nil {
            print("no nodes in queue")
            return
        }
        
        var node: Node? = start!
        while node != nil {
            print(node!.data)
            node = node!.nextNode
        }
        print("")
    }
    
    func getCount() -> Int {
        return count
    }
}

let myQueue = Queue()

myQueue.enqueue(Node(data: 6))
myQueue.enqueue(Node(data: 10))
myQueue.enqueue(Node(data: 12))
myQueue.traverse()
myQueue.count

myQueue.dequeue()?.data
myQueue.traverse()
myQueue.count

myQueue.dequeue()?.data
myQueue.traverse()
myQueue.count

myQueue.dequeue()?.data
myQueue.traverse()
myQueue.count

myQueue.dequeue()?.data
myQueue.count



