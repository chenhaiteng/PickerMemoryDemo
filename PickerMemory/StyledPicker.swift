//
//  PickerStyleWrapper.swift
//  PickerMemory
//
//  Created by Chen Hai Teng on 3/26/25.
//

import SwiftUI

// This is a wrapper for SwiftUI Picker.
// To reduce the effort to decide the parent container of a picker for each style.
struct StyledPicker<Label, SelectionValue, Content> : View where Label : View, SelectionValue : Hashable, Content : View {
    let picker: Picker<Label, SelectionValue, Content>
    let style: any PickerStyle
    var body: some View {
        switch style {
#if os(iOS) || targetEnvironment(macCatalyst)
        case let style as WheelPickerStyle:
            picker.pickerStyle(style)
        case let style as NavigationLinkPickerStyle:
            NavigationStack {
                picker.pickerStyle(style)
            }
        case let style as InlinePickerStyle:
            Form {
                picker.pickerStyle(style)
            }
#elseif os(macOS)
        case let style as RadioGroupPickerStyle:
            ScrollView(.horizontal) {
                picker.pickerStyle(style).frame(height: 60).horizontalRadioGroupLayout()
            }.frame(idealWidth: 600).fixedSize(horizontal: true, vertical: false)
            
        case let style as InlinePickerStyle:
            ScrollView {
                Form {
                    picker.pickerStyle(style)
                }
            }
#endif
        case let style as MenuPickerStyle:
            picker.pickerStyle(style)
        case let style as SegmentedPickerStyle:
            ScrollView(.horizontal) {
                picker.pickerStyle(style).frame(height:60)
            }.padding(20).scrollIndicators(.visible)
        case let style as PalettePickerStyle:
            Menu("palette") {
                picker.pickerStyle(style)
            }
        case let style as DefaultPickerStyle:
            picker.pickerStyle(style)
        default:
            picker
        }
    }
    
    init(_ picker: Picker<Label, SelectionValue, Content>, style: any PickerStyle) {
        self.picker = picker
        self.style = style
    }
}

#Preview {
    StyledPicker(
        Picker("TEST", selection: .constant(1)) {
            ForEach(0..<10) { i in
                Text("\(i)")
            }
        }, style: .menu
    )
}
