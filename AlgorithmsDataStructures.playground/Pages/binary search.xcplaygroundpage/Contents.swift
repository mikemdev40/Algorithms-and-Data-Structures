//Wayne Bishop: Swift Algorithms and Data Structures
//http://waynewbishop.com/swift/big-o-notation

import Foundation

extension Array {
    
    func minIndex() -> Index {
        return self.startIndex
    }
    
    func maxIndex() -> Index {
        return self.endIndex.advancedBy(-1)
    }
}

let array = [8, 1, 2, 3, 4, 5, 6, 7]

array.minIndex()
array.maxIndex()



//: [Next](@next)
