/*--------------------------------------------------------------------------------------------------------------
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
 *-------------------------------------------------------------------------------------------------------------*/
import Foundation
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
    func serialize(_ person:Person) -> String? {
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
    func deserealize(_ string:String) -> Person?{
        guard let data = string.data(using: .utf8) else { return nil }
        do{
            let somePerson = try decoder.decode(Person.self, from: data)
            return somePerson
        }catch {
            return nil
        }
    }
 
    
}


func main() {
    let ser = Serialize()
    let person = Person()
    if let log = ser.serialize(person){
        print(log)
        let person2 = ser.deserealize( log)
        print(person2)
    }
    
}

main();