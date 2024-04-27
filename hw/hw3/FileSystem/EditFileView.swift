//
//  EditFileView.swift
//  FileSystem
//
//  Created by Andy Huang on 1/19/24.
//

import SwiftUI

struct EditFileView: View {
    var selectedfile: FileItem
    var files:[FileItem]
    enum FocusedField {
        case contents
    }
    @FocusState private var focusedField: FocusedField?
    
    
    var body: some View {
        Text("File Content")
            .foregroundColor(.white)
    }
}

#Preview {
    ContentView()
}
