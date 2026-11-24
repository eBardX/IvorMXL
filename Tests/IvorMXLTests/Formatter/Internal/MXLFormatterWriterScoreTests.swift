// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing
import XestiXML

struct MXLFormatterWriterScoreTests {
}

// MARK: -

extension MXLFormatterWriterScoreTests {
    @Test
    func writeScorePartwise_roundTrips() throws {
        var diagnostics: [MXLParser.Diagnostic] = []
        let original = try MXLParser.parseScorePartwise(node(#"""
            <score-partwise version="3.1"><movement-title>Etude</movement-title><part-list><score-part id="P1">
            <part-name>Piano</part-name></score-part></part-list><part id="P1">
            <measure number="0" implicit="yes" width="80"><note><rest/><duration>4</duration></note></measure>
            <measure number="1" text="1a"><backup><duration>2</duration></backup></measure></part></score-partwise>
            """#),
                                                        &diagnostics)
        let written = writtenNode { $0.writeScorePartwise(original) }

        #expect(try MXLParser.parseScorePartwise(written, &diagnostics) == original)
    }

    @Test
    func writeScorePartwise_writesVersion() throws {
        let score = try partwise("minimal-partwise.musicxml")
        let written = writtenNode { $0.writeScorePartwise(score) }

        #expect(written.attributes?[.version] == "\(score.version.major).\(score.version.minor)")
    }

    @Test
    func writeScorePartwisePart_writesID() {
        let part = MXLScorePartwise.Part(id: "P9",
                                         measures: [])
        let written = writtenNode { $0.writeScorePartwisePart(part) }

        #expect(written.element == .part)
        #expect(written.attributes?[.id] == "P9")
    }

    @Test
    func writeScorePartwisePartMeasure_omitsFalseFlags() {
        let measure = MXLScorePartwise.Part.Measure(number: "3",
                                                    items: [])
        let written = writtenNode { $0.writeScorePartwisePartMeasure(measure) }

        #expect(written.attributes == [.number: "3"])
    }
}
