//: Mike Miller
//: Working through https://www.coursera.org/course/algs4partI
//: Algorithms I, Princeton University (Coursera)

import Foundation

var id = [Int]()
var size = [Int]()

func weightedQuickUnion(numberOfItems: Int) {
    
    for count in 0..<numberOfItems {
        id.append(count)
        size.append(1)
    }
    
}

func findRoot(i: Int) -> Int {
    var j = i
    while j != id[j] {  //"chasing parent pointers"
        id[j] = id[id[j]]  //single line that adds PATH COMPRESSION; when commented out, there is no path compression
        j = id[j]
    }
    return j
}

func connected(p: Int, q: Int) -> Bool {
    
    return findRoot(p) == findRoot(q)
}

func union(p: Int, q: Int) {
    let rootp = findRoot(p)
    let rootq = findRoot(q)
    
    if rootp == rootq {
        print("equal")
        return
    }
    
    if size[rootp] >= size[rootq] {
        id[rootq] = rootp
        size[rootp] += size[rootq]
    } else {
        id[rootp] = rootq
        size[rootq] += size[rootp]
    }
    print(id, " ", size)
}

weightedQuickUnion(10)
id
size
union(4, q: 3)
union(3, q: 8)
union(6, q: 5)
union(9, q: 4)
union(2, q: 1)
union(5, q: 0)
union(7, q: 2)
union(6, q: 1)
union(7, q: 3)


