/*--------------------------------------------------------------------------------------------------------------
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
 *-------------------------------------------------------------------------------------------------------------*/

class Item {
    let item = 5
}
func swap<T: Comparable>(leftValue: inout T, rightValue: inout T) {
    (leftValue, rightValue) = (rightValue, leftValue)
}

func partition<T: Comparable>(array: inout [T], startIndex: Int, endIndex: Int) -> Int {
    var q = startIndex
    for index in startIndex..<endIndex {
        if array[index] < array[endIndex] {
            swap(leftValue: &array[q], rightValue: &array[index])
            q += 1
        }
    }
    swap(leftValue: &array[q], rightValue: &array[endIndex])
    
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


func bubble_sort(array:inout [Int]) {
    for i in 0..<array.count {
        for j in 1..<array.count - i {
            if array[j] < array[j-1] {
                let tmp = array[j-1]
                array[j-1] = array[j]
                array[j] = tmp
            }
        }
    }
}
func main() {
    let item = Item()
    let msg = "Hello, remote world!";
    print(msg);
    print(item);
}

main();