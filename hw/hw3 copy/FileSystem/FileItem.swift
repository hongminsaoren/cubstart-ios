//
//  FileItem.swift
//  FileSystem
//
//  Created by Andy Huang on 1/19/24.
//

import Foundation

// Do not modify
struct FileItem: Hashable, Identifiable {
    var id: UUID = UUID()
    var name: String
    var children: [FileItem]? = nil
    var contents: String
    var type: String {
        return getFileType(fileName: name)
    }
}
