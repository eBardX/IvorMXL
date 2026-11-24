// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLFormatterWriterMetronomeTests {
}

// MARK: -

extension MXLFormatterWriterMetronomeTests {
    @Test
    func writeMetronome_beatUnitEquationRoundTrips() throws {
        let original = try MXLParser.parseMetronome(node(#"""
            <metronome><beat-unit>half</beat-unit><beat-unit>quarter</beat-unit><beat-unit-dot/></metronome>
            """#))
        let written = writtenNode { $0.writeMetronome(original) }

        #expect(try MXLParser.parseMetronome(written) == original)
    }

    @Test
    func writeMetronome_metronomeNotesRoundTrips() throws {
        let original = try MXLParser.parseMetronome(node(#"""
            <metronome><metronome-note><metronome-type>eighth</metronome-type>
            <metronome-beam number="1">begin</metronome-beam></metronome-note>
            <metronome-relation>equals</metronome-relation><metronome-note><metronome-type>eighth</metronome-type>
            <metronome-dot/><metronome-tuplet type="start" bracket="yes"><actual-notes>3</actual-notes>
            <normal-notes>2</normal-notes></metronome-tuplet></metronome-note></metronome>
            """#))
        let written = writtenNode { $0.writeMetronome(original) }

        #expect(try MXLParser.parseMetronome(written) == original)
    }

    @Test
    func writeMetronome_perMinuteRoundTrips() throws {
        let original = try MXLParser.parseMetronome(node(#"""
            <metronome parentheses="yes" justify="left"><beat-unit>quarter</beat-unit><beat-unit-dot/>
            <per-minute font-size="10">c. 72</per-minute></metronome>
            """#))
        let written = writtenNode { $0.writeMetronome(original) }

        #expect(try MXLParser.parseMetronome(written) == original)
    }

    @Test
    func writeMetronomeNote_roundTrips() throws {
        let original = try MXLParser.parseMetronomeNote(node(#"""
            <metronome-note><metronome-type>16th</metronome-type><metronome-dot/>
            <metronome-beam number="2">backward hook</metronome-beam><metronome-tied type="start"/></metronome-note>
            """#))
        let written = writtenNode { $0.writeMetronomeNote(original) }

        #expect(try MXLParser.parseMetronomeNote(written) == original)
    }

    @Test
    func writePerMinute_roundTrips() throws {
        let original = try MXLParser.parsePerMinute(node(#"<per-minute font-family="Bravura" font-weight="bold">120</per-minute>"#))
        let written = writtenNode { $0.writePerMinute(original) }

        #expect(try MXLParser.parsePerMinute(written) == original)
    }
}
