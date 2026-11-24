// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLFormatterWriterNote2Tests {
}

// MARK: -

extension MXLFormatterWriterNote2Tests {
    @Test
    func writeNotehead_roundTrips() throws {
        let original = try MXLParser.parseNoteNotehead(node(##"""
            <notehead filled="yes" parentheses="yes" smufl="noteheadXBlack" color="#000080">x</notehead>
            """##))
        let written = writtenNode { $0.writeNotehead(original) }

        #expect(try MXLParser.parseNoteNotehead(written) == original)
    }

    @Test
    func writeNoteKind_roundTrips() throws {
        let original = try MXLParser.parseNoteKind(node(#"<type size="cue">eighth</type>"#))
        let written = writtenNode { $0.writeNoteKind(original) }

        #expect(try MXLParser.parseNoteKind(written) == original)
    }

    @Test
    func writeNoteSize_roundTrips() throws {
        let original = try MXLParser.parseNoteSize(node(#"<note-size type="grace-cue">60</note-size>"#))
        let written = writtenNode { $0.writeNoteSize(original) }

        #expect(try MXLParser.parseNoteSize(written) == original)
    }

    @Test
    func writePitch_roundTrips() throws {
        let original = try MXLParser.parsePitch(node(#"<pitch><step>E</step><alter>-0.5</alter><octave>3</octave></pitch>"#))
        let written = writtenNode { $0.writePitch(original) }

        #expect(try MXLParser.parsePitch(written) == original)
    }

    @Test
    func writeRest_roundTrips() throws {
        let original = try MXLParser.parseRest(node(#"<rest measure="yes"><display-step>D</display-step><display-octave>5</display-octave></rest>"#))
        let written = writtenNode { $0.writeRest(original) }

        #expect(try MXLParser.parseRest(written) == original)
    }

    @Test
    func writeStem_roundTrips() throws {
        let original = try MXLParser.parseStem(node(#"<stem default-y="30" relative-y="2">double</stem>"#))
        let written = writtenNode { $0.writeStem(original) }

        #expect(try MXLParser.parseStem(written) == original)
    }

    @Test
    func writeTie_roundTrips() throws {
        let original = try MXLParser.parseTie(node(#"<tie type="stop" time-only="1,2"/>"#))
        let written = writtenNode { $0.writeTie(original) }

        #expect(try MXLParser.parseTie(written) == original)
    }

    @Test
    func writeTimeModification_roundTrips() throws {
        let original = try MXLParser.parseTimeModification(node(#"""
            <time-modification><actual-notes>3</actual-notes><normal-notes>2</normal-notes>
            <normal-type>quarter</normal-type><normal-dot/></time-modification>
            """#))
        let written = writtenNode { $0.writeTimeModification(original) }

        #expect(try MXLParser.parseTimeModification(written) == original)
    }

    @Test
    func writeUnpitched_roundTrips() throws {
        let original = try MXLParser.parseUnpitched(node(#"<unpitched><display-step>F</display-step><display-octave>4</display-octave></unpitched>"#))
        let written = writtenNode { $0.writeUnpitched(original) }

        #expect(try MXLParser.parseUnpitched(written) == original)
    }
}
