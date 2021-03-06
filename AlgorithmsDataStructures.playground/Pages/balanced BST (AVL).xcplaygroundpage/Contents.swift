//: Mike Miller
//: Working through https://www.udemy.com/algorithms-and-data-structures/learn/v4/content
//: Algorithms & Data Structures In Java, Part I (Udemy)

import Foundation

class Node<T: Comparable> {
    
    var data: T
    var leftChild: Node?
    var rightChild: Node?
    var parent: Node?
    var balance: Int = 0  //we want the difference between the heights of the left and right subtrees to be at most 1 (i.e. ensure that "balance" = abs(height(left) - height(right)) <= 1)
    
    init(data: T) {
        self.data = data
    }
    
    private func traverseNode() {
        if let _ = leftChild {
            leftChild?.traverseNode()
        }
        
        print("\(data)")
        
        if let _ = rightChild {
            rightChild?.traverseNode()
        }
    }
}

class QueueNode<T: Comparable> {  //single linked list (saves on memory; we only care about one direction since we are implementing a queue that processes FIFO)
    
    var node: Node<T>
    var nextNode: QueueNode?
    
    init(node: Node<T>) {
        self.node = node
    }
}

class Queue<T: Comparable> {  // unidirectional linked list implementation
    
    private var start: QueueNode<T>?
    private var end: QueueNode<T>?
    private var count = 0
    
    func enqueue(node: QueueNode<T>) {
        if start == nil {
            start = node
            end = node
        } else {
            end?.nextNode = node
            end = node
        }
        
        count += 1
    }
    
    func dequeue() -> QueueNode<T>? {
        if start == nil {
            print("no node objects in queue")
            return nil
        }
        
        count -= 1
        
        let nodeToReturn = start
        start = nodeToReturn?.nextNode
        
        return nodeToReturn
    }
    
    func getCount() -> Int {
        return count
    }
    
    func printQueue() -> String {
        var queueAsString = ""
        if start == nil {
            return queueAsString
        }
        
        var node = start
        
        while node != nil {
            if let data = node?.node.data {
                queueAsString += "\(data) "
            }
            node = node?.nextNode
        }
        return queueAsString
    }

}

class BalancedTree<T: Comparable> {
    
    private var root: Node<T>?
    private var minNode: Node<T>?
    private var size: Int = 0
    
    func insertData(dataToInsert: T) {
        
        let newNode = Node(data: dataToInsert)
        
        if let root = root {
            print("root = \(root.data)")
            insertNodeIntoTree(newNode, currentNode: root)
        } else {
            root = newNode
            size += 1
        }
    }
    
    private func insertNodeIntoTree(nodeToInsert: Node<T>, currentNode: Node<T>) {
        
        print("INSERTING \(nodeToInsert.data), at \(currentNode.data)")

        if nodeToInsert.data < currentNode.data { //if the value is less than current value, then check left child...
            if let leftchild = currentNode.leftChild {  //if there is a left child already...
                insertNodeIntoTree(nodeToInsert, currentNode: leftchild) //then make recursive call with the left child as the current node
            } else {
                currentNode.leftChild = nodeToInsert  //if there isn't a left child already, then set left child to the node to insert
                nodeToInsert.parent = currentNode
                print("inserted left child of \(currentNode.data)")
                size += 1
                if let parent = currentNode.parent {
                    rebalanceTree(parent)
                }
            }
        } else if nodeToInsert.data > currentNode.data {  //if the value is greater than current value, then check right child...
            if let rightChild = currentNode.rightChild {  //if there is a right child already...
                insertNodeIntoTree(nodeToInsert, currentNode: rightChild)  //then make recursive call with the right child as the current node
            } else {
                currentNode.rightChild = nodeToInsert  //if there isn't a right child already, then set right child to the node to insert
                nodeToInsert.parent = currentNode
                print("inserted right child of \(currentNode.data)")
                size += 1
                if let parent = currentNode.parent {
                    rebalanceTree(parent)
                }
            }
            
        } else {  //node's value equal's current value
            print("this value has already been added so no new node has been created")
        }
        print("")
    }
    
