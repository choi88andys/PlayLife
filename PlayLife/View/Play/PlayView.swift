//
//  PlayView.swift
//  PlayLife
//
//  Created by MacAndys on 2021/12/31.
//

import SwiftUI


struct PlayView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var enemy: FetchedResults<Enemy>
    @EnvironmentObject var userStatus: UserStatus
    
    
    @State var enemyName: String = ""
    @State var enemyLevel: Int32 = 0
    @State var prevArray: [String] = []
    @State var nounArray: [String] = []
    
    @State var isWin: Bool = false    
    @State var refresher: Bool = false
    
    func refresh() {
        refresher.toggle()
    }
    
    func getName() -> String {
        return "\(prevArray.randomElement() ?? "" ) \(nounArray.randomElement() ?? "")"
    }
    
    func getHint() -> String {
        var hint: String = ""
        
        switch enemy[0].weakPoint {
        case .passion:
            hint = SettingConstants.stringHintPassion
        case .courage:
            hint = SettingConstants.stringHintCourage
        case .endurance:
            hint = SettingConstants.stringHintEndurance
        case .kindness:
            hint = SettingConstants.stringHintKindness
        }
        return hint
    }
    
    func earnTalent() {
        userStatus.talent += Int.random(in: SettingConstants.minimumTalentPerWin ... SettingConstants.maximumTalentPerWin)
        UserDefaults.talent = userStatus.talent
    }
    
    
    func decideVictory() -> Bool {
        var passion = Double(userStatus.passion)
        var courage = Double(userStatus.courage)
        var endurance = Double(userStatus.endurance)
        var kindness = Double(userStatus.kindness)
        
        switch enemy[0].weakPoint {
        case .passion:
            passion *= SettingConstants.weakPointMultiplier
        case .courage:
            courage *= SettingConstants.weakPointMultiplier
        case .endurance:
            endurance *= SettingConstants.weakPointMultiplier
        case .kindness:
            kindness *= SettingConstants.weakPointMultiplier
        }
        let sumOfStatus = passion + courage + endurance + kindness
        
        
        if sumOfStatus >= enemy[0].health {
            return true
        } else {
            return false
        }
    }
    
    
    
    
    
    
    @ObservedObject var timer = AnimationTimer()
    
    
    @State var opacityResultLevel: Double = 0
    @State var opacityResultName: Double = 0
    @State var opacityResultVictory: Double = 0
    @State var opacityResultHint: Double = 0
    
    @State var animatedSpacing: CGFloat = UIScreen.main.bounds.width
    @State var opacityImpactViewLeft: Double = 1
    @State var opacityImpactViewRight: Double = 1
    @State var offsetImpactViewLeft: CGFloat = 0
    @State var offsetImpactViewRight: CGFloat = 0
    
    func resetAnimationValue() {
        opacityResultLevel = 0
        opacityResultName = 0
        opacityResultVictory = 0
        opacityResultHint = 0
        timer.isShowingResultRefresher = false
        
        opacityImpactViewLeft = 1
        opacityImpactViewRight = 1
        offsetImpactViewLeft = 0
        offsetImpactViewRight = 0
        animatedSpacing = UIScreen.main.bounds.width
    }
    
    func playAnimation() {
        resetAnimationValue()
        
        
        // first impact
        withAnimation(.easeIn(duration: SettingConstants.animateDurationStandard)) {
            animatedSpacing = 0
        }
        withAnimation(.easeOut(duration: SettingConstants.animateDurationStandard)
                        .delay(SettingConstants.animateDurationStandard)) {
            animatedSpacing = SettingConstants.fontSize * 7
        }
        // second impact
        withAnimation(.easeInOut(duration: SettingConstants.animateDurationVeryLong)
                        .delay(SettingConstants.animateDurationStandard +
                               SettingConstants.animateDurationStandard)) {
            
            animatedSpacing = rect1.width * -1
        }
        // end of second impact
        
        // on second impact
        withAnimation(.easeOut(duration: SettingConstants.animateDurationVeryShort)
                        .delay(SettingConstants.animateDurationStandard +
                               SettingConstants.animateDurationStandard +
                               SettingConstants.animateDurationVeryLong/2)) {
            if isWin {
                opacityImpactViewRight = 0
            }
            else {
                opacityImpactViewLeft = 0
            }
        }
        // end of impact animation
        let impactDuration: Double =
        SettingConstants.animateDurationStandard +
        SettingConstants.animateDurationStandard +
        SettingConstants.animateDurationVeryLong
        
        
        
        
        withAnimation(.easeInOut(duration: SettingConstants.animateDurationShort)
                        .delay(impactDuration)) {
            opacityResultLevel = 1
        }
        withAnimation(.easeInOut(duration: SettingConstants.animateDurationShort)
                        .delay(impactDuration +
                               SettingConstants.animateDurationShort)) {
            opacityResultName = 1
        }
        withAnimation(.easeInOut(duration: SettingConstants.animateDurationShort)
                        .delay(impactDuration +
                               SettingConstants.animateDurationShort +
                               SettingConstants.animateDurationShort)) {
            opacityResultVictory = 1
        }
        withAnimation(.easeInOut(duration: SettingConstants.animateDurationShort)
                        .delay(impactDuration +
                               SettingConstants.animateDurationShort +
                               SettingConstants.animateDurationShort +
                               SettingConstants.animateDurationShort)) {
            opacityResultHint = 1
        }
        // end of result animation
        let resultDurationWin =
        SettingConstants.animateDurationShort +
        SettingConstants.animateDurationShort +
        SettingConstants.animateDurationShort
        
        let resultDurationLose =
        SettingConstants.animateDurationShort +
        SettingConstants.animateDurationShort +
        SettingConstants.animateDurationShort
        
        let resultDurationLoseWithHint =
        SettingConstants.animateDurationShort +
        SettingConstants.animateDurationShort +
        SettingConstants.animateDurationShort +
        SettingConstants.animateDurationShort
        
        
        
        if isWin {
            timer.animateDuration = impactDuration + resultDurationWin
        } else {
            if enemy[0].defeatCount >= SettingConstants.tryCountForHint {
                timer.animateDuration = impactDuration + resultDurationLoseWithHint
            }
            else {
                timer.animateDuration = impactDuration + resultDurationLose
            }
        }
    }
        
    
    @State private var rect1: CGRect = CGRect()
    struct GeometryGetterMod: ViewModifier {
        @Binding var rect: CGRect
        
        func body(content: Content) -> some View {
            return GeometryReader { (g) -> Color in
                rect = g.frame(in: .global)
                return Color.clear
            }
        }
    }
    
    @State var showStar: Bool = false
    @State var colorOfWeakPoint: Color = .clear
    
    var body: some View {
        
        return VStack {
            StatusLabel(fontName: SettingConstants.fontNamePlay, fontSize: SettingConstants.fontSize * 1.2)
            
            
                        
            Spacer()
            if !enemyName.isEmpty {
                VStack(spacing: SettingConstants.fontSize * 0.5) {
                    VStack {
                        Spacer()
                        HStack(spacing: animatedSpacing) {
                            
                            // left side
                            HStack {
                                Spacer()
                                
                                VStack {
                                    Spacer()
                                    
                                    if showStar {
                                        ShowingStarView()
                                    }
                                    else {
                                        ShowingStarView()
                                            .hidden()
                                    }
                                    
                                    Image(systemName: "figure.walk")
                                        .font(.system(size: SettingConstants.fontSize*1.8))
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width*1)
                            .opacity(opacityImpactViewLeft)
                            
                                                        
                            
                            // right side
                            HStack {
                                VStack(spacing: SettingConstants.fontSize * 0.5) {
                                    Spacer()
                                    if !isWin {
                                        Text("\(String(enemyLevel) + SettingConstants.stringHowMany)")
                                            .opacity(opacityResultLevel)
                                    }
                                    else {
                                        Text("\(String(enemyLevel) + SettingConstants.stringHowMany)")
                                            .hidden()
                                    }
                                    Text(enemyName)
                                        // .font(.system(size: SettingConstants.fontSize*1.9))
                                        .font(.custom(SettingConstants.fontNamePlay, size: SettingConstants.fontSize * 2.1))
                                        .overlay(Color.clear.modifier(GeometryGetterMod(rect: $rect1)))
                                }
                                
                                VStack {
                                    Spacer()
                                    VStack {
                                        Text(SettingConstants.stringForWho)
                                            .opacity(opacityResultName)
                                    }
                                    .frame(height: rect1.height)
                                }
                                
                                Spacer()
                            }
                            .frame(width: UIScreen.main.bounds.width*1)
                            .opacity(opacityImpactViewRight)
                                                        
                        }
                    } // end of container
                    .frame(height: SettingConstants.fontSize * 6)
                    
                    
                    VStack(spacing: SettingConstants.fontSize * 0.5) {
                        if isWin {
                            Text("\(String(enemyLevel) + SettingConstants.stringHowMany)")
                                .opacity(opacityResultLevel)
                            
                            HStack(spacing: SettingConstants.fontSize * 0.2) {
                                Text(enemyName)
                                    .font(.custom(SettingConstants.fontNamePlay, size: SettingConstants.fontSize * 1.3))
                                Text(SettingConstants.stringForWho)
                            }
                            .opacity(opacityResultName)
                            
                            Text(SettingConstants.stringWin)
                                .opacity(opacityResultVictory)
                        }
                        else {
                            Text(SettingConstants.stringLose)
                                .opacity(opacityResultVictory)
                            
                            if enemy[0].defeatCount >= SettingConstants.tryCountForHint {
                                Text(getHint())
                                    .opacity(opacityResultHint)
                            }
                        }
                        
                        Spacer()
                        
                        if timer.isShowingResultRefresher {
                            Button {
                                refresh()
                            } label: {
                                Image(systemName: isWin ? "arrowtriangle.right.fill" : "arrow.clockwise")
                                    .font(.system(size: SettingConstants.fontSize * 1.5))
                                    .foregroundColor(isWin ? .yellow : colorOfWeakPoint)
                                    .onAppear {
                                        if isWin {
                                            earnTalent()
                                            enemy[0].nextLevel(name: getName())
                                            if moc.hasChanges {
                                                try? moc.save()
                                            }
                                            
                                            showStar = true
                                            withAnimation(.easeInOut(duration: SettingConstants.talentUpDuration)) {
                                                showStar = false
                                            }
                                        }
                                        else {
                                            switch enemy[0].weakPoint {
                                            case .passion:
                                                colorOfWeakPoint = .red
                                            case .courage:
                                                colorOfWeakPoint = .green
                                            case .endurance:
                                                colorOfWeakPoint = .blue
                                            case .kindness:
                                                colorOfWeakPoint = .hotPink
                                            }
                                        }
                                    }
                            }
                        }
                    }
                    .frame(height: SettingConstants.fontSize * 10)
                    
                    
                }
                .font(.custom(SettingConstants.fontNamePlay, size: SettingConstants.fontSize*1.1))
                // .font(.system(size: SettingConstants.fontSize * 1))
                .onAppear {
                    refresh()
                }
                .onChange(of: refresher) { _ in
                    enemyLevel = enemy[0].level
                    enemyName = enemy[0].wrappedName
                    isWin = decideVictory()
                    if !isWin {
                        enemy[0].defeatCount += 1
                        if moc.hasChanges {
                            try? moc.save()
                        }
                    }
                    
                    DispatchQueue.main.async {
                        playAnimation()
                    }
                }
            } // end of if
            
            
            Spacer()
            Spacer()
            
        } // end of top view
        .onAppear {
            if prevArray.isEmpty {
                if let filepath = Bundle.main.path(forResource: SettingConstants.fileNamePrev, ofType: SettingConstants.fileType) {
                    do {
                        let data = try String(contentsOfFile: filepath)
                        let lines = data.split(whereSeparator: \.isNewline)
                        let result = lines.joined(separator: SettingConstants.separator)
                        prevArray = result.components(separatedBy: SettingConstants.separator)
                    } catch {
                        print(SettingConstants.fileNamePrev)
                        print(SettingConstants.loadFailed)
                    }
                } else {
                    print(SettingConstants.fileNamePrev)
                    print(SettingConstants.notFounded)
                }
            }
            if nounArray.isEmpty {
                if let filepath = Bundle.main.path(forResource: SettingConstants.fileNameNoun, ofType: SettingConstants.fileType) {
                    do {
                        let data = try String(contentsOfFile: filepath)
                        let lines = data.split(whereSeparator: \.isNewline)
                        let result = lines.joined(separator: SettingConstants.separator)
                        nounArray = result.components(separatedBy: SettingConstants.separator)
                    } catch {
                        print(SettingConstants.fileNameNoun)
                        print(SettingConstants.loadFailed)
                    }
                } else {
                    print(SettingConstants.fileNameNoun)
                    print(SettingConstants.notFounded)
                }
            }
            // Runs when it first time.
            if enemy.isEmpty {
                let newEnemy = Enemy(context: moc)
                newEnemy.nextLevel(name: getName(), isFirst: true)
                
                if moc.hasChanges {
                    try? moc.save()
                }
            }
            
            isWin = false
            enemyLevel = enemy[0].level
            enemyName = enemy[0].wrappedName
        }
        .onDisappear {
            resetAnimationValue()
            isWin = false
        }
        
        
        
    }
}



