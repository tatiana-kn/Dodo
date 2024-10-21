//
//  AddressRepository.swift
//  Dodo
//
//  Created by Tia M on 10/21/24.
//

import Foundation

struct Address: Codable {
    let country: String
    let administrativeArea: String // город
//    let locality: String
    let name: String
//    let subAdministrativeArea: String // ??
    let subLocality: String // район
    let thoroughfare: String // улица
    let subThoroughfare: String // номер дома
    
    var floor: Int
    var apartment: Int
    
    var fullAddress: String {
        country + administrativeArea + thoroughfare + subThoroughfare
    }
}

extension Address: Equatable {
    static func == (lhs: Address, rhs: Address) -> Bool {
        lhs.country == rhs.country &&
        lhs.administrativeArea == rhs.administrativeArea &&
        lhs.thoroughfare == rhs.thoroughfare &&
        lhs.subThoroughfare == rhs.subThoroughfare
    }
}

protocol IAddressRepository {
    func retrieve() -> [Address] //закдалываем их массивом
    func add(_ address: Address)
    func update(_ address: Address)
    func delete(_ address: Address)
}

final class AddressRepository: IAddressRepository {
    
    private let encoder = JSONEncoder() //кодирует в бинарник
    private let decoder = JSONDecoder() //разкодирует
    
    private let key = "Address"
    
    //MARK: - Public methods
    private func save(_ address: [Address]) { //метод сохранить
        
        //Array<Product> -> Data
        //массив кладем в бинарник и кодируем, бинарник кладем в UserDefaults
        do {
            let data = try encoder.encode(address)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    //retrieve - получить данные
    func retrieve() -> [Address] {  //метод получить
        
        //Data -> Array<Product>
        //вытаскиваем из UserDefaults бинарник
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            //раскодировали бинарник в массив
            let array = try decoder.decode(Array<Address>.self, from: data)
            return array
        } catch {
            print(error)
        }
        return []
    }
    
    func add(_ address: Address) {
        var array = retrieve()
        
        for item in array {
            if item == address {
                update(item)
            } else {
                array.append(address)
            }
        }
        save(array)
        print(array)
    }
    
    func update(_ address: Address) {
        var array = retrieve()
        
        if let index = array.firstIndex(where: { $0 == address }) {
            array[index].floor = address.floor
            array[index].apartment = address.apartment
        }
        save(array)
        print(array)
    }
    
    func delete(_ address: Address) {
        var array = retrieve()
 
        array.removeAll { $0 == address }
        save(array)
        print(array)
    }
    

}