    //we want to maintain balance at every node such that the absolute value of the balance value is no greater than 1; if balance ever gets less than -1 or greater than 1, there will need to be rotation left or right to maintain the balance; balance of any node is determined by comparing the height of its left child to the height of its right child and if the difference between the heights of the left and right subtrees differs by MORE THAN ONE, then rebalancing is required
    private func rebalanceTree(nodeToRebalance: Node<T>) {
        print("rebalancing \(nodeToRebalance.data)")
        calculateBalanceFor(nodeToRebalance)
        
        if nodeToRebalance.balance < -1 {  //becoming right unbalanced
            
            print("UNBALANCED: RIGHT HEAVY")
            if getHeightOfSubtreeOf(nodeToRebalance.rightChild?.rightChild) > getHeightOfSubtreeOf(nodeToRebalance.rightChild?.leftChild) {  //the "doubly right" heavy case
                print("need to rotate \(nodeToRebalance.data) LEFT")
                rotateLeft(nodeToRebalance)
            } else {  //the right-left right heavy case
                print("need to rotate \(nodeToRebalance.rightChild?.data) RIGHT and then \(nodeToRebalance.data) LEFT")
                rotateRight(nodeToRebalance.rightChild)
                rotateLeft(nodeToRebalance)
            }
            
        } else if nodeToRebalance.balance > 1 {  //becoming left unbalanced
            
            print("UNBALANCED: LEFT HEAVY")
            if getHeightOfSubtreeOf(nodeToRebalance.leftChild?.leftChild) > getHeightOfSubtreeOf(nodeToRebalance.leftChild?.rightChild) {  //the "doubly left" heavy case
                print("need to rotate \(nodeToRebalance.data) RIGHT")
                rotateRight(nodeToRebalance)
            } else {  //the left-right left heavy case
                print("need to rotate \(nodeToRebalance.leftChild?.data) LEFT and then \(nodeToRebalance.data) RIGHT")
                rotateLeft(nodeToRebalance.leftChild)
                rotateRight(nodeToRebalance)
            }
            
        } else {
            print("\(nodeToRebalance.data) is balanced with balance = \(nodeToRebalance.balance)")
        }
        
        if let parent = nodeToRebalance.parent {
            rebalanceTree(parent)
        }
    }
    
    //finds the heights of each subtree and determines balance value by: left subtree height - right subtree height
    private func calculateBalanceFor(node: Node<T>) {
        let leftHeight = getHeightOfSubtreeOf(node.leftChild)
        let rightHeight = getHeightOfSubtreeOf(node.rightChild)
        node.balance = leftHeight - rightHeight
        print(node.data, "left subtree = \(leftHeight)", "right subtree = \(rightHeight)", "balance = \(node.balance)")
    }
    
    private func getHeightOfSubtreeOf(node: Node<T>?) -> Int {
        if let node = node {
            let maxChildHeight = max(getHeightOfSubtreeOf(node.leftChild), getHeightOfSubtreeOf(node.rightChild))
            let subtreeHeight = maxChildHeight + 1
            return subtreeHeight
        } else {
            return -1  // height value for when a child does not exist for a specific node
        }
    }
    
    func deleteValue(valueToDelete: T) {
        
        //consider THREE cases:  when node has NO children, when node has one child, and when node has two children
        
        //case 1: no children:  simply remove the node
        //case 2: one child:  set child's parent node to the node-to-delete's parent node (the child's grandparent), then remove the node
        //case 3: two children:  swap node-to-delete with its predecessor or successor, then call the delete function on the node-to-delete recursivley until it has been swapped into a position where it is either case 1 or 2, and then do the required actions
        
        //KEEP IN MIND: height!
        
        if let nodeToDelete = searchForValue(valueToDelete) {
            print("found a node to delete")
            deleteNode(nodeToDelete)
        } else {
            print("did not find a node to delete")
        }
        
    }
    
    private func deleteNode(nodeToDelete: Node<T>) {
        //TODO  implement delete
    }
    
    //public method that returns the left most (minimum) node
    func getMinNode() -> Node<T>? {
        return findMin(root)
    }
    
