//
//  Mapper.swift
//  It'sTimeToTravel_TestProject_issidorik
//
//  Created by Илья Сидорик on 16.05.2023.
//

import Foundation

typealias MapperCompletion<T: Decodable> = (Result<T, MapperError>) -> Void

protocol IMapper {
    func decode<T: Decodable>(from data: Data, jsonType: T.Type, completion: @escaping MapperCompletion<T>)
}


final class Mapper {
    
    // MARK: - Private properties
    
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    private let concurrentQueue = DispatchQueue(label: "MapperQueue", qos: .utility)
    
}



    // MARK: - IMapper

extension Mapper: IMapper {
    
    func decode<T>(from data: Data, jsonType: T.Type, completion: @escaping MapperCompletion<T>) where T : Decodable {
        self.concurrentQueue.async {
            do {
                let model = try self.decoder.decode(jsonType, from: data)
                DispatchQueue.main.async {
                    completion(.success(model))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.parse(reason: "Не удалось спарсить данные")))
                }
            }
        }
    }
    
    
}
