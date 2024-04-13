//
//  CoreDataError.swift
//  Besteats
//
//  Created by BH on 2024/04/11.
//

enum CoreDataError: Error {
    case readError(Error)
    case saveError(Error)
    case deleteError(Error)
}