    //private recursive method that determines the minimum node for returning
    private func findMin(currentNode: Node<T>?) -> Node<T>? {
        if currentNode == nil {
            return nil
        }
        if let leftChild = currentNode?.leftChild {
            return findMin(leftChild)
        } else {
            return currentNode
        }
    }
    
    //public method that returns the right most (maximum) node
    func getMaxValue() -> Node<T>? {
        return findMax(root)
    }
    
    //private recursive method that determines the maximum node for returning
    private func findMax(currentNode: Node<T>?) -> Node<T>? {
        if currentNode == nil {
            return nil
        }
        if let rightChild = currentNode?.rightChild {
            return findMax(rightChild)
        } else {
            return currentNode
        }
    }
    
    private func rotateLeft(nodeToRotate: Node<T>?) {
        
        //when rotating a node LEFT:
        //1.  node's original parent's RIGHT child is now the node's RIGHT child
        //2.  node's RIGHT child becomes the node's parent and the node becomes that child's (now the parent) LEFT child
        //3.  node's RIGHT child's LEFT child becomes the node's RIGHT child
        
        //1.
        if nodeToRotate?.parent == nil {  //if parent == nil, then we are rotating the root, which means the root needs to be updated to the new node
            root = nodeToRotate?.rightChild
            root?.parent = nil
        } else {
            if nodeToRotate === nodeToRotate?.parent?.rightChild {  //the node being rotated is the right child of its parent (i.e. as part of a single left rotation)
                nodeToRotate?.parent?.rightChild = nodeToRotate?.rightChild
            } else {  //the node being rotated is the left child of its parent (i.e. as part of a double rotation)
                nodeToRotate?.parent?.leftChild = nodeToRotate?.rightChild
            }
            nodeToRotate?.rightChild?.parent = nodeToRotate?.parent
        }
        
        let tempChildToMove = nodeToRotate?.rightChild?.leftChild
        
        //2.
        nodeToRotate?.parent = nodeToRotate?.rightChild
        nodeToRotate?.rightChild?.leftChild = nodeToRotate
        //3.
        nodeToRotate?.rightChild = tempChildToMove
        tempChildToMove?.parent = nodeToRotate
    }
    
    private func rotateRight(nodeToRotate: Node<T>?) {
        
        //when rotating a node RIGHT:
        //1.  node's original parent's LEFT child is now the node's LEFT child
        //2.  node's LEFT child becomes the node's parent and the node becomes that child's (now the parent) RIGHT child
        //3.  node's LEFT child's RIGHT child becomes the node's LEFT child
        
        //1.
        if nodeToRotate?.parent == nil {  //if parent == nil, then we are rotating the root, which means the root needs to be updated to the new node
            root = nodeToRotate?.leftChild
            root?.parent = nil
        } else {
            if nodeToRotate === nodeToRotate?.parent?.leftChild {  //the node being rotated is the left child of its parent (i.e. as part of a single right rotation)
                nodeToRotate?.parent?.leftChild = nodeToRotate?.leftChild
            } else {  //the node being rotated is the right child of its parent (i.e. as part of a double rotation)
                nodeToRotate?.parent?.rightChild = nodeToRotate?.leftChild
            }
            nodeToRotate?.leftChild?.parent = nodeToRotate?.parent
        }
        
        let tempChildToMove = nodeToRotate?.leftChild?.rightChild
        
        //2.
        nodeToRotate?.parent = nodeToRotate?.leftChild
        nodeToRotate?.leftChild?.rightChild = nodeToRotate
        //3.
        nodeToRotate?.leftChild = tempChildToMove
        tempChildToMove?.parent = nodeToRotate
    }
    
    func traverseTreeInOrder() {  //starting with the minimum value, visit its root, then its root's right substree, which may contain another tree, so we do this recursively (i.e. when a right node contains another tree, then visit left, root, right, etc.); work our way up the the entire tree's root, then down the right side in a similar way (left, root, right in recursive manner)
        if let root = root {
            root.traverseNode()
        } else {
            print("no nodes to traverse!")
        }
    }
    
