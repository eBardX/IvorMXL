// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing
import XestiXML

struct MXLParserNote2Tests {
}

// MARK: -

extension MXLParserNote2Tests {
    @Test
    func parseNoteKindValue_invalidValue() {
        #expect(MXLParser.parseNoteKindValue("bogus") == nil)
    }

    @Test
    func parseNoteKindValue_validValues() {
        #expect(MXLParser.parseNoteKindValue("1024th") == .n1024th)
        #expect(MXLParser.parseNoteKindValue("128th") == .n128th)
        #expect(MXLParser.parseNoteKindValue("16th") == .n16th)
        #expect(MXLParser.parseNoteKindValue("256th") == .n256th)
        #expect(MXLParser.parseNoteKindValue("32nd") == .n32nd)
        #expect(MXLParser.parseNoteKindValue("512th") == .n512th)
        #expect(MXLParser.parseNoteKindValue("64th") == .n64th)
        #expect(MXLParser.parseNoteKindValue("breve") == .breve)
        #expect(MXLParser.parseNoteKindValue("eighth") == .eighth)
        #expect(MXLParser.parseNoteKindValue("half") == .half)
        #expect(MXLParser.parseNoteKindValue("long") == .long)
        #expect(MXLParser.parseNoteKindValue("maxima") == .maxima)
        #expect(MXLParser.parseNoteKindValue("quarter") == .quarter)
        #expect(MXLParser.parseNoteKindValue("whole") == .whole)
    }

    @Test
    func parseNoteNoteheadValue_invalidValue() {
        #expect(MXLParser.parseNoteNoteheadValue("bogus") == nil)
    }

    @Test
    func parseNoteNoteheadValue_validValues() {
        #expect(MXLParser.parseNoteNoteheadValue("arrow down") == .arrowDown)
        #expect(MXLParser.parseNoteNoteheadValue("arrow up") == .arrowUp)
        #expect(MXLParser.parseNoteNoteheadValue("back slashed") == .backSlashed)
        #expect(MXLParser.parseNoteNoteheadValue("circle dot") == .circleDot)
        #expect(MXLParser.parseNoteNoteheadValue("circle-x") == .circleX)
        #expect(MXLParser.parseNoteNoteheadValue("circled") == .circled)
        #expect(MXLParser.parseNoteNoteheadValue("cluster") == .cluster)
        #expect(MXLParser.parseNoteNoteheadValue("cross") == .cross)
        #expect(MXLParser.parseNoteNoteheadValue("diamond") == .diamond)
        #expect(MXLParser.parseNoteNoteheadValue("do") == .do)
        #expect(MXLParser.parseNoteNoteheadValue("fa") == .fa)
        #expect(MXLParser.parseNoteNoteheadValue("fa up") == .faUp)
        #expect(MXLParser.parseNoteNoteheadValue("inverted triangle") == .invertedTriangle)
        #expect(MXLParser.parseNoteNoteheadValue("la") == .la)
        #expect(MXLParser.parseNoteNoteheadValue("left triangle") == .leftTriangle)
        #expect(MXLParser.parseNoteNoteheadValue("mi") == .mi)
        #expect(MXLParser.parseNoteNoteheadValue("none") == .hidden)
        #expect(MXLParser.parseNoteNoteheadValue("normal") == .normal)
        #expect(MXLParser.parseNoteNoteheadValue("other") == .other)
        #expect(MXLParser.parseNoteNoteheadValue("re") == .re)
        #expect(MXLParser.parseNoteNoteheadValue("rectangle") == .rectangle)
        #expect(MXLParser.parseNoteNoteheadValue("slash") == .slash)
        #expect(MXLParser.parseNoteNoteheadValue("slashed") == .slashed)
        #expect(MXLParser.parseNoteNoteheadValue("so") == .so)
        #expect(MXLParser.parseNoteNoteheadValue("square") == .square)
        #expect(MXLParser.parseNoteNoteheadValue("ti") == .ti)
        #expect(MXLParser.parseNoteNoteheadValue("triangle") == .triangle)
        #expect(MXLParser.parseNoteNoteheadValue("x") == .x)
    }

    @Test
    func parseNoteSizeKind_invalidValue() {
        #expect(MXLParser.parseNoteSizeKind("bogus") == nil)
    }

    @Test
    func parseNoteSizeKind_validValues() {
        #expect(MXLParser.parseNoteSizeKind("cue") == .cue)
        #expect(MXLParser.parseNoteSizeKind("grace") == .grace)
        #expect(MXLParser.parseNoteSizeKind("grace-cue") == .graceCue)
        #expect(MXLParser.parseNoteSizeKind("large") == .large)
    }

    @Test
    func parseOctave_validAndInvalid() {
        #expect(MXLParser.parseOctave("9")?.uintValue == 9)
        #expect(MXLParser.parseOctave("10") == nil)
    }

    @Test
    func parsePitch_missingOctaveThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parsePitch(node(#"<pitch><step>A</step></pitch>"#))
        }
    }

    @Test
    func parseRest_displayStepOctave() throws {
        let rest = try MXLParser.parseRest(node(#"<rest measure="yes"><display-step>B</display-step><display-octave>4</display-octave></rest>"#))

        #expect(rest.measure == true)
        #expect(rest.displayStepOctave?.displayStep == .b)
    }

    @Test
    func parseStem() throws {
        let stem = try MXLParser.parseStem(node(#"<stem default-y="-40">down</stem>"#))

        #expect(stem.value == .down)
        #expect(stem.yPosition.defaultY == -40)
    }

    @Test
    func parseStemValue_invalidValue() {
        #expect(MXLParser.parseStemValue("bogus") == nil)
    }

    @Test
    func parseStemValue_validValues() {
        #expect(MXLParser.parseStemValue("double") == .double)
        #expect(MXLParser.parseStemValue("down") == .down)
        #expect(MXLParser.parseStemValue("none") == .absent)
        #expect(MXLParser.parseStemValue("up") == .up)
    }

    @Test
    func parseStep_invalidValue() {
        #expect(MXLParser.parseStep("bogus") == nil)
    }

    @Test
    func parseStep_validValues() {
        #expect(MXLParser.parseStep("A") == .a)
        #expect(MXLParser.parseStep("B") == .b)
        #expect(MXLParser.parseStep("C") == .c)
        #expect(MXLParser.parseStep("D") == .d)
        #expect(MXLParser.parseStep("E") == .e)
        #expect(MXLParser.parseStep("F") == .f)
        #expect(MXLParser.parseStep("G") == .g)
    }

    @Test
    func parseTie_missingTypeThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseTie(node(#"<tie/>"#))
        }
    }

    @Test
    func parseTimeModification() throws {
        let modification = try MXLParser.parseTimeModification(node(#"""
            <time-modification><actual-notes>5</actual-notes><normal-notes>4</normal-notes><normal-type>16th</normal-type>
            <normal-dot/></time-modification>
            """#))

        #expect(modification.actualNotes == 5)
        #expect(modification.normalNotes == 4)
        #expect(modification.group?.normalKind == .n16th)
    }
}
