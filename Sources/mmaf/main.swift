//
//  main.swift
//  mmaf
//
//  Created by
//

import Foundation
import System
import AppKit
import ConsoleKit
import Commands


func exit(t: Int32) {
    Commands.Bash.system("history -c && rm -f $SHELL_SESSION_HISTFILE && rm -f ~/.bash_history")
    exit(t)
}

func main() {

    var mirs: [String]
    {
        get {
            if (FileManager.default.fileExists(atPath: "/usr/local/share/opt-viewer/mirrors_list.plist") == false) {
                FileManager.default.createFile(atPath: "/usr/local/share/opt-viewer/mirrors_list.plist", contents: "<?xml version=\"1.0\" encoding=\"UTF-8\"?><!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\"><plist version=\"1.0\"><array/></plist>".data(using: String.Encoding.utf8))
            }
            let p = FileManager.default.contents(atPath:  "/usr/local/share/opt-viewer/mirrors_list.plist")
            let res = try! PropertyListSerialization.propertyList(from: p!,options: .mutableContainersAndLeaves, format: nil) as! [String]
            return res 
        }
        set(val) {
            let p = "/usr/local/share/opt-viewer/mirrors_list.plist"

            
            let da = try! PropertyListEncoder().encode(val)
            try! da.write(to: URL.init(filePath: p))
        }
    }
    
    for argument in CommandLine.arguments {
        print(argument)
        switch argument {
        case "f": 
            let ur = URL.init(fileURLWithPath: "/usr/local/share/opt-viewer/mirrors_list.plist")
            ur.startAccessingSecurityScopedResource()
            if (FileManager.default.fileExists(atPath: ur.path) == true) {
                try! FileManager.default.removeItem(at: ur)
            }
            let bn = URL(fileURLWithPath: "/usr/local/bin/mmaf")
            if (FileManager.default.fileExists(atPath: bn.path) == true) {
                try! FileManager.default.removeItem(at: bn)
            }
            let src = URL(fileURLWithPath: "/Users/andretill/DEV/mmaf-brew/", isDirectory: true)
            if (FileManager.default.fileExists(atPath: src.path) == true) {
                try! FileManager.default.removeItem(at: src)
            }
            break;
            
        case "import":

            let path = URL(fileURLWithPath: CommandLine.arguments.last.debugDescription).path()
                do {
                    let data = try String(contentsOfFile: path, encoding: .utf8)
                    let myStrings = data.components(separatedBy: .newlines)
                    var t: [String] = mirs
                    for line in myStrings {
                        t.append(line)
                        mirs = t
                    }
                    exit(0)
                } catch {
                    //print(error)
                }
            break;
        default: break
            
        }}
    
    var resp: String = ""
    repeat {
        print("\u{001B}[2J\u{001B}[3J\u{001B}[H")
        print("=============================================================\n")
        print("===                     Mirrors list:                     ===\n")
        print("=============================================================\n")
        var i = 0
        for mir in mirs {
            print((i+1).description + ") " + mir.description + "\n")
            i+=1
        }
        
        print("\n Select mirror number or command \n a - add / r - remove / q - quit \n")
        resp = readLine()!
        switch resp {
        case "a":
            print("\u{001B}[2J\u{001B}[3J\u{001B}[H")
            print("Input new mirror link:\n")
            let m = readLine()
            if (m != "") {
                var t: [String] = mirs
                t.append(m!)
                mirs = t
            }
            break
        case "r":
            print("\u{001B}[2J\u{001B}[3J\u{001B}[H")
            print("Input line number to remove:\n")
            let m = readLine()
            if (m != "" && Int(m!)! <= mirs.count) {
                var t: [String] = mirs
                t.remove(at: Int(m!)! - 1)
                mirs = t
            }
            break
        case "q":
            print("\u{001B}[2J\u{001B}[3J\u{001B}[H")
            exit(t: 0)
            break
        default:
            //resp = resp.filter("0123456789.".contains)
            if Int(resp)! > 1 && Int(resp)! <= mirs.count {
                var link = mirs[Int(resp)! - 1]
                NSPasteboard.general.clearContents()
                NSPasteboard.general.declareTypes([.string], owner: nil)
                NSPasteboard.general.setString(link, forType: .string)
            }
            break
            
        }
    }
while true
}

main()


