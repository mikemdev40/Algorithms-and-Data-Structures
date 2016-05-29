//: [Previous](@previous)

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

