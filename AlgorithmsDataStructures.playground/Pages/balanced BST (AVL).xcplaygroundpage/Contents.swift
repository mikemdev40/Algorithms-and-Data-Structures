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

class BalancedTree<T: Comparable> {
    
    private var root: Node<T>?
    
    func insertData(dataToInsert: T) {
        
        print("INSERTING \(dataToInsert)")
        let newNode = Node(data: dataToInsert)
        
        if let root = root {
            insertNodeIntoTree(newNode, currentNode: root)
        } else {
            root = newNode
        }
    }
    
    private func insertNodeIntoTree(nodeToInsert: Node<T>, currentNode: Node<T>) {
        
        if nodeToInsert.data < currentNode.data { //if the value is less than current value, then check left child...
            if let leftchild = currentNode.leftChild {  //if there is a left child already...
                insertNodeIntoTree(nodeToInsert, currentNode: leftchild) //then make recursive call with the left child as the current node
            } else {
                currentNode.leftChild = nodeToInsert  //if there isn't a left child already, then set left child to the node to insert
                nodeToInsert.parent = currentNode
            }
            
            if let parent = currentNode.parent {
                rebalanceTree(parent)
            }
            
        } else if nodeToInsert.data > currentNode.data {  //if the value is greater than current value, then check right child...
            if let rightChild = currentNode.rightChild {  //if there is a right child already...
                insertNodeIntoTree(nodeToInsert, currentNode: rightChild)  //then make recursive call with the right child as the current node
            } else {
                currentNode.rightChild = nodeToInsert  //if there isn't a right child already, then set right child to the node to insert
                nodeToInsert.parent = currentNode
            }
            
            if let parent = currentNode.parent {
                rebalanceTree(parent)
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
            findMin(leftChild)
        }
        return currentNode
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
            findMin(rightChild)
        }
        return currentNode
    }
    
    private func rotateLeft(nodeToRotate: Node<T>?) {
        
        //when rotating a node LEFT:
        //1.  node's RIGHT child becomes the node's parent
        //2.  node becomes that child's (now the parent) LEFT child
        //3.  node's RIGHT child's LEFT child becomes the node's RIGHT child
        
        if nodeToRotate?.parent == nil {  //if parent == nil, then we are rotating the root, which means the root needs to be updated to the new node
            root = nodeToRotate?.rightChild
            root?.parent = nil
        }
        
        let tempChildToMove = nodeToRotate?.rightChild?.leftChild
        
        nodeToRotate?.parent = nodeToRotate?.rightChild
        nodeToRotate?.rightChild?.leftChild = nodeToRotate
        nodeToRotate?.rightChild = tempChildToMove

    }
    
    private func rotateRight(nodeToRotate: Node<T>?) {
        
        //when rotating a node RIGHT:
        //1.  node's LEFT child becomes the node's parent
        //2.  node becomes that child's (now the parent) RIGHT child
        //3.  node's LEFT child's RIGHT child becomes the node's LEFT child
        
        if nodeToRotate?.parent == nil {  //if parent == nil, then we are rotating the root, which means the root needs to be updated to the new node
            root = nodeToRotate?.leftChild
            root?.parent = nil
        }
        
        let tempChildToMove = nodeToRotate?.leftChild?.rightChild
        
        nodeToRotate?.parent = nodeToRotate?.leftChild
        nodeToRotate?.leftChild?.rightChild = nodeToRotate
        nodeToRotate?.leftChild = tempChildToMove
    }
    
    func traverseTreeInOrder() {  //starting with the minimum value, visit its root, then its root's right substree, which may contain another tree, so we do this recursively (i.e. when a right node contains another tree, then visit left, root, right, etc.); work our way up the the entire tree's root, then down the right side in a similar way (left, root, right in recursive manner)
        if let root = root {
            root.traverseNode()
        } else {
            print("no nodes to traverse!")
        }
    }
    
    func searchForValue(valueToFind: T) {
        
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

//myTree2.insertData(2)
//myTree2.insertData(1)
//myTree2.insertData(4)
//myTree2.insertData(3)
//myTree2.insertData(5)
//myTree2.insertData(6)

//myTree2.insertData(4)
//myTree2.insertData(2)
//myTree2.insertData(1)
//myTree2.insertData(3)
//myTree2.insertData(6)
//myTree2.insertData(5)
//myTree2.insertData(15)
//myTree2.insertData(7)
//myTree2.insertData(14)
//myTree2.insertData(16)

myTree2.insertData(3)
myTree2.insertData(2)
myTree2.insertData(1)
myTree2.insertData(4)
myTree2.insertData(5)

myTree2.traverseTreeInOrder()