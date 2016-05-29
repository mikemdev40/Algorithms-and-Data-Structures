//: Mike Miller
// Working through book by Wayne Bishop: "Swift Algorithms and Data Structures"  http://waynewbishop.com/swift/big-o-notation

import Foundation

extension Array {
    
    func minIndex() -> Index {
        return self.startIndex
    }
    
    func maxIndex() -> Index {
        return self.endIndex.advancedBy(-1)
    }
    
    func middleIndex() -> Index {
        let count = self.count
        if count % 2 == 0 {
            return (count / 2) - 1  //arbitrarily -1 rather than +1
        } else {
            return (count - 1) / 2
        }
    }
}

var counter = 0

func binarySearch(keyToSearchFor: Int, arrayToSearch: [Int]) {
    
    counter += 1  //for fun: to keep track of how many calls it takes!

    let min = arrayToSearch.minIndex()
    let mid = arrayToSearch.middleIndex()
    let max = arrayToSearch.maxIndex()
    
    if keyToSearchFor > arrayToSearch[max] || keyToSearchFor < arrayToSearch[min] {
        print("out of bounds")
    }
    
    let numberToCheck = arrayToSearch[mid]
    
    if keyToSearchFor < numberToCheck {
        let lowerHalf = Array(arrayToSearch[min...(mid - 1)])
        print(lowerHalf)
        binarySearch(keyToSearchFor, arrayToSearch: lowerHalf)
    } else if keyToSearchFor > numberToCheck {
        let upperHalf = Array(arrayToSearch[(mid + 1)...max])
        print(upperHalf)
        binarySearch(keyToSearchFor, arrayToSearch: upperHalf)
    } else {
        print("found at index \(mid) after \(counter) runs")
    }
}


var sortedArray = [2, 8, 11, 21, 37, 38, 51, 78, 90, 103, 105, 156, 230, 310, 315, 320, 510]
sortedArray.count

sortedArray.minIndex()
sortedArray.maxIndex()
sortedArray.middleIndex()

binarySearch(37, arrayToSearch: sortedArray)
