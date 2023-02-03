//
//  Assembly.swift
//  
//
//  Created by Pavel Shutkou on 03.02.23.
//

import Resolver

public protocol Assembly: AnyObject {
    func assemble(_ resolver: Resolver)
}
