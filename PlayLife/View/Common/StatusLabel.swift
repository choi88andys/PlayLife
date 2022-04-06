//
//  StatusLabel.swift
//  PlayLife
//
//  Created by MacAndys on 2021/12/22.
//

import SwiftUI



struct StatusLabel: View {
    @EnvironmentObject var userStatus: UserStatus
    @State var isBlinkOn: Bool = false
    var fontName: String = ""
    var fontSize: Double = SettingConstants.fontSize * 1.2
    
    let timer = Timer.publish(every: 0.4, on: .main, in: .common).autoconnect()
    
    
    enum Status {
        case passion
        case courage
        case endurance
        case kindness
    }
    
    func statusUp(status: Status) {
        if userStatus.talent >= SettingConstants.talentPerStatus {
            userStatus.talent -= SettingConstants.talentPerStatus
            
            switch status {
            case .passion:
                userStatus.passion += 1
            case .courage:
                userStatus.courage += 1
            case .endurance:
                userStatus.endurance += 1
            case .kindness:
                userStatus.kindness += 1
            }
            userStatus.setCurrentData()
        }
    }
    
    
    var body: some View {
        return VStack {
            HStack(spacing: 0) {
                Group {
                    Spacer()
                    StatusView(imageView: Image(systemName: "star.circle"),
                               color: Color.yellow,
                               value: userStatus.talent.getShortenToString(),
                               fontName: fontName,
                               fontSize: fontSize,
                               isTalent: true)
                        .frame(width: UIScreen.main.bounds.size.width *
                               SettingConstants.statusViewProportion)                       
                                                            
                    Group {
                        if userStatus.talent >= SettingConstants.talentPerStatus {
                            if isBlinkOn {
                                Image(systemName: "forward.fill")
                                    .foregroundColor(Color.yellow)
                            }
                            else {
                                Image(systemName: "forward")
                                    .foregroundColor(Color.gray)
                            }
                        }
                        else {
                            Image(systemName: "forward")
                                .foregroundColor(Color.gray)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.size.width*0.06)
                    .font(.system(size: SettingConstants.fontSize*0.55))
                    .padding(.trailing, SettingConstants.fontSize*0.7)
                    
                    
                    
                    Group {
                        StatusView(imageView: Image(systemName: "flame.circle"),
                                   color: Color.red,
                                   value: userStatus.passion.getShortenToString(),
                                   fontName: fontName,
                                   fontSize: fontSize)
                            .onTapGesture {
                                statusUp(status: .passion)
                            }
                        
                        StatusView(imageView: Image(systemName: "figure.wave.circle"),
                                   color: Color.green,
                                   value: userStatus.courage.getShortenToString(),
                                   fontName: fontName,
                                   fontSize: fontSize)
                            .onTapGesture {
                                statusUp(status: .courage)
                            }
                        
                        StatusView(imageView: Image(systemName: "hourglass.circle"),
                                   color: Color.blue,
                                   value: userStatus.endurance.getShortenToString(),
                                   fontName: fontName,
                                   fontSize: fontSize)
                            .onTapGesture {
                                statusUp(status: .endurance)
                            }
                                                
                        StatusView(imageView: Image(systemName: "heart.circle"),
                                   color: Color.hotPink,
                                   value: userStatus.kindness.getShortenToString(),
                                   fontName: fontName,
                                   fontSize: fontSize)
                            .onTapGesture {
                                statusUp(status: .kindness)
                            }
                    }
                    .frame(width: UIScreen.main.bounds.size.width *
                           SettingConstants.statusViewProportion)
                    Spacer()
                }
            } // end of HStack
            
            
            Divider()
        } // end of top view
        .padding(.vertical, SettingConstants.fontSize*0.5)
        .onReceive(timer) { _ in
            isBlinkOn.toggle()
        }
    }
}



#if DEBUG
struct StatusLabel_Previews: PreviewProvider {
    @State static var isBlinkOn: Bool = true
        
    static var userStatus: UserStatus =
    UserStatus(123_000_000, 456_000_000, 789_000_000, 246_000_000, 130_000_000)
    // static var userStatus: UserStatus = UserStatus(0, 0, 0, 0, 0)
    
    
    static let fontName = "D2Coding"
    static let fontSize = SettingConstants.fontSize * 1.15
    static let fontName2 = "NeoDunggeunmoPro-Regular"
    static let fontSize2 = SettingConstants.fontSize * 1.2
    
    static let selection = 4
    static var previews: some View {
        
    
        
        switch selection {
        case 1:
            StatusLabel(fontName: fontName, fontSize: fontSize)
                .environmentObject(userStatus)
                .previewDevice(PreviewDevice(rawValue: "iPhone 8 Plus"))
                .previewDisplayName("8 Plus")
            
        case 2:
            StatusLabel(fontName: fontName, fontSize: fontSize)
                .environmentObject(userStatus)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
                .previewDisplayName("11 Pro Max")
            
        case 3:
            StatusLabel(fontName: fontName, fontSize: fontSize)
                .environmentObject(userStatus)
                .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (5th generation)"))
                .previewDisplayName("iPad Pro 12.9")
            
        default:
            VStack {
                StatusLabel(fontName: fontName, fontSize: fontSize)
                 
                StatusLabel(fontName: fontName2, fontSize: fontSize2)
            }
            .environmentObject(userStatus)
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
            .previewDisplayName("13 Pro")
            
        }
    }
}
#endif
 
