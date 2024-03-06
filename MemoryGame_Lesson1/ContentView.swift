//
//  ContentView.swift
//  MemoryGame_Lesson1
//
//  Created by 苏思成 on 2024/3/6.
//
//  编程时主要修改内容
//  app界面主要展示文件

import SwiftUI //写ui文件(aka view文件 in swiftUI)导入的库，类似c中的库

struct ContentView: View {  //此行定义结构体contentview；此行大括号内容为核心部分
    //contentview后的冒号：定义view协议，下一行代码即为协议所实现的内容
    //紫色：关键字，系统预留，如此行struct；struct在swiftUI中表示结构体概念
   
    var cardCount = 6 //定义卡片数量
    let emojis: Array<String> = ["🤖","🎃","🤡","👽","👀","😃","⚽️","🎣","🍎","🎸","🎹","🗿","🚦"] //声明数组
    
    
    var body: some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 160))], content: { //类似HStack，智能排列
            ForEach(0..<cardCount, id: \.self, content: { index in
                CardView(cardcontent:emojis[index])
            })//批量产出卡片, 0..<定义数组含有多少元素，不包含上限，若0...<则包含上限, \.self指生成控件值作为id号
        })
        
        .foregroundColor(.orange) //也可外部定义卡片边框颜色
        .padding() //zstack所返回的整体至边缘的距离
    }
    
   
} //ContentView终止
    
struct CardView: View{ //定义结构体cardview
    @State var isFaceUp: Bool = true //定义是否卡片向上,不能写在外面，否则全局变量不能一卡一值
    //@State: 表示结构体后续可能在自身里变化
    let cardcontent: String
    
    
    var body: some View{   //定义body计算属性，必须定义body变量且遵循some view，其后大括号body如何计算
        var base = RoundedRectangle(cornerRadius: 12)
        ZStack{ //z轴方向填充,顺序：先出来在底层
            //if(isFaceUp){ //()里写条件，bool值变量，后接控件
            Group{ //成组，统一控制
                base.fill(.white)//避免白色部分不被判定卡面
                base.strokeBorder(lineWidth: 3) //定义圆角矩形, .strokeborder定义填充边框，属性值linewidth
                Text(cardcontent).font(.largeTitle)//定义字体大小
            }
            .opacity(isFaceUp ? 1 : 0) //控制Group里的某一变量
                base.fill().opacity(isFaceUp ? 0 : 1) //默认填充foregroundcolor
                //通过opacity控制不透明度，避免因1个/2个base不同导致每个元素所占空间不同，不让isFaceUp控制生成，而是控制不透明度
                
        }
        .aspectRatio(2/3, contentMode: .fit)//控制卡片长宽比，contentmode中fill铺满，fit适应
        .onTapGesture { //写在zstack外面，被触控触发动作
            isFaceUp.toggle() //取反再赋值，切换卡片向上/下, 亦可isFaceUp=!isFaceUp实现相同功能
            }
        
}
    
    
    struct ContentView_Previews: PreviewProvider {  //开启预览框
        static var previews: some View {
            ContentView()   //表示预览contentview结构体
        }
    }
}
