// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing
import XestiXML

struct MXLParserNoteTests {
}

// MARK: -

extension MXLParserNoteTests {
    @Test
    func parseAccidentalValue_invalidValue() {
        #expect(MXLParser.parseAccidentalValue("bogus") == nil)
    }

    @Test
    func parseAccidentalValue_validValues() {
        #expect(MXLParser.parseAccidentalValue("arrow-down") == .arrowDown)
        #expect(MXLParser.parseAccidentalValue("arrow-up") == .arrowUp)
        #expect(MXLParser.parseAccidentalValue("double-sharp") == .doubleSharp)
        #expect(MXLParser.parseAccidentalValue("double-sharp-down") == .doubleSharpDown)
        #expect(MXLParser.parseAccidentalValue("double-sharp-up") == .doubleSharpUp)
        #expect(MXLParser.parseAccidentalValue("double-slash-flat") == .doubleSlashFlat)
        #expect(MXLParser.parseAccidentalValue("flat") == .flat)
        #expect(MXLParser.parseAccidentalValue("flat-1") == .flat1)
        #expect(MXLParser.parseAccidentalValue("flat-2") == .flat2)
        #expect(MXLParser.parseAccidentalValue("flat-3") == .flat3)
        #expect(MXLParser.parseAccidentalValue("flat-4") == .flat4)
        #expect(MXLParser.parseAccidentalValue("flat-down") == .flatDown)
        #expect(MXLParser.parseAccidentalValue("flat-flat") == .flatFlat)
        #expect(MXLParser.parseAccidentalValue("flat-flat-down") == .flatFlatDown)
        #expect(MXLParser.parseAccidentalValue("flat-flat-up") == .flatFlatUp)
        #expect(MXLParser.parseAccidentalValue("flat-up") == .flatUp)
        #expect(MXLParser.parseAccidentalValue("koron") == .koron)
        #expect(MXLParser.parseAccidentalValue("natural") == .natural)
        #expect(MXLParser.parseAccidentalValue("natural-down") == .naturalDown)
        #expect(MXLParser.parseAccidentalValue("natural-flat") == .naturalFlat)
        #expect(MXLParser.parseAccidentalValue("natural-sharp") == .naturalSharp)
        #expect(MXLParser.parseAccidentalValue("natural-up") == .naturalUp)
        #expect(MXLParser.parseAccidentalValue("other") == .other)
        #expect(MXLParser.parseAccidentalValue("quarter-flat") == .quarterFlat)
        #expect(MXLParser.parseAccidentalValue("quarter-sharp") == .quarterSharp)
        #expect(MXLParser.parseAccidentalValue("sharp") == .sharp)
        #expect(MXLParser.parseAccidentalValue("sharp-1") == .sharp1)
        #expect(MXLParser.parseAccidentalValue("sharp-2") == .sharp2)
        #expect(MXLParser.parseAccidentalValue("sharp-3") == .sharp3)
        #expect(MXLParser.parseAccidentalValue("sharp-5") == .sharp5)
        #expect(MXLParser.parseAccidentalValue("sharp-down") == .sharpDown)
        #expect(MXLParser.parseAccidentalValue("sharp-sharp") == .sharpSharp)
        #expect(MXLParser.parseAccidentalValue("sharp-up") == .sharpUp)
        #expect(MXLParser.parseAccidentalValue("slash-flat") == .slashFlat)
        #expect(MXLParser.parseAccidentalValue("slash-quarter-sharp") == .slashQuarterSharp)
        #expect(MXLParser.parseAccidentalValue("slash-sharp") == .slashSharp)
        #expect(MXLParser.parseAccidentalValue("sori") == .sori)
        #expect(MXLParser.parseAccidentalValue("three-quarters-flat") == .threeQuartersFlat)
        #expect(MXLParser.parseAccidentalValue("three-quarters-sharp") == .threeQuartersSharp)
        #expect(MXLParser.parseAccidentalValue("triple-flat") == .tripleFlat)
        #expect(MXLParser.parseAccidentalValue("triple-sharp") == .tripleSharp)
    }

    @Test
    func parseBeamLevel_validAndInvalid() {
        #expect(MXLParser.parseBeamLevel("8")?.uintValue == 8)
        #expect(MXLParser.parseBeamLevel("9") == nil)
    }

    @Test
    func parseBeamValue_invalidValue() {
        #expect(MXLParser.parseBeamValue("bogus") == nil)
    }

    @Test
    func parseBeamValue_validValues() {
        #expect(MXLParser.parseBeamValue("backward hook") == .backwardHook)
        #expect(MXLParser.parseBeamValue("begin") == .begin)
        #expect(MXLParser.parseBeamValue("continue") == .continue)
        #expect(MXLParser.parseBeamValue("end") == .end)
        #expect(MXLParser.parseBeamValue("forward hook") == .forwardHook)
    }

    @Test
    func parseFan_invalidValue() {
        #expect(MXLParser.parseFan("bogus") == nil)
    }

    @Test
    func parseFan_validValues() {
        #expect(MXLParser.parseFan("accel") == .accel)
        #expect(MXLParser.parseFan("none") == .steady)
        #expect(MXLParser.parseFan("rit") == .rit)
    }

    @Test
    func parseFullNoteContent_unexpectedElementThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseFullNoteContent(node(#"<chord/>"#))
        }
    }

    @Test
    func parseGrace() throws {
        let grace = try MXLParser.parseGrace(node(#"<grace slash="yes" steal-time-previous="25"/>"#))

        #expect(grace.isSlashed == true)
        #expect(grace.stealTimePrevious == 25)
    }

    @Test
    func parseNote() throws {
        let note = try MXLParser.parseNote(node(#"""
            <note default-x="10" dynamics="80" pizzicato="yes"><pitch><step>C</step><alter>1</alter><octave>5</octave>
            </pitch><duration>2</duration><tie type="start"/><voice>1</voice><type size="large">quarter</type><dot/>
            <accidental cautionary="yes">sharp</accidental><time-modification><actual-notes>3</actual-notes>
            <normal-notes>2</normal-notes><normal-type>eighth</normal-type></time-modification><stem>up</stem>
            <notehead filled="no">diamond</notehead><staff>2</staff><beam number="1">begin</beam></note>
            """#))

        guard case let .regularNote(fullNote, duration, tie) = note.content,
              case let .pitch(pitch) = fullNote.content
        else { Issue.record("expected a regular pitched note"); return }

        #expect(pitch.step == .c)
        #expect(pitch.alter == 1)
        #expect(duration.intValue == 2)
        #expect(tie.map(\.kind) == [.start])
        #expect(note.kind?.value == .quarter)
        #expect(note.dot.count == 1)
        #expect(note.isPizzicato == true)
        #expect(note.staff?.uintValue == 2)
    }

    @Test
    func parseNoteContent_cueGrace() throws {
        let content = try MXLParser.parseNoteContent(node("<note><grace/><cue/><rest/></note>"))

        guard case .graceNoteCue = content
        else { Issue.record("expected a cue grace note"); return }
    }

    @Test
    func parseNoteContent_missingDurationThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseNoteContent(node(#"<note><pitch><step>C</step><octave>4</octave></pitch></note>"#))
        }
    }
}
