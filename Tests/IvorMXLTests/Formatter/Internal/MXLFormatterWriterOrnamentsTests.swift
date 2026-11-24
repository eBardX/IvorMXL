// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLFormatterWriterOrnamentsTests {
}

// MARK: -

extension MXLFormatterWriterOrnamentsTests {
    @Test
    func writeEmptyTrillSound_roundTrips() throws {
        let original = try MXLParser.parseEmptyTrillSound(node(#"<shake placement="below" trill-step="unison" beats="6"/>"#))
        let written = writtenNode { $0.writeEmptyTrillSound(.shake, original) }

        #expect(try MXLParser.parseEmptyTrillSound(written) == original)
    }

    @Test
    func writeHorizontalTurn_roundTrips() throws {
        let original = try MXLParser.parseHorizontalTurn(node(#"<delayed-turn slash="yes" start-note="upper"/>"#))
        let written = writtenNode { $0.writeHorizontalTurn(.delayedTurn, original) }

        #expect(try MXLParser.parseHorizontalTurn(written) == original)
    }

    @Test
    func writeMordent_roundTrips() throws {
        let original = try MXLParser.parseMordent(node(#"<mordent long="no" departure="above" last-beat="70"/>"#))
        let written = writtenNode { $0.writeMordent(.mordent, original) }

        #expect(try MXLParser.parseMordent(written) == original)
    }

    @Test
    func writeOrnaments_roundTrips() throws {
        let original = try MXLParser.parseOrnaments(node(#"""
            <ornaments><trill-mark placement="above" trill-step="half" beats="4"/><accidental-mark>sharp</accidental-mark>
            <wavy-line type="start" number="1"/></ornaments>
            """#))
        let written = writtenNode { $0.writeOrnaments(original) }

        #expect(try MXLParser.parseOrnaments(written) == original)
    }

    @Test
    func writeOrnaments_schleiferRoundTrips() throws {
        let original = try MXLParser.parseOrnaments(node(#"""
            <ornaments><schleifer placement="above" default-y="4"/>
            <other-ornament smufl="ornamentHaydn">h</other-ornament></ornaments>
            """#))
        let written = writtenNode { $0.writeOrnaments(original) }

        #expect(try MXLParser.parseOrnaments(written) == original)
    }

    @Test
    func writeTremolo_roundTrips() throws {
        let original = try MXLParser.parseTremolo(node(#"<tremolo type="start" placement="above" smufl="tremolo3">3</tremolo>"#))
        let written = writtenNode { $0.writeTremolo(original) }

        #expect(try MXLParser.parseTremolo(written) == original)
    }

    @Test
    func writeWavyLine_roundTrips() throws {
        let original = try MXLParser.parseWavyLine(node(#"<wavy-line type="stop" number="2" smufl="wiggleTrill" accelerate="no"/>"#))
        let written = writtenNode { $0.writeWavyLine(original) }

        #expect(try MXLParser.parseWavyLine(written) == original)
    }
}
