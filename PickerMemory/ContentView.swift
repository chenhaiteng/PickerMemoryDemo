//
//  ContentView.swift
//  PickerMemory
//
//  Created by Chen Hai Teng on 3/26/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedLanguage: Locale.LanguageCode = .english
    @State private var showMenu: Bool = false
    var body: some View {
        StyledPicker(
            Picker(selectedLanguage.displayName, selection: $selectedLanguage) {
                ForEach(LanguageData.isoLanguages) { language in
                    Text(language.displayName).tag(language.code)
                }
            }, style: .inline
        )
//        EasyMenuPicker(
//            "\(selectedLanguage.displayName)",
//            selection: $selectedLanguage
//        ) {
//            ForEach(LanguageData.isoLanguages) { lang in
//                Text(lang.displayName).tag(lang.code)
//            }
//        }
    }
}

#Preview {
    ContentView()
}
