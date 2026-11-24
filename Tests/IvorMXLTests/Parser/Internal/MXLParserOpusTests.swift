// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLParserOpusTests {
}

// MARK: -

extension MXLParserOpusTests {
    @Test
    func parseOpus() throws {
        var diagnostics: [MXLParser.Diagnostic] = []
        let opus = try MXLParser.parseOpus(node(#"""
            <opus xmlns:xlink="http://www.w3.org/1999/xlink" version="4.0"><title>Cycle</title>
            <score xlink:href="a.xml" new-page="yes"/><opus-link xlink:href="b.xml"/></opus>
            """#),
                                           &diagnostics)

        #expect(opus.title == "Cycle")
        #expect(opus.items.count == 2)
        #expect(diagnostics.isEmpty)
    }

    @Test
    func parseOpusItem_score() throws {
        var diagnostics: [MXLParser.Diagnostic] = []
        let item = try MXLParser.parseOpusItem(node(#"<score xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="a.xml" new-page="no"/>"#),
                                               &diagnostics)

        guard case let .score(score) = item
        else { Issue.record("expected a score item"); return }

        #expect(score.xlink.href == "a.xml")
        #expect(score.newPage == false)
    }

    @Test
    func parseOpusItem_unexpectedElementThrows() {
        var diagnostics: [MXLParser.Diagnostic] = []

        #expect(throws: (any Error).self) {
            try MXLParser.parseOpusItem(node("<title>x</title>"),
                                        &diagnostics)
        }
    }
}
