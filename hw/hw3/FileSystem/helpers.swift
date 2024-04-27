//
//  helpers.swift
//  FileSystem
//
//  Created by Andy Huang on 1/19/24.
//

import Foundation

// TODO: Implement this function
func getFileType(fileName: String) -> String {
    /* Given the file name as a string, returns the name of the corresponding SF symbol for the file type.
     
     Example:
     - getFileType(".jpg") -> "photo"
     - getFileType(".txt") -> "doc"
     - getFileType(".mp4") -> "film"
     - getFileType(".py") -> "folder"
     */
    if fileName.hasSuffix(".jpg"){
        return "photo"
    }
    if fileName.hasSuffix(".txt"){
        return "doc"
    }
    if fileName.hasSuffix(".mp4"){
        return "film"
    }
    return "folder"
}
func getSuffixName(filetype: String)->String{
    
    if filetype=="Text"{
        return ".txt"
    }
    if filetype=="Image"{
        return ".jpg"
    }
    if filetype=="Video"{
        return ".mp4"
    }
    return ""
    
}
func updateContents(files: inout [FileItem], filename: String, newContents: String) -> Bool {
    /* Updates the file contents of the file with 'filename' inside 'files' with 'newContents'.
     Returns true if contents were sucessfully updated. False otherwise.
     
     Example Usage:
     updateContents(files: &myFiles, filename: file.name, newContents: file.contents) -> true
     */
    for (index, file) in files.enumerated() {
        if file.name == filename {
            files[index].contents = newContents
            return true
        }
        
        // Recurse
        if let numChildren = files[index].children?.count, numChildren > 0 {
            if updateContents(files: &files[index].children!, filename: filename, newContents: newContents) {
                return true
            }
        }
    }
    return false
}

func insertNewFile(files: inout [FileItem], parentDirectoryName: String, newFile: FileItem) -> Bool {
    /* Inserts 'newFile' into the 'files' array. Specifically, the new FileItem is inserted in the folder with
     name 'parentDirectoryName'. Returns true if file was successfully inserted. False otherwise.
     
     Example Usage:
     insertNewFile(files: &myFiles, parentDirectoryName: "root", newFile: FileItem(name:"newFolder", contents: "")
     */
    
    // Root case
    if parentDirectoryName == "root" {
        files.append(newFile)
        return true
    }
    
    for (index, file) in files.enumerated() {
        // Add to directory
        if file.name == parentDirectoryName {
            if let _ = files[index].children {
                files[index].children!.append(newFile)
            } else {
                files[index].children = [newFile]
            }
            return true
        }
        
        // Recurse
        if let numChildren = files[index].children?.count, numChildren > 0 {
            if (insertNewFile(files: &files[index].children!, parentDirectoryName: parentDirectoryName, newFile: newFile)) {
                return true
            }
        }
    }
    return false
}

func getDirectoryNames(files: [FileItem]) -> [String] {
    /* Returns a list of the names of all directories in the file system excluding the root directory. */
    
    var directoryNames: [String] = []
    for file in files {
        if file.type == "folder" {
            directoryNames.append(file.name)
            
            // Recurse
            if let _ = file.children {
                directoryNames += getDirectoryNames(files: file.children!)
            }
        }
    }

    return directoryNames
}

func resolveFileExtension(type: String) -> String {
    /* Given a verbose file type string, returns the corresponding file extension.
     
     Example: resolveFileExtension("Text") -> ".txt"
     */
    if type.lowercased() == "text" {
        return ".txt"
    } else if type.lowercased() == "image" {
        return ".jpg"
    } else if type.lowercased() == "video" {
        return ".mp4"
    } else {
        return ""
    }
}
