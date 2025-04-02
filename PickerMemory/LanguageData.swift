//
//  LanguageData.swift
//  PickerMemory
//
//  Created by Chen Hai Teng on 4/2/25.
//

import Foundation

extension Locale.LanguageCode {
    var displayName: String {
        Locale.current.localizedString(forIdentifier: identifier) ?? identifier
    }
}

struct IdentifiableLanguageCode : Identifiable {
    let id : String
    let displayName : String
    let code: Locale.LanguageCode
    
    init(code: Locale.LanguageCode) {
        self.code = code
        self.id = code.identifier
        self.displayName = code.displayName
    }
}

struct LanguageData {
    // A static list to record language data
    static let isoLanguages = Locale.LanguageCode.isoLanguageCodes.compactMap { code in
        IdentifiableLanguageCode(code: code)
    }
}
