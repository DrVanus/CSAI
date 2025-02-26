//
//  PDFService.swift
//  CryptoSageAI
//
//  Created by DM on 2/26/25.
//


// PDFService.swift
#if canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
#endif

import SwiftUI
import PDFKit

struct PDFService {
    
    static func makePDF(from text: String) -> Data? {
        #if targetEnvironment(macCatalyst) || os(iOS)
        return makePDFiOSStyle(from: text)
        #elseif os(macOS)
        return makePDFmacStyle(from: text)
        #else
        return nil
        #endif
    }
    
    // MARK: - iOS / Catalyst Approach
    #if canImport(UIKit)
    private static func makePDFiOSStyle(from text: String) -> Data? {
        let pageWidth: CGFloat = 612
        let pageHeight: CGFloat = 792
        let pageBounds = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        
        let format = UIGraphicsPDFRendererFormat()
        let renderer = UIGraphicsPDFRenderer(bounds: pageBounds, format: format)
        
        let data = renderer.pdfData { context in
            context.beginPage()
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            
            let attributes: [NSAttributedString.Key : Any] = [
                .font: UIFont.systemFont(ofSize: 14),
                .paragraphStyle: paragraphStyle
            ]
            
            (text as NSString).draw(
                in: pageBounds.insetBy(dx: 20, dy: 20),
                withAttributes: attributes
            )
        }
        
        return data
    }
    #endif
    
    // MARK: - macOS Approach (non-Catalyst)
    #if canImport(AppKit) && !targetEnvironment(macCatalyst)
    private static func makePDFmacStyle(from text: String) -> Data? {
        let pdfDocument = PDFDocument()
        
        let nsImage = imageFromText(text)
        if let pdfPage = PDFPage(image: nsImage) {
            pdfDocument.insert(pdfPage, at: 0)
        }
        
        return pdfDocument.dataRepresentation()
    }
    
    private static func imageFromText(_ text: String) -> NSImage {
        let size = NSSize(width: 612, height: 792)
        let image = NSImage(size: size)
        
        image.lockFocus()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 14),
            .paragraphStyle: paragraphStyle
        ]
        
        let rect = NSRect(origin: .zero, size: size).insetBy(dx: 20, dy: 20)
        (text as NSString).draw(in: rect, withAttributes: attributes)
        
        image.unlockFocus()
        
        return image
    }
    #endif
}
