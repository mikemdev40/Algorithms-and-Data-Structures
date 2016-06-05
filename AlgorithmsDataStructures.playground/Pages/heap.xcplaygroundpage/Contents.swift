
import Foundation


class MinHeap<T: Comparable> {
    
    private var heapItems = [T]()
    
    var count: Int {
        return heapItems.count
    }
    
    func addHeapItem(valueToAdd: T) {
        heapItems.append(valueToAdd)
        
        if count > 1 {
            
            var childIndex = Float(count - 1)
            var parentIndex = floorf((childIndex - 1)/2)
            print(childIndex, heapItems[Int(childIndex)])

            while childIndex != 0 {
                if heapItems[Int(childIndex)] < heapItems[Int(parentIndex)] {
                    swap(&heapItems[Int(childIndex)], &heapItems[Int(parentIndex)])
                    childIndex = parentIndex
                    parentIndex = floorf((parentIndex - 1)/2)
                    print("swapped")
                } else {
                    childIndex = 0
                    print("stopped early")
                }
            }
        } else {
            print("only one element")
        }
    }
    
    func removeHeapItem(valueToRemove: T) {
        
    }
    
}

let myHeap = MinHeap<Int>()

myHeap.addHeapItem(8)
myHeap.addHeapItem(5)
myHeap.addHeapItem(1)
myHeap.addHeapItem(10)
myHeap.addHeapItem(2)
myHeap.addHeapItem(0)
print(myHeap.heapItems)