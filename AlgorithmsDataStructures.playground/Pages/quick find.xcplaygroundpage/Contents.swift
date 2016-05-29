//: Mike Miller
//: Working through https://www.coursera.org/course/algs4partI
//: Algorithms I, Princeton University (Coursera)


//QUICK FIND

import UIKit

var id = [Int]()

func quickFind(numberOfItems: Int) {
    
    for count in 0..<numberOfItems {
        id.append(count)
    }
    
}

func connected(p: Int, q: Int) -> Bool {
    
    return id[p] == id[q]
}

func union(p: Int, q: Int) {
    let pid = id[p]
    let qid = id[q]
    
    for count in 0..<id.count {
        if id[count] == pid {
            id[count] = qid
        }
    }
    
}

quickFind(10)
id
union(3, q: 6)
id
union(2, q: 6)
id
union(7, q: 8)
id
union(8, q: 6)
id
connected(3, q: 5)
connected(3, q: 6)
