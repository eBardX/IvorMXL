// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
@testable import IvorMXL
import Testing

struct MXLParserDocumentTests {
}

// MARK: -

extension MXLParserDocumentTests {
    @Test
    func parse_scorePartwise() throws {
        let (document, diagnostics) = try MXLParser.parse(Data(#"""
            <score-partwise version="4.0"><part-list><score-part id="P1"><part-name>A</part-name></score-part></part-list>
            <part id="P1"><measure number="1"/></part></score-partwise>
            """#.utf8))

        guard case .scorePartwise = document.content
        else { Issue.record("expected a part-wise score"); return }

        #expect(diagnostics.isEmpty)
        #expect(!document.isNormalized)
    }

    @Test
    func parseContent_unexpectedRootThrows() {
        var diagnostics: [MXLParser.Diagnostic] = []

        #expect(throws: (any Error).self) {
            try MXLParser.parseContent(Data("<container/>".utf8),
                                       &diagnostics)
        }
    }

    @Test
    func parseDocumentVersion_malformed() throws {
        var diagnostics: [MXLParser.Diagnostic] = []
        let version = try MXLParser.parseDocumentVersion(node(#"<opus version="4"/>"#),
                                                         &diagnostics)

        #expect(version == nil)
        #expect(diagnostics == [.malformedVersion("4")])
    }

    @Test
    func parseDocumentVersion_missing() throws {
        var diagnostics: [MXLParser.Diagnostic] = []
        let version = try MXLParser.parseDocumentVersion(node("<opus/>"),
                                                         &diagnostics)

        #expect(version == nil)
        #expect(diagnostics == [.defaultedVersion])
    }

    @Test
    func parseDocumentVersion_valid() throws {
        var diagnostics: [MXLParser.Diagnostic] = []
        let version = try MXLParser.parseDocumentVersion(node(#"<opus version="3.1"/>"#),
                                                         &diagnostics)

        #expect(version == .v3_1)
        #expect(diagnostics.isEmpty)
    }
}
