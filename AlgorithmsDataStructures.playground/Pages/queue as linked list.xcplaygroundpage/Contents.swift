
import Foundation

class Node {
    
    var data: Int = 0
    var nextNode: Node?
    var previousNode: Node?
    
    init(data: Int) {
        self.data = data
    }
}


class Queue {  //linked list implementation
    
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
    
    //NEED TO FIX TO ACCOUNT FOR IF ONLY ONE NODE
    //O(N) time (single while loop that iterates throgh)
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
        print("\n")
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

myQueue.dequeue()?.data
myQueue.traverse()

myQueue.dequeue()?.data
myQueue.traverse()

myQueue.dequeue()?.data
myQueue.traverse()

myQueue.dequeue()?.data


