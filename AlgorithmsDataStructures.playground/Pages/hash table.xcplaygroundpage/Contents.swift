
import Foundation

class HashTableNode <T: Comparable> {
    
    var key: String
    var value: T
    var nextHashNode: HashTableNode?
    
    init (key: String, value: T) {
        self.key = key
        self.value = value
    }
}

class HashTable <T: Comparable> {
    
    var arrayOfValues: [HashTableNode<T>?]
    var arrayLength: Int
    
    private func saveItemToArray(item: HashTableNode<T>, withHashValue hashValue: Int) -> (success: Bool, message: String?) {
        
        let index = hashValue % arrayLength
        print(index)
        
        if arrayOfValues[index] == nil {
            arrayOfValues[index] = item
            return (true, "item first item saved at index \(index)")
        } else {
            
            //check if first node contains key, if so OVERWRITE It; else, cycle through and check each one's key, and if key does not exist, save to end of list
            var currentNode = arrayOfValues[index]
            
            while currentNode != nil {
                if currentNode?.key == item.key {
                    currentNode?.value = item.value
                    return (true, "item already existed and value has been updated")
                } else {
                    if currentNode?.nextHashNode != nil {
                        currentNode = currentNode?.nextHashNode
                    } else {
                        currentNode?.nextHashNode = item
                        return (true, "item added on to linked list at index \(index)")
                    }
                    print("next...")
                }
            }
        }
        return (false, "an error occurred")
    }
    
    private func convertHashKeyToIndex(keyToHash: String) -> Int {
        var hashedSum = 0
        
        //as per https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/StringsAndCharacters.html
        for codeUnit in keyToHash.utf8 {
            hashedSum += Int(codeUnit)
        }
        return hashedSum
    }
    
    func getItem(itemToFind: HashTableNode<T>) -> (T?, Int?) {
        
        
        //FILL THIS OUT
        
        
        return (nil, nil)
    }
    
    func saveItem(itemToSave: HashTableNode<T>) {
        
        let hashValue = convertHashKeyToIndex(itemToSave.key)
        let (success, message) = saveItemToArray(itemToSave, withHashValue: hashValue)

        if success {
            print(message)
        } else {
            print("ERROR")
        }
    }
    
    func deleteItem(keyToDelete: String) {
        
        //search for a STRING (i.e. a node's key) and either remove it's node if it exists, or return nil
    }
    
    init (arrayLength: Int) {
        self.arrayLength = arrayLength
        arrayOfValues = [HashTableNode<T>?](count: arrayLength, repeatedValue: nil)
    }
}

let hash = HashTable<String>(arrayLength: 7)

hash.arrayOfValues.capacity
hash.saveItem(HashTableNode(key: "mike", value: "loop"))
hash.saveItem(HashTableNode(key: "mike", value: "brian"))
hash.saveItem(HashTableNode(key: "ekim", value: "proud"))
hash.saveItem(HashTableNode(key: "jesse", value: "bran"))
hash.saveItem(HashTableNode(key: "eimk", value: "shower"))

print(hash.arrayOfValues)
print(hash.arrayOfValues[2]?.key, " ", hash.arrayOfValues[2]?.value)
print(hash.arrayOfValues[2]?.nextHashNode?.key, " ", hash.arrayOfValues[2]?.nextHashNode?.value)
print(hash.arrayOfValues[2]?.nextHashNode?.nextHashNode?.key, " ", hash.arrayOfValues[2]?.nextHashNode?.nextHashNode?.value)
