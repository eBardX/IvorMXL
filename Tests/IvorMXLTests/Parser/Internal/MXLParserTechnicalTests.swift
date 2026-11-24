// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing
import XestiXML

struct MXLParserTechnicalTests {
}

// MARK: -

extension MXLParserTechnicalTests {
    @Test
    func parseArrow_circular() throws {
        let arrow = try MXLParser.parseArrow(node("<arrow><circular-arrow>clockwise</circular-arrow></arrow>"))

        #expect(arrow.content == .circularArrow(.clockwise))
    }

    @Test
    func parseArrow_direction() throws {
        let arrow = try MXLParser.parseArrow(node(#"""
            <arrow><arrow-direction>up</arrow-direction><arrow-style>double</arrow-style><arrowhead/></arrow>
            """#))

        #expect(arrow.content == .arrowDirection(.up,
                                                 style: .double,
                                                 hasArrowhead: true))
    }

    @Test
    func parseArrowDirection_invalidValue() {
        #expect(MXLParser.parseArrowDirection("bogus") == nil)
    }

    @Test
    func parseArrowDirection_validValues() {
        #expect(MXLParser.parseArrowDirection("down") == .down)
        #expect(MXLParser.parseArrowDirection("left") == .left)
        #expect(MXLParser.parseArrowDirection("left right") == .leftRight)
        #expect(MXLParser.parseArrowDirection("northeast") == .northeast)
        #expect(MXLParser.parseArrowDirection("northeast southwest") == .northeastSouthwest)
        #expect(MXLParser.parseArrowDirection("northwest") == .northwest)
        #expect(MXLParser.parseArrowDirection("northwest southeast") == .northwestSoutheast)
        #expect(MXLParser.parseArrowDirection("other") == .other)
        #expect(MXLParser.parseArrowDirection("right") == .right)
        #expect(MXLParser.parseArrowDirection("southeast") == .southeast)
        #expect(MXLParser.parseArrowDirection("southwest") == .southwest)
        #expect(MXLParser.parseArrowDirection("up") == .up)
        #expect(MXLParser.parseArrowDirection("up down") == .upDown)
    }

    @Test
    func parseArrowStyle_invalidValue() {
        #expect(MXLParser.parseArrowStyle("bogus") == nil)
    }

    @Test
    func parseArrowStyle_validValues() {
        #expect(MXLParser.parseArrowStyle("combined") == .combined)
        #expect(MXLParser.parseArrowStyle("double") == .double)
        #expect(MXLParser.parseArrowStyle("filled") == .filled)
        #expect(MXLParser.parseArrowStyle("hollow") == .hollow)
        #expect(MXLParser.parseArrowStyle("other") == .other)
        #expect(MXLParser.parseArrowStyle("paired") == .paired)
        #expect(MXLParser.parseArrowStyle("single") == .single)
    }

    @Test
    func parseBend() throws {
        let bend = try MXLParser.parseBend(node(#"<bend shape="angled" first-beat="30"><bend-alter>-2</bend-alter><pre-bend/></bend>"#))

        #expect(bend.alter == -2)
        #expect(bend.shape == .angled)
        #expect(bend.sound.firstBeat == 30)
    }

    @Test
    func parseBend_missingAlterThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseBend(node(#"<bend/>"#))
        }
    }

    @Test
    func parseBendShape_invalidValue() {
        #expect(MXLParser.parseBendShape("bogus") == nil)
    }

    @Test
    func parseBendShape_validValues() {
        #expect(MXLParser.parseBendShape("angled") == .angled)
        #expect(MXLParser.parseBendShape("curved") == .curved)
    }

    @Test
    func parseCircularArrow_invalidValue() {
        #expect(MXLParser.parseCircularArrow("bogus") == nil)
    }

    @Test
    func parseCircularArrow_validValues() {
        #expect(MXLParser.parseCircularArrow("anticlockwise") == .anticlockwise)
        #expect(MXLParser.parseCircularArrow("clockwise") == .clockwise)
    }

    @Test
    func parseFingering() throws {
        let fingering = try MXLParser.parseFingering(node(#"<fingering substitution="yes" alternate="no">4</fingering>"#))

        #expect(fingering.value == "4")
        #expect(fingering.isSubstitute == true)
        #expect(fingering.isAlternate == false)
    }

    @Test
    func parseHandbellValue_invalidValue() {
        #expect(MXLParser.parseHandbellValue("bogus") == nil)
    }

    @Test
    func parseHandbellValue_validValues() {
        #expect(MXLParser.parseHandbellValue("belltree") == .belltree)
        #expect(MXLParser.parseHandbellValue("damp") == .damp)
        #expect(MXLParser.parseHandbellValue("echo") == .echo)
        #expect(MXLParser.parseHandbellValue("gyro") == .gyro)
        #expect(MXLParser.parseHandbellValue("hand martellato") == .handMartellato)
        #expect(MXLParser.parseHandbellValue("mallet lift") == .malletLift)
        #expect(MXLParser.parseHandbellValue("mallet table") == .malletTable)
        #expect(MXLParser.parseHandbellValue("martellato") == .martellato)
        #expect(MXLParser.parseHandbellValue("martellato lift") == .martellatoLift)
        #expect(MXLParser.parseHandbellValue("muted martellato") == .mutedMartellato)
        #expect(MXLParser.parseHandbellValue("pluck lift") == .pluckLift)
        #expect(MXLParser.parseHandbellValue("swing") == .swing)
    }

    @Test
    func parseHarmonClosedLocation_invalidValue() {
        #expect(MXLParser.parseHarmonClosedLocation("bogus") == nil)
    }

    @Test
    func parseHarmonClosedLocation_validValues() {
        #expect(MXLParser.parseHarmonClosedLocation("bottom") == .bottom)
        #expect(MXLParser.parseHarmonClosedLocation("left") == .left)
        #expect(MXLParser.parseHarmonClosedLocation("right") == .right)
        #expect(MXLParser.parseHarmonClosedLocation("top") == .top)
    }

    @Test
    func parseHarmonClosedValue_invalidValue() {
        #expect(MXLParser.parseHarmonClosedValue("bogus") == nil)
    }

    @Test
    func parseHarmonClosedValue_validValues() {
        #expect(MXLParser.parseHarmonClosedValue("half") == .half)
        #expect(MXLParser.parseHarmonClosedValue("no") == .no)
        #expect(MXLParser.parseHarmonClosedValue("yes") == .yes)
    }

    @Test
    func parseHarmonMute_missingClosedThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseHarmonMute(node(#"<harmon-mute/>"#))
        }
    }

    @Test
    func parseHole() throws {
        let hole = try MXLParser.parseHole(node(#"""
            <hole><hole-type>thumb</hole-type><hole-closed location="top">half</hole-closed>
            <hole-shape>circle</hole-shape></hole>
            """#))

        #expect(hole.kind == "thumb")
        #expect(hole.closed.value == .half)
        #expect(hole.closed.location == .top)
    }
}
