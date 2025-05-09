// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct SheetConfig {
    public var maxDetent: PresentationDetent
    public var cornerRadius: CGFloat = 30
    public var isInteractiveDismissDisabled: Bool = false
    public var horizontalPadding: CGFloat = 15
    public var bottomPadding: CGFloat = 15
    public var blurbackground: Bool = false
    
    public init(
        maxDetent: PresentationDetent,
        cornerRadius: CGFloat = 30,
        isInteractiveDismissDisabled: Bool = false,
        horizontalPadding: CGFloat = 15,
        bottomPadding: CGFloat = 15
    ) {
        self.maxDetent = maxDetent
        self.cornerRadius = cornerRadius
        self.isInteractiveDismissDisabled = isInteractiveDismissDisabled
        self.horizontalPadding = horizontalPadding
        self.bottomPadding = bottomPadding
    }
}

extension View {
    public func sheetView<Content: View>(
        _ show: Binding<Bool>,
        config: SheetConfig = .init(maxDetent: .fraction(0.99)),
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self
            .sheet(isPresented: show) {
                content()
                    .background {
                        if config.blurbackground {
                            ZStack {
                                RoundedRectangle(cornerRadius: config.cornerRadius, style: .continuous)
                                    .stroke(.thinMaterial, style: .init(lineWidth: 3, lineCap: .round, lineJoin: .round))
                                
                                RoundedRectangle(cornerRadius: config.cornerRadius, style: .continuous)
                                    .fill(.ultraThinMaterial.shadow(.inner(color: .black.opacity(0.2), radius: 10)))
                            }
                            .compositingGroup()
                        }
                    }
                    .clipShape(.rect(cornerRadius: config.cornerRadius))
                    .padding(.horizontal, config.horizontalPadding)
                    .padding(.bottom, config.bottomPadding)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .presentationDetents([config.maxDetent])
                    .presentationCornerRadius(0)
                    .presentationBackground(.clear)
                    .presentationDragIndicator(.hidden)
                    .interactiveDismissDisabled(config.isInteractiveDismissDisabled)
                    .background(RemoveSheetShadow())
            }
    }
}

struct RemoveSheetShadow: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            if let shadowView = view.dropShadowView {
                shadowView.layer.shadowColor = UIColor.clear.cgColor
            }
        }
        view.backgroundColor = .clear
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

extension UIView {
    var dropShadowView: UIView? {
        if let superview, String(describing: type(of: superview))  == "UIDropShadowView" {
            return superview
        }
        return superview?.dropShadowView
    }
}
