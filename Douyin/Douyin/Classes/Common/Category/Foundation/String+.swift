//
//  String+.swift
//  Douyin
//
//  Created by midland on 2019/1/10.
//

import Foundation

extension String {
    
    static func readJsonToDicWithFileName(fileName:String) -> [String:Any] {
        let path = Bundle.main.path(forResource: fileName, ofType: "json") ?? ""
        var dict = [String:Any]()
        do{
            let data = try Data.init(contentsOf: URL.init(fileURLWithPath: path))
            dict = try JSONSerialization.jsonObject(with: data, options:[]) as! [String : Any]
        }catch {
            print(error.localizedDescription)
        }
        return dict
    }
    
    func md5() -> String {
        let cStrl = cString(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue));
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16);
        CC_MD5(cStrl, CC_LONG(strlen(cStrl!)), buffer);
        var md5String = "";
        for idx in 0...15 {
            let obcStrl = String.init(format: "%02x", buffer[idx]);
            md5String.append(obcStrl);
        }
        free(buffer);
        return md5String;
    }
    
    static func format(decimal: Float, _ maximumDigits: Int = 1, _ minimumDigits: Int = 1) ->String? {
        let number = NSNumber(value: decimal)
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = maximumDigits //设置小数点后最多2位
        numberFormatter.minimumFractionDigits = minimumDigits //设置小数点后最少2位（不足补0）
        return numberFormatter.string(from: number)
    }
    
    func urlScheme(scheme:String) -> URL? {
        if let url = URL.init(string: self) {
            var components = URLComponents.init(url: url, resolvingAgainstBaseURL: false)
            components?.scheme = scheme
            return components?.url
        }
        return nil
    }
    
}
