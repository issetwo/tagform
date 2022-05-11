//
//  TagEditField.swift
//  Docanner
//
//  Created by Kazuto Yamada on 2022/02/02.
//

import SwiftUI

/// タグ編集フィールド
@available(iOS 13.0, *)
public struct TagEditField: View {
    /* バインディング */
    @Binding public var list: [TagInfo]
    /* 変数 */
    public var placeholder: String = "Input here..."
    public var defaultTagColer: Color = .black
    public var textColor: Color = .white
    @State private var inputLabel = ""
    
    /* Body */
    public var body: some View {
        if #available(iOS 14.0, *) {
            ScrollViewReader { scrollView in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        /* タグ表示 */
                        ForEach(list) { tag in
                            TagLabel(tagInfo: tag, textColor: textColor, onDelete: {
                                /* 削除ボタン押下時の処理 */
                                deleteTag(tag: tag)
                            })
                        }
                        
                        /* テキスト入力表示 */
                        TextField(placeholder, text: $inputLabel, onCommit: {
                            /* Enter確定後の処理 */
                            appendTag(label: inputLabel)
                        })
                        .id("TextField")
                        /* 入力イベント処理 */
                        .onChange(of: inputLabel) { change in
                            /* スクロールアニメーション */
                            withAnimation {
                                scrollView.scrollTo("TextField")
                            }
                        }
                    }
                }
                .animation(.spring(), value: list.count)
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    /// タグの追加
    /// - Parameter label: タグ表示文字
    private func appendTag(label: String) {
        if label != "" {
            if list.contains(where: {$0.label == label}) == false {
                list.append(.init(id: UUID(), label: label, color: defaultTagColer))
            }
        }
        inputLabel = ""
    }
    
    /// タグの削除
    /// - Parameter tag: タグ情報
    private func deleteTag(tag: TagInfo) {
        list.removeAll(where: {$0.id == tag.id})
    }
}

/// タグ
@available(iOS 13.0, *)
public struct TagLabel: View {
    /* 変数 */
    @ObservedObject public var tagInfo: TagInfo
    public var textColor: Color = .white
    /* 通知 */
    public var onDelete: (() -> Void)? = nil

    /* Body */
    public var body: some View {
        ZStack {
            HStack {
                Text(tagInfo.label)
                    .font(.headline).bold()
                    .foregroundColor(textColor)
                Button(action: {
                    self.onDelete?()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(textColor)
                }
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 5))
            .background(tagInfo.color)
            .clipShape(Capsule())
        }
    }
}

/// タグ情報クラス
@available(iOS 13.0, *)
public class TagInfo: ObservableObject, Identifiable {
    /* 表示情報 */
    @Published public var id: UUID = UUID()
    @Published public var label: String = ""
    @Published public var color: Color = Color("TagDefault")
    
    /// 初期化
    public init(label: String){
        self.label = label
    }
    
    /// 初期化
    public init(label: String, color: Color){
        self.label = label
        self.color = color
    }
    
    /// 初期化
    public init(id: UUID, label: String, color: Color){
        self.id = id
        self.label = label
        self.color = color
    }
}


/// プレビュー：タグ編集フィールド
@available(iOS 13.0, *)
struct TagEditField_Previews: PreviewProvider {
    @State static var tagInfoList: [TagInfo] = [TagInfo]()
    
    /*init(){
        TagEditField_Previews.tagInfoList.append(.init(label: "仕事", color: .red))
        TagEditField_Previews.tagInfoList.append(.init(label: "学校", color: .orange))
        TagEditField_Previews.tagInfoList.append(.init(label: "部活", color: .yellow))
    }*/

    static var previews: some View {
        TagEditField(list: $tagInfoList, placeholder: "タグを追加...", defaultTagColer: .black)
    }
}
