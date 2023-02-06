//
//  App+Injection.swift
//  MovieList
//
//  Created by Pavel Shutkou on 03.02.23.
//

import Resolver
import MovieBrowser

extension Resolver: ResolverRegistering {
  public static func registerAllServices() {
    defaultScope = .graph
    MovieBrowserAssembly().assemble(Resolver.main)
  }
}
