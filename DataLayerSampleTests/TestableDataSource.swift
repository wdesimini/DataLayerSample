//
//  TestableDataSource.swift
//  DataLayerSampleTests
//
//  Created by Wilson Desimini on 1/9/22.
//

@testable import DataLayerSample

protocol TestableDataSource: DataSource {
    func reset(type: String) throws
}
