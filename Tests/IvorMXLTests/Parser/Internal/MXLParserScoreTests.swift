// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLParserScoreTests {
}

// MARK: -

extension MXLParserScoreTests {
    @Test
    func parseMeasureText_validAndInvalid() {
        #expect(MXLParser.parseMeasureText("1a")?.stringValue == "1a")
        #expect(MXLParser.parseMeasureText("") == nil)
    }

    @Test
    func parseScorePartwise() throws {
        var diagnostics: [MXLParser.Diagnostic] = []
        let score = try MXLParser.parseScorePartwise(node(#"""
            <score-partwise version="3.1"><movement-title>Etude</movement-title><part-list><score-part id="P1">
            <part-name>Piano</part-name></score-part></part-list><part id="P1">
            <measure number="0" implicit="yes" width="80"><note><rest/><duration>4</duration></note></measure>
            <measure number="1" text="1a"><backup><duration>2</duration></backup></measure></part></score-partwise>
            """#),
                                                     &diagnostics)

        #expect(score.version == .v3_1)
        #expect(score.movementTitle == "Etude")
        #expect(score.parts.first?.measures.map(\.number) == ["0", "1"])
        #expect(score.parts.first?.measures.first?.isImplicit == true)
        #expect(score.parts.first?.measures.last?.text?.stringValue == "1a")
    }

    @Test
    func parseScorePartwise_missingVersionIsDiagnosed() throws {
        var diagnostics: [MXLParser.Diagnostic] = []
        let score = try MXLParser.parseScorePartwise(node(#"""
            <score-partwise><part-list><score-part id="P1"><part-name>A</part-name></score-part></part-list><part id="P1">
            <measure number="1"/></part></score-partwise>
            """#),
                                                     &diagnostics)

        #expect(diagnostics.contains(.defaultedVersion))
        #expect(score.parts.count == 1)
    }

    @Test
    func parseScorePartwise_wrongRootThrows() {
        var diagnostics: [MXLParser.Diagnostic] = []

        #expect(throws: (any Error).self) {
            try MXLParser.parseScorePartwise(node(#"<score-timewise version="4.0"/>"#),
                                             &diagnostics)
        }
    }

    @Test
    func parseScorePartwisePartMeasure_missingNumberThrows() {
        var diagnostics: [MXLParser.Diagnostic] = []

        #expect(throws: (any Error).self) {
            try MXLParser.parseScorePartwisePartMeasure(node("<measure/>"),
                                                        &diagnostics)
        }
    }

    @Test
    func parseScoreTimewise() throws {
        var diagnostics: [MXLParser.Diagnostic] = []
        let score = try MXLParser.parseScoreTimewise(node(#"""
            <score-timewise version="4.0"><part-list><score-part id="P1"><part-name>Flute</part-name></score-part>
            </part-list><measure number="1" non-controlling="yes"><part id="P1"><forward><duration>4</duration></forward>
            </part></measure></score-timewise>
            """#),
                                                     &diagnostics)

        #expect(score.measures.count == 1)
        #expect(score.measures.first?.isNonControlling == true)
        #expect(score.measures.first?.parts.map(\.id) == ["P1"])
    }
}
