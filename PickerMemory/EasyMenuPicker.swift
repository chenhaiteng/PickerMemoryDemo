//
//  MenuPicker.swift
//  PickerMemory
//
//  Created by Chen Hai Teng on 3/26/25.
//

import SwiftUI

struct MenuPickerBody<SelectionValue, Content> : View where SelectionValue: Hashable, Content: View {
    let content: () -> Content
    @Binding var selection: SelectionValue
    @Binding var isPicking: Bool
    var body : some View {
        ForEach(subviews: content()) { subview in
            if let tag = subview.containerValues.tag(for: SelectionValue.self) {
                HStack(spacing: 0) {
                    if(tag == selection) {
                        Image(systemName: "checkmark").frame(width: 40).foregroundStyle(Color.blue)
                    } else {
                        Spacer().frame(width: 40)
                    }
                    subview.frame(maxWidth:.infinity, alignment: .leading)
                }.contentShape(Rectangle()).onTapGesture {
                    selection = tag
                    isPicking = false
                }.padding(.horizontal, 5)
                Divider().padding(.horizontal, 10)
            } else {
                subview.disabled(true).padding(.leading, 40)
                Divider().padding(.horizontal, 10)
            }
        }
    }
    
    init(selection: Binding<SelectionValue>, isPicking: Binding<Bool>, content: @escaping () -> Content) {
        self.content = content
        self._selection = selection
        self._isPicking = isPicking
    }
}

struct IOSMenuPicker<SELECTION: Hashable, Content: View>: View {
    let title:String
    let content: () -> Content
    @Binding var selection: SELECTION
    @State private var isPicking = false
    
    var body: some View {
        Button {
            isPicking = true
        } label: {
            HStack {
                if !title.isEmpty {
                    Text("\(title)")
                }
                VStack {
                    Group {
                        Image(systemName:"control")
                        Image(systemName: "control").rotationEffect(.degrees(180.0))
                    }.font(.system(size: 10, weight: .bold))
                }
            }
        }.buttonStyle(.borderless).popover(isPresented: $isPicking) {
            ScrollViewReader { scroller in
                ScrollView {
                    LazyVStack {
                        MenuPickerBody(selection: $selection,
                                       isPicking: $isPicking,
                                       content: content)
                    }.padding(.vertical, 10)
                }.onAppear {
                    scroller.scrollTo(selection, anchor: .center)
                }
            }.frame(minWidth: 300).presentationCompactAdaptation(.popover)
        }
    }
    
    init(_ title: String, selection: Binding<SELECTION>, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self._selection = selection
        self.content = content
    }
}

struct MacOSMenuPicker<SELECTION: Hashable, Content: View>: View {
    let title:String
    let content: () -> Content
    @Binding var selection: SELECTION
    @State private var isPicking = false
    
    var body: some View {
        Button {
            isPicking = true
        } label: {
            HStack {
                Text("\(title)").frame(minWidth: 30, idealWidth: 80)
                VStack {
                    Group {
                        Image(systemName:"control")
                        Image(systemName: "control").rotationEffect(.degrees(180.0))
                    }.font(.system(size: 10, weight: .bold))
                }.padding(.all, 1).background(Color.blue, in: RoundedRectangle(cornerRadius: 3))
            }.frame(minHeight: 20)
        }.buttonStyle(.bordered).popover(isPresented: $isPicking) {
            ScrollViewReader { scroller in
                ScrollView {
                    LazyVStack {
                        MenuPickerBody(selection: $selection,
                                       isPicking: $isPicking,
                                       content: content)
                    }.padding(.vertical, 10)
                }.onAppear {
                    scroller.scrollTo(selection, anchor: .center)
                }
            }.frame(minWidth: 120, idealWidth: 200).presentationCompactAdaptation(.popover)
        }
    }
    
    init(_ title: String, selection: Binding<SELECTION>, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self._selection = selection
        self.content = content
    }
}

struct EasyMenuPicker<SELECTION: Hashable, Content: View>: View {
    let title:String
    let content: () -> Content
    @Binding var selection: SELECTION
    
    var body: some View {
        #if os(iOS) || targetEnvironment(macCatalyst)
        IOSMenuPicker(title, selection: $selection, content: content)
        #elseif os(macOS)
        MacOSMenuPicker(title, selection: $selection, content: content)
        #endif
    }
    
    init(_ title: String, selection: Binding<SELECTION>, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self._selection = selection
        self.content = content
    }
}

#Preview {
    EasyMenuPicker("TEST MENU", selection: .constant(1)) {
        ForEach(0...10, id: \.self) { i in
            Text(i.description)
        }
    }.padding(10)
}
