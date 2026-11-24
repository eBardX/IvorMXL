// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing
import XestiXML

struct MXLParserOrnamentsTests {
}

// MARK: -

extension MXLParserOrnamentsTests {
    @Test
    func parseMordent() throws {
        let mordent = try MXLParser.parseMordent(node(#"<inverted-mordent long="yes" approach="below" start-note="main"/>"#))

        #expect(mordent.isLong == true)
        #expect(mordent.approach == .below)
        #expect(mordent.trillSound.startNote == .main)
    }

    @Test
    func parseOrnaments_entries() throws {
        let ornaments = try MXLParser.parseOrnaments(node(#"""
            <ornaments><trill-mark placement="above" trill-step="half" beats="4"/><accidental-mark>sharp</accidental-mark>
            <wavy-line type="start" number="1"/></ornaments>
            """#))

        #expect(ornaments.entries.count == 2)
        #expect(ornaments.entries.first?.accidentalMarks.count == 1)
    }

    @Test
    func parseTremolo() throws {
        let tremolo = try MXLParser.parseTremolo(node(#"<tremolo type="unmeasured">0</tremolo>"#))

        #expect(tremolo.kind == .unmeasured)
        #expect(tremolo.value.uintValue == 0)
    }

    @Test
    func parseTremoloKind_invalidValue() {
        #expect(MXLParser.parseTremoloKind("bogus") == nil)
    }

    @Test
    func parseTremoloKind_validValues() {
        #expect(MXLParser.parseTremoloKind("single") == .single)
        #expect(MXLParser.parseTremoloKind("start") == .start)
        #expect(MXLParser.parseTremoloKind("stop") == .stop)
        #expect(MXLParser.parseTremoloKind("unmeasured") == .unmeasured)
    }

    @Test
    func parseTremoloMarks_validAndInvalid() {
        #expect(MXLParser.parseTremoloMarks("8")?.uintValue == 8)
        #expect(MXLParser.parseTremoloMarks("9") == nil)
    }

    @Test
    func parseTrillSound() throws {
        let sound = try MXLParser.parseTrillSound(node(#"""
            <trill-mark start-note="below" two-note-turn="whole" accelerate="yes" second-beat="12" last-beat="24"/>
            """#))

        #expect(sound == MXLTrillSound(startNote: .below,
                                       twoNoteTurn: .whole,
                                       accelerates: true,
                                       secondBeat: 12,
                                       lastBeat: 24))
    }

    @Test
    func parseTrillStep_invalidValue() {
        #expect(MXLParser.parseTrillStep("bogus") == nil)
    }

    @Test
    func parseTrillStep_validValues() {
        #expect(MXLParser.parseTrillStep("half") == .half)
        #expect(MXLParser.parseTrillStep("unison") == .unison)
        #expect(MXLParser.parseTrillStep("whole") == .whole)
    }

    @Test
    func parseTwoNoteTurn_invalidValue() {
        #expect(MXLParser.parseTwoNoteTurn("bogus") == nil)
    }

    @Test
    func parseTwoNoteTurn_validValues() {
        #expect(MXLParser.parseTwoNoteTurn("half") == .half)
        #expect(MXLParser.parseTwoNoteTurn("none") == .omitted)
        #expect(MXLParser.parseTwoNoteTurn("whole") == .whole)
    }

    @Test
    func parseWavyLine_missingTypeThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseWavyLine(node(#"<wavy-line/>"#))
        }
    }
}
