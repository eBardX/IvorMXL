// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing
import XestiXML

struct MXLFormatterWriterDirection2Tests {
}

// MARK: -

extension MXLFormatterWriterDirection2Tests {
    @Test
    func writeAccord_roundTrips() throws {
        let original = try MXLParser.parseAccord(node(#"<accord string="1"><tuning-step>E</tuning-step><tuning-octave>4</tuning-octave></accord>"#))
        let written = writtenNode { $0.writeAccord(original) }

        #expect(try MXLParser.parseAccord(written) == original)
    }

    @Test
    func writeAccord_writesStringAsAttribute() throws {
        let accord = try MXLAccord(tuning: MXLTuning(step: .e,
                                                     octave: #require(MXLOctave(uintValue: 4))),
                                   string: MXLStringNumber(uintValue: 1))
        let written = writtenNode { $0.writeAccord(accord) }

        // MusicXML declares `string` as an attribute of `<accord>`, but the
        // writer emits it as a child element.
        withKnownIssue("accord string is written as a child element, not an attribute") {
            #expect(written.attributes?[.string] == "1")
        }
    }

    @Test
    func writeDynamicsItem_otherDynamicsRoundTrips() throws {
        let original = try MXLParser.parseDynamicsItem(node(#"<other-dynamics smufl="dynamicSforzato">sfffz</other-dynamics>"#))
        let written = writtenNode { $0.writeDynamicsItem(original) }

        #expect(try MXLParser.parseDynamicsItem(written) == original)
    }

    @Test
    func writeDynamicsItem_roundTrips() throws {
        let original = try MXLParser.parseDynamicsItem(node(#"<sffz/>"#))
        let written = writtenNode { $0.writeDynamicsItem(original) }

        #expect(try MXLParser.parseDynamicsItem(written) == original)
    }

    @Test
    func writeHarpPedals_roundTrips() throws {
        let original = try MXLParser.parseHarpPedals(node(#"""
            <harp-pedals id="h1" halign="center"><pedal-tuning><pedal-step>D</pedal-step><pedal-alter>0</pedal-alter>
            </pedal-tuning><pedal-tuning><pedal-step>C</pedal-step><pedal-alter>-1</pedal-alter></pedal-tuning>
            </harp-pedals>
            """#))
        let written = writtenNode { $0.writeHarpPedals(original) }

        #expect(try MXLParser.parseHarpPedals(written) == original)
    }

    @Test
    func writeOctaveShift_roundTrips() throws {
        let original = try MXLParser.parseOctaveShift(node(#"<octave-shift type="up" number="1" size="8" dash-length="3" space-length="2"/>"#))
        let written = writtenNode { $0.writeOctaveShift(original) }

        #expect(try MXLParser.parseOctaveShift(written) == original)
    }

    @Test
    func writeOtherDirection_roundTrips() throws {
        let original = try MXLParser.parseOtherDirection(node(#"<other-direction print-object="no" smufl="pictGlsp">glock</other-direction>"#))
        let written = writtenNode { $0.writeOtherDirection(original) }

        #expect(try MXLParser.parseOtherDirection(written) == original)
    }

    @Test
    func writePedal_roundTrips() throws {
        let original = try MXLParser.parsePedal(node(#"<pedal type="change" number="1" line="yes" sign="no" abbreviated="yes"/>"#))
        let written = writtenNode { $0.writePedal(original) }

        #expect(try MXLParser.parsePedal(written) == original)
    }

    @Test
    func writePedalTuning_roundTrips() throws {
        let original = try MXLParser.parsePedalTuning(node(#"<pedal-tuning><pedal-step>B</pedal-step><pedal-alter>1</pedal-alter></pedal-tuning>"#))
        let written = writtenNode { $0.writePedalTuning(original) }

        #expect(try MXLParser.parsePedalTuning(written) == original)
    }

    @Test
    func writePrincipalVoice_roundTrips() throws {
        let original = try MXLParser.parsePrincipalVoice(node(#"<principal-voice type="start" symbol="Hauptstimme">H</principal-voice>"#))
        let written = writtenNode { $0.writePrincipalVoice(original) }

        #expect(try MXLParser.parsePrincipalVoice(written) == original)
    }

    @Test
    func writeScordatura_roundTrips() throws {
        let original = try MXLParser.parseScordatura(node(#"""
            <scordatura id="sc"><accord string="1"><tuning-step>E</tuning-step><tuning-octave>4</tuning-octave></accord>
            </scordatura>
            """#))
        let written = writtenNode { $0.writeScordatura(original) }

        #expect(try MXLParser.parseScordatura(written) == original)
    }

    @Test
    func writeSegno_roundTrips() throws {
        let original = try MXLParser.parseSegno(node(#"<segno smufl="segnoSerpent1" halign="left"/>"#))
        let written = writtenNode { $0.writeSegno(original) }

        #expect(try MXLParser.parseSegno(written) == original)
    }

    @Test
    func writeStaffDivide_roundTrips() throws {
        let original = try MXLParser.parseStaffDivide(node(#"<staff-divide type="up-down"/>"#))
        let written = writtenNode { $0.writeStaffDivide(original) }

        #expect(try MXLParser.parseStaffDivide(written) == original)
    }

    @Test
    func writeWedge_roundTrips() throws {
        let original = try MXLParser.parseWedge(node(#"<wedge type="crescendo" number="1" spread="0" niente="yes" line-type="dotted"/>"#))
        let written = writtenNode { $0.writeWedge(original) }

        #expect(try MXLParser.parseWedge(written) == original)
    }
}
