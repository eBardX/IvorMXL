// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLFormatterWriterPercussion2Tests {
}

// MARK: -

extension MXLFormatterWriterPercussion2Tests {
    @Test
    func writePercussion_otherPercussionRoundTrips() throws {
        let original = try MXLParser.parsePercussion(node(#"""
            <percussion><other-percussion smufl="pictWhistle">whistle</other-percussion></percussion>
            """#))
        let written = writtenNode { $0.writePercussion(original) }

        #expect(try MXLParser.parsePercussion(written) == original)
    }

    @Test
    func writePercussion_stickLocationRoundTrips() throws {
        let original = try MXLParser.parsePercussion(node(#"<percussion halign="center"><stick-location>cymbal bell</stick-location></percussion>"#))
        let written = writtenNode { $0.writePercussion(original) }

        #expect(try MXLParser.parsePercussion(written) == original)
    }

    @Test
    func writePercussion_timpaniRoundTrips() throws {
        let original = try MXLParser.parsePercussion(node(#"<percussion><timpani/></percussion>"#))
        let written = writtenNode { $0.writePercussion(original) }

        #expect(try MXLParser.parsePercussion(written) == original)
    }

    @Test
    func writePitched_roundTrips() throws {
        let original = try MXLParser.parsePitched(node(#"<pitched smufl="pictXyl">xylophone</pitched>"#))
        let written = writtenNode { $0.writePitched(original) }

        #expect(try MXLParser.parsePitched(written) == original)
    }

    @Test
    func writeStick_roundTrips() throws {
        let original = try MXLParser.parseStick(node(#"""
            <stick tip="left" dashed-circle="yes"><stick-type>bass drum</stick-type><stick-material>soft</stick-material>
            </stick>
            """#))
        let written = writtenNode { $0.writeStick(original) }

        #expect(try MXLParser.parseStick(written) == original)
    }

    @Test
    func writeWood_roundTrips() throws {
        let original = try MXLParser.parseWood(node(#"<wood>temple block</wood>"#))
        let written = writtenNode { $0.writeWood(original) }

        #expect(try MXLParser.parseWood(written) == original)
    }
}
