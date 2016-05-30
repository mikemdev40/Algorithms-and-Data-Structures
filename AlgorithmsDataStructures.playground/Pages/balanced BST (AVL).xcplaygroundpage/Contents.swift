
import Foundation


class Node<T: Comparable> {
    
    var data: T
    var leftChild: Node?
    var rightChild: Node?
    var parent: Node?
    var height: Int = 0
    
    init(data: T) {
        self.data = data
    }
}

class BalancedTree<T: Comparable> {
    
    private var root: Node<T>?
    
    func insertData(dataToInsert: T) {
        let newNode = Node(data: dataToInsert)
        
        
        
        
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
    
    private func rotateLeft() {
        
    }
    
    private func rotateRight() {
        
    }
    
    func traverseTreeInOrder() {  //starting with the minimum value, visit its root, then its root's right substree, which may contain another tree, so we do this recursively (i.e. when a right node contains another tree, then visit left, root, right, etc.); work our way up the the entire tree's root, then down the right side in a similar way (left, root, right in recursive manner)
        
    }
    
    func searchForValue(valueToFind: T) {
        
    }
}



let myTree = BalancedTree<String>()

myTree.root = Node(data: "mike")

myTree.root?.data

myTree.getMinNode()?.data