    func breadthFirstSearch() {
        
        let queue = Queue<T>()
        
        guard let startingNode = root else {
            print("no nodes on which to perform a BFS")
            return
        }
        
        queue.enqueue(QueueNode(node: startingNode))
        
        var nodeBeingProcessed: Node<T>? = startingNode
        
        while nodeBeingProcessed != nil {
            nodeBeingProcessed = queue.dequeue()?.node
            print("processing \(nodeBeingProcessed?.data)")
            if let leftChild = nodeBeingProcessed?.leftChild {
                queue.enqueue(QueueNode(node: leftChild))
            }
            if let rightChild = nodeBeingProcessed?.rightChild {
                queue.enqueue(QueueNode(node: rightChild))
            }
            print(queue.printQueue())
        }
    }
    
    func searchForValue(valueToFind: T) -> Node<T>? {
        return searchTree(valueToFind, currentNode: root)
    }
    
    private func searchTree(valueToFind: T, currentNode: Node<T>?) -> Node<T>? {
     
        if currentNode == nil {
            print("value not found")
            return nil
        }
        
        if valueToFind > currentNode?.data {
            return searchTree(valueToFind, currentNode: currentNode?.rightChild)
        } else if valueToFind < currentNode?.data {
            return searchTree(valueToFind, currentNode: currentNode?.leftChild)
        } else {
            print("found!")
            return currentNode
        }
    }
    
    func getTreeSize() -> Int {
        return size
    }
}

//let myTree = BalancedTree<String>()

//TRIAL 1
//myTree.insertData("matt")
//myTree.insertData("sam")
//myTree.insertData("john")
//myTree.insertData("jesse")
//myTree.insertData("paul")
//myTree.insertData("joel")

//myTree.insertData("jimmy")
//myTree.insertData("adam")

//TRIAL 2
//myTree.insertData("matt")
//myTree.insertData("aaron")
//myTree.insertData("clark")

//myTree.insertData("matt")
//myTree.insertData("clark")
//myTree.insertData("aaron")

//myTree.traverseTreeInOrder()

let myTree2 = BalancedTree<Int>()

//WORKING RIGHT ROTATION: variation 1
//myTree2.insertData(10)
//myTree2.insertData(11)
//myTree2.insertData(5)
//myTree2.insertData(4)
//myTree2.insertData(7)
//myTree2.insertData(3)
//myTree2.insertData(1)

//WORKING RIGHT ROATION: variation 2
//myTree2.insertData(3)
//myTree2.insertData(2)
//myTree2.insertData(1)

//WORKING RIGHT ROATION: variation 3  FIXED!
//myTree2.insertData(3)
//myTree2.insertData(5)
//myTree2.insertData(4)

//from PDF:  https://jriera.webs.ull.es/Docencia/avl_handout.pdf
myTree2.insertData(3)
myTree2.insertData(2)
myTree2.insertData(1)
myTree2.insertData(4)
myTree2.insertData(5)
myTree2.insertData(6)
myTree2.insertData(7)
myTree2.insertData(16)
myTree2.insertData(15)
myTree2.insertData(14)

myTree2.traverseTreeInOrder()
myTree2.root?.data
myTree2.root?.leftChild?.data
myTree2.root?.leftChild?.leftChild?.data
myTree2.root?.leftChild?.rightChild?.data
myTree2.root?.rightChild?.data
myTree2.root?.rightChild?.leftChild?.data
myTree2.root?.rightChild?.leftChild?.leftChild?.data
myTree2.root?.rightChild?.rightChild?.data
myTree2.root?.rightChild?.rightChild?.leftChild?.data
myTree2.root?.rightChild?.rightChild?.rightChild?.data

myTree2.getMinNode()?.data
myTree2.getMaxValue()?.data
myTree2.searchForValue(6)?.data
myTree2.searchForValue(10)?.data
myTree2.searchForValue(1)?.data
myTree2.searchForValue(16)?.data
myTree2.searchForValue(0)?.data
myTree2.searchForValue(9)?.data
myTree2.searchForValue(230)?.data
myTree2.getTreeSize()

myTree2.breadthFirstSearch()