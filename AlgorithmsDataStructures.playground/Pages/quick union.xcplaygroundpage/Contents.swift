//: Mike Miller
//: Working through https://www.coursera.org/course/algs4partI
//: Algorithms I, Princeton University (Coursera)

//QUICK UNION

import Foundation

var id = [Int]()

func quickUnion(numberOfItems: Int) {
    
    for count in 0..<numberOfItems {
        id.append(count)
    }
    
}

func findRoot(i: Int) -> Int {
    var j = i
    while id[j] != j {  //chasing parent pointers
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
    id[rootp] = rootq
    print(id)
}

quickUnion(10)
union(4, q: 3)
union(3, q: 8)
union(6, q: 5)
union(9, q: 4)
union(2, q: 1)
connected(1, q: 7)
union(5, q: 0)
connected(1, q: 7)
union(7, q: 2)
connected(1, q: 7)
union(6, q: 1)
union(7, q: 3)

findRoot(6)



