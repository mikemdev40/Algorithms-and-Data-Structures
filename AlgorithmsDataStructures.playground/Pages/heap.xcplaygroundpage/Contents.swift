
//reading Data Structures and Algorithms by Barnett & Del Tongo
//CHAPTER ON HEAPS

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
            print("inserting \(heapItems[Int(childIndex)])")

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
        if let indexFound = searchHeapFor(valueToRemove) {
            
            let lastIndex = count - 1
            var index = indexFound
            
            heapItems[index] = heapItems[lastIndex]
            
            while (2 * index + 1) < lastIndex && (heapItems[index] > heapItems[2 * index + 1] || heapItems[index] > heapItems [2 * index + 2]) {
                if heapItems[2 * index + 1] < heapItems[2 * index + 2] {
                    swap(&heapItems[index], &heapItems[2 * index + 1])
                    index = 2 * index + 1
                } else {
                    swap(&heapItems[index], &heapItems[2 * index + 2])
                    index = 2 * index + 2
                }
            }
            
            heapItems.removeLast()
            print(heapItems)
        } else {
            print("CANNOT DELETE: value not found")
        }
    }
    
    func searchHeapFor(valueToSearchFor: T) -> Int? {  //returns the index of the value; nil if the value isn't in the heap
        if count > 1 {
            var counter = 0
            if heapItems[counter] == valueToSearchFor {
                print("found at the first index")
                return counter
            }
            while heapItems[counter] != valueToSearchFor && counter < (count - 1) {  //the counter < (count - 1) prevents the count from going too high and creating an out of bounds error
                counter += 1
                if heapItems[counter] == valueToSearchFor {
                    print("found at index \(counter)")
                    return counter
                }
            }
            print("did not find")
            return nil
        } else {
            print("no elements in the heap")
            return nil
        }
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
myHeap.searchHeapFor(10)
myHeap.searchHeapFor(0)
myHeap.searchHeapFor(5)
myHeap.searchHeapFor(6)

let myHeap2 = MinHeap<Int>()
myHeap2.addHeapItem(1)
myHeap2.addHeapItem(5)
myHeap2.addHeapItem(6)
myHeap2.addHeapItem(10)
myHeap2.addHeapItem(15)
myHeap2.addHeapItem(12)
myHeap2.addHeapItem(18)
myHeap2.addHeapItem(20)
myHeap2.addHeapItem(40)
myHeap2.addHeapItem(30)
myHeap2.addHeapItem(50)
myHeap2.addHeapItem(24)
myHeap2.addHeapItem(36)
myHeap2.addHeapItem(40)
myHeap2.addHeapItem(100)
myHeap2.addHeapItem(21)
myHeap2.addHeapItem(22)
print(myHeap2.heapItems)
myHeap2.removeHeapItem(6)
myHeap2.removeHeapItem(5)
