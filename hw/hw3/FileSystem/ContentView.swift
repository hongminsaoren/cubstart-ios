//
//  ContentView.swift
//  FileSystem
//
//  Created by Andy Huang on 1/19/24.
//

import SwiftUI

struct ContentView: View {
    @State var files: [FileItem] = []
    @State var selectedFile: FileItem?
    @State var editcontent: String=""
    @State var showSheet: Bool = false
    @FocusState private var focusedField: EditFileView.FocusedField?
    var body: some View {
        VStack {
            HStack {
                Text("Files")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                    .bold()
                Spacer()
                Button(action: {showSheet=true}, label: {
                    Image(systemName: "plus")
                        .imageScale(.large)
                })
                .sheet(isPresented: $showSheet)
                {
                    AddFileItemView(files: $files,flag: $showSheet)
                        .presentationDetents([.medium])
                }
                
            }.padding()
             .bold()
             .preferredColorScheme(.dark)
            Spacer()
            List(files, children: \.children) { file in
                HStack {
                    if file.type=="folder" {
                        Image(systemName: file.type)
                            .foregroundColor(.brown)
                        Text(file.name)
                    } else {
                        Button(action: {
                            selectedFile = file
                        }, label: {
                            HStack {
                                Image(systemName: file.type)
                                    .foregroundColor(.brown)
                                Text(file.name)
                                    .foregroundColor(.white)
                            }
                        })
                    }
                }
            }
        }
        .sheet(item: $selectedFile) { file in
            VStack{
                HStack{
                    Spacer()
                    Button(action: {updateContents(files: &files, filename: selectedFile!.name, newContents: editcontent)
                    selectedFile=nil
                    }, label: {
                        Text("Save")
                            .bold()
                    })
                }
                .padding()
                TextField("Content",text: $editcontent,axis: .vertical)
                    .focused($focusedField, equals: .contents)
                    .onAppear { focusedField = .contents }
                Spacer()
                EditFileView(selectedfile: file,files: files)
            }
            .presentationDetents([.medium])
        }
        
    }
}

#Preview {
    ContentView(files: [
        FileItem(name: "Users", children:
          [FileItem(name: "guest", children:
            [FileItem(name: "Photos", children:
                        [FileItem(name: "photo001.jpg", contents: "")], contents: ""),
             FileItem(name: "Movies", children:
                        [FileItem(name: "movie001.mp4", contents: "")], contents: ""),
             FileItem(name: "Documents", children: [FileItem(name: "document.txt", contents: "dcsc")], contents: "")
            ], contents: ""),
          ], contents: ""),
        FileItem(name: "Shared", children: nil, contents: "")
    ])
}
