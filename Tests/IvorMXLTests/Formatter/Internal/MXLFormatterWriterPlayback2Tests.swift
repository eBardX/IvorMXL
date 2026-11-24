// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLFormatterWriterPlayback2Tests {
}

// MARK: -

extension MXLFormatterWriterPlayback2Tests {
    @Test
    func writeAssess_roundTrips() throws {
        let original = try MXLParser.parseAssess(node(#"<assess type="no" player="P3" time-only="1,3"/>"#))
        let written = writtenNode { $0.writeAssess(original) }

        #expect(try MXLParser.parseAssess(written) == original)
    }

    @Test
    func writeListen_roundTrips() throws {
        let original = try MXLParser.parseListen(node(#"""
            <listen><assess type="yes" player="P1"/><wait player="P2" time-only="2"/>
            <other-listen type="ping">y</other-listen></listen>
            """#))
        let written = writtenNode { $0.writeListen(original) }

        #expect(try MXLParser.parseListen(written) == original)
    }

    @Test
    func writeListening_roundTrips() throws {
        let original = try MXLParser.parseListening(node(#"""
            <listening><sync type="event" latency="20" player="P1"/>
            <other-listening type="cue" time-only="1">x</other-listening><offset sound="yes">2</offset></listening>
            """#))
        let written = writtenNode { $0.writeListening(original) }

        #expect(try MXLParser.parseListening(written) == original)
    }

    @Test
    func writePlay_roundTrips() throws {
        let original = try MXLParser.parsePlay(node(#"""
            <play id="P1-I1"><ipa>a</ipa><mute>straight</mute><semi-pitched>high</semi-pitched>
            <other-play type="x">z</other-play></play>
            """#))
        let written = writtenNode { $0.writePlay(original) }

        #expect(try MXLParser.parsePlay(written) == original)
    }

    @Test
    func writeSync_roundTrips() throws {
        let original = try MXLParser.parseSync(node(#"<sync type="mostly-tempo" latency="5" time-only="2"/>"#))
        let written = writtenNode { $0.writeSync(original) }

        #expect(try MXLParser.parseSync(written) == original)
    }

    @Test
    func writeWait_roundTrips() throws {
        let original = try MXLParser.parseWait(node(#"<wait player="P1"/>"#))
        let written = writtenNode { $0.writeWait(original) }

        #expect(try MXLParser.parseWait(written) == original)
    }
}
