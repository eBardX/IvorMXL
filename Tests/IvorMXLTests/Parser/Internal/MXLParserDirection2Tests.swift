// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing
import XestiXML

struct MXLParserDirection2Tests {
}

// MARK: -

extension MXLParserDirection2Tests {
    @Test
    func parseDynamicsItem_otherDynamics() throws {
        let item = try MXLParser.parseDynamicsItem(node("<other-dynamics>sfffz</other-dynamics>"))

        guard case let .otherDynamics(text) = item
        else { Issue.record("expected other dynamics"); return }

        #expect(text.value == "sfffz")
    }

    @Test
    func parseHarpPedals() throws {
        let pedals = try MXLParser.parseHarpPedals(node(#"""
            <harp-pedals id="h1" halign="center"><pedal-tuning><pedal-step>D</pedal-step><pedal-alter>0</pedal-alter>
            </pedal-tuning><pedal-tuning><pedal-step>C</pedal-step><pedal-alter>-1</pedal-alter></pedal-tuning>
            </harp-pedals>
            """#))

        #expect(pedals.pedalTuning.map(\.pedalStep) == [.d, .c])
        #expect(pedals.pedalTuning.map(\.pedalAlter) == [0, -1])
    }

    @Test
    func parseOctaveShift() throws {
        let shift = try MXLParser.parseOctaveShift(node(#"<octave-shift type="down" size="15"/>"#))

        #expect(shift.kind == .down)
        #expect(shift.size == 15)
    }

    @Test
    func parsePedal() throws {
        let pedal = try MXLParser.parsePedal(node(#"<pedal type="sostenuto" line="no" sign="yes"/>"#))

        #expect(pedal.kind == .sostenuto)
        #expect(pedal.usesLines == false)
        #expect(pedal.usesSigns == true)
    }

    @Test
    func parsePedalKind_invalidValue() {
        #expect(MXLParser.parsePedalKind("bogus") == nil)
    }

    @Test
    func parsePedalKind_validValues() {
        #expect(MXLParser.parsePedalKind("change") == .change)
        #expect(MXLParser.parsePedalKind("continue") == .continue)
        #expect(MXLParser.parsePedalKind("discontinue") == .discontinue)
        #expect(MXLParser.parsePedalKind("resume") == .resume)
        #expect(MXLParser.parsePedalKind("sostenuto") == .sostenuto)
        #expect(MXLParser.parsePedalKind("start") == .start)
        #expect(MXLParser.parsePedalKind("stop") == .stop)
    }

    @Test
    func parsePedalTuning_missingAlterThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parsePedalTuning(node(#"<pedal-tuning><pedal-step>D</pedal-step></pedal-tuning>"#))
        }
    }

    @Test
    func parsePrincipalVoice_missingSymbolThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parsePrincipalVoice(node(#"<principal-voice type="start"/>"#))
        }
    }

    @Test
    func parsePrincipalVoiceSymbol_invalidValue() {
        #expect(MXLParser.parsePrincipalVoiceSymbol("bogus") == nil)
    }

    @Test
    func parsePrincipalVoiceSymbol_validValues() {
        #expect(MXLParser.parsePrincipalVoiceSymbol("Hauptstimme") == .hauptstimme)
        #expect(MXLParser.parsePrincipalVoiceSymbol("Nebenstimme") == .nebenstimme)
        #expect(MXLParser.parsePrincipalVoiceSymbol("none") == .invisible)
        #expect(MXLParser.parsePrincipalVoiceSymbol("plain") == .plain)
    }

    @Test
    func parseScordatura() throws {
        let scordatura = try MXLParser.parseScordatura(node(#"""
            <scordatura><accord string="1"><tuning-step>E</tuning-step><tuning-octave>4</tuning-octave></accord>
            </scordatura>
            """#))

        // MusicXML declares `string` as an attribute of `<accord>`, but the
        // parser reads it from a child element.
        withKnownIssue("accord string is parsed from a child element, not the attribute") {
            #expect(scordatura.accord.first?.string?.uintValue == 1)
        }
    }

    @Test
    func parseSystemRelation_invalidValue() {
        #expect(MXLParser.parseSystemRelation("bogus") == nil)
    }

    @Test
    func parseSystemRelation_validValues() {
        #expect(MXLParser.parseSystemRelation("also-top") == .alsoTop)
        #expect(MXLParser.parseSystemRelation("none") == .onlyPart)
        #expect(MXLParser.parseSystemRelation("only-top") == .onlyTop)
    }

    @Test
    func parseSystemRelationNumber_invalidValue() {
        #expect(MXLParser.parseSystemRelationNumber("bogus") == nil)
    }

    @Test
    func parseSystemRelationNumber_validAndInvalid() {
        #expect(MXLParser.parseSystemRelationNumber("only-top") == .onlyTop)
        #expect(MXLParser.parseSystemRelationNumber("bogus") == nil)
    }

    @Test
    func parseSystemRelationNumber_validValues() {
        #expect(MXLParser.parseSystemRelationNumber("also-bottom") == .alsoBottom)
        #expect(MXLParser.parseSystemRelationNumber("also-top") == .alsoTop)
        #expect(MXLParser.parseSystemRelationNumber("none") == .onlyPart)
        #expect(MXLParser.parseSystemRelationNumber("only-bottom") == .onlyBottom)
        #expect(MXLParser.parseSystemRelationNumber("only-top") == .onlyTop)
    }

    @Test
    func parseWedge() throws {
        let wedge = try MXLParser.parseWedge(node(#"<wedge type="diminuendo" spread="15" niente="yes"/>"#))

        #expect(wedge.kind == .diminuendo)
        #expect(wedge.spread == 15)
        #expect(wedge.isNiente == true)
    }

    @Test
    func parseWedgeKind_invalidValue() {
        #expect(MXLParser.parseWedgeKind("bogus") == nil)
    }

    @Test
    func parseWedgeKind_validValues() {
        #expect(MXLParser.parseWedgeKind("continue") == .continue)
        #expect(MXLParser.parseWedgeKind("crescendo") == .crescendo)
        #expect(MXLParser.parseWedgeKind("diminuendo") == .diminuendo)
        #expect(MXLParser.parseWedgeKind("stop") == .stop)
    }
}
