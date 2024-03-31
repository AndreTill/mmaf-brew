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
            let p = FileManager.default.contents(atPath: Bundle.main.url(forResource: "mirrors_list", withExtension: "plist")?.path ?? "/usr/local/share/opt-viewer/mirrors_list.plist")
            let res = try! PropertyListSerialization.propertyList(from: p!,options: .mutableContainersAndLeaves, format: nil) as! [String]
            return res 
        }
        set(val) {
            let p = Bundle.main.url(forResource: "settings", withExtension: "plist")?.path ?? "/usr/local/share/opt-viewer/mirrors_list.plist"

            
            let da = try! PropertyListEncoder().encode(val)
            try! da.write(to: URL.init(filePath: p))
        }
    }
    
    for argument in CommandLine.arguments {
        print(argument)
        switch argument {
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


