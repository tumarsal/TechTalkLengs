
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
public struct Person: Codable {
  var id: Int
  var name: String
  var phones: [String]
    init(id: Int, name: String, phones: [String]) {
        self.id = id
        self.name = name
        self.phones = phones
    }
    init() {
        self.id = 1
        self.name = "Artur"
        self.phones = ["+793752229746","+79083402783"]
    }
}
class Serialize{
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    init() {
        encoder.keyEncodingStrategy = .convertToSnakeCase
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    func serialize(person:Person) -> String? {
        do{

            let data = try encoder.encode(person)
            // 2
            let string = String(data: data, encoding: .utf8)!
            print(string)
            return string
        }
        catch {
            return nil
        }
    }
    func deserealize(string:String) -> Person?{
        guard let data = string.data(using: .utf8) else { return nil }
        do{
            let somePerson = try decoder.decode(Person.self, from: data)
            return somePerson
        }catch {
            return nil
        }
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
