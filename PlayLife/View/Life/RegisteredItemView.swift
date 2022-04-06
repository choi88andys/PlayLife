//
//  RegisteredItemView.swift
//  PlayLife
//
//  Created by MacAndys on 2022/01/12.
//

import SwiftUI

struct RegisteredItemView: View {
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\Item.registerDate, order: .reverse),
        SortDescriptor(\Item.itemType),
        SortDescriptor(\Item.content)
    ]) var items: FetchedResults<Item>
    
    @State var refreshID: UUID = UUID()
    @State var isItemChanged: Bool = false
    
    var body: some View {
        return Group {
            if items.isEmpty {
                Text(Strings.stringForEmptyRegister)
                    .font(.system(size: SettingConstants.fontSize*1.3))
            } else {
                ScrollView(showsIndicators: false) {
                    VStack {
                        ForEach(items) { anItem in
                            ListCell(item: anItem, isItemChanged: $isItemChanged)
                        }
                    }
                    .customStyle()
                    .onAppear {
                        if isItemChanged {
                            refreshID = UUID()
                            isItemChanged = false
                        }
                    }
                }
                .id(refreshID)
            }
        }
        .navigationTitle(Strings.registeredItemViewTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    struct ListCell: View {
        var item: Item
        @Binding var isItemChanged: Bool
        @State var isActiveDetailView: Bool = false
        
        var body: some View {
            return NavigationLink(
                destination: ItemDetailView(anItem: item, isActiveDetailView: $isActiveDetailView, isItemChanged: $isItemChanged),
                isActive: $isActiveDetailView) {
                    HStack(spacing: SettingConstants.fontSize * 0.6) {
                        SelectedTypeImageView(typeSelection: item.typeSelection)
                            .font(.system(size: SettingConstants.fontSize * 1.8))
                        
                        Text(item.wrappedContent)
                            .foregroundColor(Color.primary)
                            .lineLimit(SettingConstants.registeredItemLineLimit)
                            .font(.system(size: SettingConstants.fontSize*1))
                            .multilineTextAlignment(TextAlignment.leading)
                        
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, SettingConstants.fontSize*0.45)
                } // end of link
                
            
        }
    }
}


