// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLFormatterWriterTechnicalTests {
}

// MARK: -

extension MXLFormatterWriterTechnicalTests {
    @Test
    func writeArrow_roundTrips() throws {
        let original = try MXLParser.parseArrow(node(#"""
            <arrow placement="above" smufl="arrowBlackUp"><arrow-direction>northwest</arrow-direction></arrow>
            """#))
        let written = writtenNode { $0.writeArrow(original) }

        #expect(try MXLParser.parseArrow(written) == original)
    }

    @Test
    func writeBend_roundTrips() throws {
        let original = try MXLParser.parseBend(node(#"""
            <bend shape="curved" accelerate="yes"><bend-alter>0.5</bend-alter><release offset="1"/>
            <with-bar placement="below">dip</with-bar></bend>
            """#))
        let written = writtenNode { $0.writeBend(original) }

        #expect(try MXLParser.parseBend(written) == original)
    }

    @Test
    func writeFingering_roundTrips() throws {
        let original = try MXLParser.parseFingering(node(#"<fingering placement="below">1</fingering>"#))
        let written = writtenNode { $0.writeFingering(original) }

        #expect(try MXLParser.parseFingering(written) == original)
    }

    @Test
    func writeFret_roundTrips() throws {
        let original = try MXLParser.parseFret(node(#"<fret font-size="8">12</fret>"#))
        let written = writtenNode { $0.writeFret(original) }

        #expect(try MXLParser.parseFret(written) == original)
    }

    @Test
    func writeHammerOnPullOff_roundTrips() throws {
        let original = try MXLParser.parseHammerOnPullOff(node(#"<pull-off type="stop" number="2" placement="above">P</pull-off>"#))
        let written = writtenNode { $0.writeHammerOnPullOff(.pullOff, original) }

        #expect(try MXLParser.parseHammerOnPullOff(written) == original)
    }

    @Test
    func writeHandbell_roundTrips() throws {
        let original = try MXLParser.parseHandbell(node(#"<handbell placement="above">martellato</handbell>"#))
        let written = writtenNode { $0.writeHandbell(original) }

        #expect(try MXLParser.parseHandbell(written) == original)
    }

    @Test
    func writeHarmonic_roundTrips() throws {
        let original = try MXLParser.parseHarmonic(node(#"<harmonic print-object="no"><natural/><sounding-pitch/></harmonic>"#))
        let written = writtenNode { $0.writeHarmonic(original) }

        #expect(try MXLParser.parseHarmonic(written) == original)
    }

    @Test
    func writeHarmonMute_roundTrips() throws {
        let original = try MXLParser.parseHarmonMute(node(#"<harmon-mute><harmon-closed location="left">half</harmon-closed></harmon-mute>"#))
        let written = writtenNode { $0.writeHarmonMute(original) }

        #expect(try MXLParser.parseHarmonMute(written) == original)
    }

    @Test
    func writeHeelToe_roundTrips() throws {
        let original = try MXLParser.parseHeelToe(node(#"<toe substitution="yes" placement="below"/>"#))
        let written = writtenNode { $0.writeHeelToe(.toe, original) }

        #expect(try MXLParser.parseHeelToe(written) == original)
    }

    @Test
    func writeHole_roundTrips() throws {
        let original = try MXLParser.parseHole(node(#"<hole placement="above"><hole-closed>yes</hole-closed></hole>"#))
        let written = writtenNode { $0.writeHole(original) }

        #expect(try MXLParser.parseHole(written) == original)
    }
}
