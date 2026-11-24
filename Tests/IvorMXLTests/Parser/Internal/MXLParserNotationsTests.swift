// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing
import XestiXML

struct MXLParserNotationsTests {
}

// MARK: -

extension MXLParserNotationsTests {
    @Test
    func parseArpeggiate() throws {
        let arpeggiate = try MXLParser.parseArpeggiate(node(#"<arpeggiate direction="down" unbroken="yes"/>"#))

        #expect(arpeggiate.direction == .down)
        #expect(arpeggiate.isUnbroken == true)
    }

    @Test
    func parseBreathMarkValue_invalidValue() {
        #expect(MXLParser.parseBreathMarkValue("bogus") == nil)
    }

    @Test
    func parseBreathMarkValue_validValues() {
        #expect(MXLParser.parseBreathMarkValue("") == .empty)
        #expect(MXLParser.parseBreathMarkValue("comma") == .comma)
        #expect(MXLParser.parseBreathMarkValue("salzedo") == .salzedo)
        #expect(MXLParser.parseBreathMarkValue("tick") == .tick)
        #expect(MXLParser.parseBreathMarkValue("upbow") == .upbow)
    }

    @Test
    func parseCaesuraValue_invalidValue() {
        #expect(MXLParser.parseCaesuraValue("bogus") == nil)
    }

    @Test
    func parseCaesuraValue_validValues() {
        #expect(MXLParser.parseCaesuraValue("") == .empty)
        #expect(MXLParser.parseCaesuraValue("curved") == .curved)
        #expect(MXLParser.parseCaesuraValue("normal") == .normal)
        #expect(MXLParser.parseCaesuraValue("short") == .short)
        #expect(MXLParser.parseCaesuraValue("single") == .single)
        #expect(MXLParser.parseCaesuraValue("thick") == .thick)
    }

    @Test
    func parseFermataShape_invalidValue() {
        #expect(MXLParser.parseFermataShape("bogus") == nil)
    }

    @Test
    func parseFermataShape_validValues() {
        #expect(MXLParser.parseFermataShape("") == .empty)
        #expect(MXLParser.parseFermataShape("angled") == .angled)
        #expect(MXLParser.parseFermataShape("curlew") == .curlew)
        #expect(MXLParser.parseFermataShape("double-angled") == .doubleAngled)
        #expect(MXLParser.parseFermataShape("double-dot") == .doubleDot)
        #expect(MXLParser.parseFermataShape("double-square") == .doubleSquare)
        #expect(MXLParser.parseFermataShape("half-curve") == .halfCurve)
        #expect(MXLParser.parseFermataShape("normal") == .normal)
        #expect(MXLParser.parseFermataShape("square") == .square)
    }

    @Test
    func parseNotations() throws {
        let notations = try MXLParser.parseNotations(node(#"""
            <notations print-object="no"><slur type="start"/><fermata/><tied type="stop"/></notations>
            """#))

        #expect(notations.items.count == 3)
        #expect(notations.printsObject == false)
    }

    @Test
    func parseNotationsItem_unexpectedElementThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseNotationsItem(node(#"<pitch/>"#))
        }
    }

    @Test
    func parseSlur() throws {
        let slur = try MXLParser.parseSlur(node(#"<slur type="continue" number="2" orientation="under" bezier-x="12"/>"#))

        #expect(slur.kind == .continue)
        #expect(slur.number.uintValue == 2)
        #expect(slur.orientation == .under)
        #expect(slur.bezierX == 12)
    }

    @Test
    func parseSlur_missingTypeThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseSlur(node(#"<slur number="1"/>"#))
        }
    }

    @Test
    func parseStartNote_invalidValue() {
        #expect(MXLParser.parseStartNote("bogus") == nil)
    }

    @Test
    func parseStartNote_validValues() {
        #expect(MXLParser.parseStartNote("below") == .below)
        #expect(MXLParser.parseStartNote("main") == .main)
        #expect(MXLParser.parseStartNote("upper") == .upper)
    }

    @Test
    func parseTiedKind_invalidValue() {
        #expect(MXLParser.parseTiedKind("bogus") == nil)
    }

    @Test
    func parseTiedKind_validValues() {
        #expect(MXLParser.parseTiedKind("continue") == .continue)
        #expect(MXLParser.parseTiedKind("let-ring") == .letRing)
        #expect(MXLParser.parseTiedKind("start") == .start)
        #expect(MXLParser.parseTiedKind("stop") == .stop)
    }

    @Test
    func parseTuplet() throws {
        let tuplet = try MXLParser.parseTuplet(node(#"""
            <tuplet type="start" bracket="yes" show-number="both"><tuplet-actual><tuplet-number>3</tuplet-number>
            <tuplet-type>eighth</tuplet-type></tuplet-actual></tuplet>
            """#))

        #expect(tuplet.kind == .start)
        #expect(tuplet.hasBracket == true)
        #expect(tuplet.showNumber == .both)
        #expect(tuplet.actual?.kind?.value == .eighth)
    }
}
