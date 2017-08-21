//
//  ViewController.swift
//  Silly Song
//
//  Created by Andrew Jackson on 20/08/2017.
//  Copyright © 2017 Jacko1972. All rights reserved.
//

import UIKit

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

class ViewController: UIViewController {
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        guard let temp = nameField.text else {
            lyricsView.text = "Please enter a name in the text field above!"
            return
        }
        lyricsView.text = lyricsByName(template: bananaFanaTemplate, fullName: temp)
    }
}

let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")

func shortNameFromName(name: String) -> String {
    var tempName = name.lowercased()
    let chars: CharacterSet = CharacterSet(charactersIn: "aeiou")
    
    let range = tempName.startIndex..<tempName.index(after: tempName.startIndex)
    var removeChars: Bool = true
    if tempName.rangeOfCharacter(from: chars, options: String.CompareOptions.literal, range: tempName.startIndex..<tempName.endIndex) != nil {
        while removeChars {
            if tempName.rangeOfCharacter(from: chars, options: String.CompareOptions.literal, range: range) != nil {
                removeChars = false
            } else {
                tempName.remove(at: tempName.startIndex)
            }
        }
    }
    return tempName
}

func lyricsByName(template: String, fullName: String) -> String {
    
    let shortName = shortNameFromName(name: fullName)
    let lyrics = template
        .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    return lyrics
    
}
