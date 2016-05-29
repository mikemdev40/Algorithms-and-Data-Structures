//: Mike Miller
//: Working through https://www.udemy.com/algorithms-and-data-structures/learn/v4/content
//: Algorithms & Data Structures In Java, Part I (Udemy)

import Foundation

//stack implementation; recursion
func factorial(n: Int) -> Int {
    
    if n == 0 {
        return 1
    } else {
        return n * factorial(n - 1)
    }
}

//factorial(4)
factorial(10)

