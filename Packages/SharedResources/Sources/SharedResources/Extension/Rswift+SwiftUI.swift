//
//  Rswift+SwiftUI.swift
//  
//
//  Created by Pavel Shutkou on 05.02.23.
//

import Foundation
import SwiftUI
import RswiftResources

// MARK: - ImageResource
public extension ImageResource {
    var image: Image {
        Image(name, bundle: bundle)
    }
}

// MARK: - ColorResource
public extension ColorResource {
    var color: Color {
        Color(name, bundle: bundle)
    }
}
