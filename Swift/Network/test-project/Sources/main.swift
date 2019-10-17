/*--------------------------------------------------------------------------------------------------------------
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
 *-------------------------------------------------------------------------------------------------------------*/
import Foundation
struct FailableDecodable<Base : Decodable> : Decodable {

    let base: Base?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.base = try? container.decode(Base.self)
    }
}
struct FailableCodableArray<Element : Codable> : Codable {

    var elements: [Element]

    init(from decoder: Decoder) throws {

        var container = try decoder.unkeyedContainer()

        var elements = [Element]()
        if let count = container.count {
            elements.reserveCapacity(count)
        }

        while !container.isAtEnd {
            if let element = try container
                .decode(FailableDecodable<Element>.self).base {

                elements.append(element)
            }
        }

        self.elements = elements
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(elements)
    }
}
extension Date{
    func printDiff() {
        let microseconds = Date().long - self.long
        let miniseconds = microseconds / 1000
        let seconds = miniseconds / 1000
        print("Seconds: \(seconds)")
        print("miniseconds: \(miniseconds)")
        print("microseconds: \(miniseconds)")
    }
    var long:Int64{//microseconds
        get {
            let long = self.timeIntervalSince1970
            let result = Int64(long) * 1000 + Int64(long.truncatingRemainder(dividingBy: 1.0) * 1000.0)
            return result
        }
    }
    var timeIntervalSince1970Long:Int64{
        get {
            let long = self.timeIntervalSince1970
            let result = Int64(long) * 1000 + Int64(long.truncatingRemainder(dividingBy: 1.0) * 1000.0)
            return result
        }
    }
}



func StringFromFile(path:String)-> String?{
    var text:String? = nil
    let fm = FileManager.default
    let currentDirectoryPath = FileManager.default.currentDirectoryPath
    print(currentDirectoryPath)
    print("Hello:")
    let dir = URL.init(fileURLWithPath: currentDirectoryPath)
    
    let fileURL = dir.appendingPathComponent(path)
    print(fileURL)
    //reading
    do {
        text = try String(contentsOf: fileURL, encoding: .utf8)
    }
    catch {/* error handling here */}

    return text
}
func StringToFile(path:String,content:String){
    let currentDirectoryPath = FileManager.default.currentDirectoryPath
    let dir = URL.init(fileURLWithPath: currentDirectoryPath)
    let fileURL = dir.appendingPathComponent(path)
        //writing
    do {
        try content.write(to: fileURL, atomically: false, encoding: .utf8)
    }
    catch {/* error handling here */}

     

}

class Sorts{
    func BubbleSort( array:inout [Int])->[Int]{
        for i in 0..<array.count {
          for j in 1..<array.count {
            if array[j] < array[j-1] {
              let tmp = array[j-1]
              array[j-1] = array[j]
              array[j] = tmp
            }
          }
        }
        return array
    }
}
class QuickSort {
    func swap<T: Comparable>(leftValue: inout T, rightValue: inout T) {
        (leftValue, rightValue) = (rightValue, leftValue)
    }

    func partition<T: Comparable>(array: inout [T], startIndex: Int, endIndex: Int) -> Int {
        var q = startIndex
        for index in startIndex..<endIndex {
            if array[index] < array[endIndex] {
                array.swapAt(q, index)
                //swap(leftValue: &array[q], rightValue: &array[index])
                q += 1
            }
        }
        array.swapAt(q, endIndex)
        
        //swap(leftValue: &array[q], rightValue: &array[endIndex])
        
        return q
    }

    func quickSort<T: Comparable>(array: inout [T], startIndex: Int, endIndex: Int) {
        // Base case
        if startIndex >= endIndex {
            return
        }
        let placedItemIndex = partition(array: &array, startIndex: startIndex, endIndex: endIndex)
        quickSort(array: &array, startIndex: startIndex, endIndex: placedItemIndex-1)
        quickSort(array: &array, startIndex: placedItemIndex+1, endIndex: endIndex)
    }

    func quickSort<T: Comparable>(array: inout [T]) {
        quickSort(array: &array, startIndex: 0, endIndex: array.count-1)
    }
}
class HeapSort{
    func heapsort<T:Comparable>( list:inout [T]) {
        var count = list.count
     
        func shiftDown( list:inout [T], start:Int, end:Int) {
            var root = start
     
            while root * 2 + 1 <= end {
                let child = root * 2 + 1
                var swap = root
     
                if list[swap] < list[child] {
                    swap = child
                }
     
                if child + 1 <= end && list[swap] < list[child + 1] {
                    swap = child + 1
                }
     
                if swap == root {
                    return
                } else {
                    (list[root], list[swap]) = (list[swap], list[root])
                    root = swap
                }
            }
        }
     
        func heapify( list:inout [T], count:Int) {
            var start = (count - 2) / 2
     
            while start >= 0 {
                shiftDown(list: &list, start: start, end: count - 1)
     
                start-=1
            }
        }
     
        heapify(list: &list, count: count)
     
        var end = count - 1
     
        while end > 0 {
            (list[end], list[0]) = (list[0], list[end])
     
            end-=1
     
            shiftDown(list: &list, start: 0, end: end)
        }
    }
}
func main() {
    let text = StringFromFile(path:"./input.json")
    let products = JSONDecoder()
    .decode(FailableCodableArray<Int>.self, from: text)
    .elements
    print(products)
    StringToFile(path:"./output.json",content: text as! String)
    print(text)
    
    
}

main();