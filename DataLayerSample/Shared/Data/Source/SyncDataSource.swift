//
//  SyncDataSource.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 3/28/22.
//

import Foundation

protocol SyncDataSource: DataSource {
    func registerSyncly(type: String) throws
    func loadDataSyncly(at path: Path) throws -> Data?
    func saveDataSyncly(_ data: Data?, at path: Path) throws
}
