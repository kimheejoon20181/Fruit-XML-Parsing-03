//
//  ViewController.swift
//  Fruit XML Parsing 03
//
//  Created by dit08 on 2019. 12. 5..
//  Copyright © 2019년 dit. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate {
    
    var item:[String:String] = [:]
    var elements:[[String:String]] = []
    var currentElemdnt = ""         //현재 tag 저장

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = Bundle.main.url(forResource: "Fruit", withExtension: "xml")
        //옵셔널 벤딩 체크
        if path != nil {
            let myParser = XMLParser(contentsOf: path!)
            myParser?.delegate = self
            
            // parsing이 성공하는 ture 리턴, 실패하면 false 리턴
            if myParser?.parse() != nil {
                
                print("parse succed")
                print(elements)
                
            } else{
                print("parsing error")
            }
        } else {
            print("file error")
        }
    }
    //XMLParstin Delegate methods
    //tag를 만날때 호출 : <tag>
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]){
        
        currentElemdnt = elementName
        print(currentElemdnt)
    }
    
    // tag 다음에 문자를 만날때
    func parser(_ parser: XMLParser, foundCharacters string: String){
        //공백 제거(withe char) 제거
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        if !data.isEmpty {
            item[currentElemdnt] = data
        }
        
    }
    
    //tag를 끝날때 호출 : <tag>
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        if elementName == "itme" {
            elements.append(item)
        }
    }


}
