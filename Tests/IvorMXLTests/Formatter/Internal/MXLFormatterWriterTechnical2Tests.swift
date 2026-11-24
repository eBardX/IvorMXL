// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLFormatterWriterTechnical2Tests {
}

// MARK: -

extension MXLFormatterWriterTechnical2Tests {
    @Test
    func formatTipDirection_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLTipDirection] = [.down, .left, .northeast, .northwest, .right, .southeast, .southwest, .up]

        for value in values {
            #expect(MXLParser.parseTipDirection(writer.formatTipDirection(value)) == value)
        }
    }

    @Test
    func writeRelease_roundTrips() throws {
        let original = try MXLParser.parseRelease(node(#"<release offset="4"/>"#))
        let written = writtenNode { $0.writeRelease(original) }

        #expect(try MXLParser.parseRelease(written) == original)
    }

    @Test
    func writeString_roundTrips() throws {
        let original = try MXLParser.parseString(node(#"<string placement="below">6</string>"#))
        let written = writtenNode { $0.writeString(original) }

        #expect(try MXLParser.parseString(written) == original)
    }

    @Test
    func writeStringMute_roundTrips() throws {
        let original = try MXLParser.parseStringMute(node(#"<string-mute type="off" halign="right"/>"#))
        let written = writtenNode { $0.writeStringMute(original) }

        #expect(try MXLParser.parseStringMute(written) == original)
    }

    @Test
    func writeTap_roundTrips() throws {
        let original = try MXLParser.parseTap(node(#"<tap hand="right" placement="above">+</tap>"#))
        let written = writtenNode { $0.writeTap(original) }

        #expect(try MXLParser.parseTap(written) == original)
    }

    @Test
    func writeTechnical_roundTrips() throws {
        let original = try MXLParser.parseTechnical(node(#"""
            <technical><up-bow/><fingering substitution="yes">3</fingering><string>2</string><fret>5</fret>
            <hammer-on type="start" number="1">H</hammer-on><bend shape="curved"><bend-alter>1</bend-alter>
            <release offset="2"/><with-bar>scoop</with-bar></bend><harmonic><artificial/><touching-pitch/></harmonic>
            <tap hand="left">T</tap><other-technical smufl="handbellsDamp3">d</other-technical></technical>
            """#))
        let written = writtenNode { $0.writeTechnical(original) }

        #expect(try MXLParser.parseTechnical(written) == original)
    }
}
