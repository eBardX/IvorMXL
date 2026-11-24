// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing
import XestiXML

struct MXLParserCommonTests {
}

// MARK: -

extension MXLParserCommonTests {
    @Test
    func emptyTextElementData() {
        let data = MXLParser.emptyTextElementData()

        #expect(data.value.isEmpty)
        #expect(data.font == MXLFont())
        #expect(data.color == nil)
    }

    @Test
    func parseAboveBelow_invalidValue() {
        #expect(MXLParser.parseAboveBelow("bogus") == nil)
    }

    @Test
    func parseAboveBelow_validValues() {
        #expect(MXLParser.parseAboveBelow("above") == .above)
        #expect(MXLParser.parseAboveBelow("below") == .below)
    }

    @Test
    func parseColor_invalidText() {
        #expect(MXLParser.parseColor("purple") == nil)
    }

    @Test
    func parseColor_node() throws {
        let color = try MXLParser.parseColor(node(##"<words color="#800080">x</words>"##))

        #expect(color?.stringValue == "#800080")
    }

    @Test
    func parseCssFontSize_invalidValue() {
        #expect(MXLParser.parseCssFontSize("bogus") == nil)
    }

    @Test
    func parseCssFontSize_validValues() {
        #expect(MXLParser.parseCssFontSize("large") == .large)
        #expect(MXLParser.parseCssFontSize("medium") == .medium)
        #expect(MXLParser.parseCssFontSize("small") == .small)
        #expect(MXLParser.parseCssFontSize("x-large") == .xLarge)
        #expect(MXLParser.parseCssFontSize("x-small") == .xSmall)
        #expect(MXLParser.parseCssFontSize("xx-large") == .xxLarge)
        #expect(MXLParser.parseCssFontSize("xx-small") == .xxSmall)
    }

    @Test
    func parseEnclosureShape_invalidValue() {
        #expect(MXLParser.parseEnclosureShape("bogus") == nil)
    }

    @Test
    func parseEnclosureShape_validValues() {
        #expect(MXLParser.parseEnclosureShape("bracket") == .bracket)
        #expect(MXLParser.parseEnclosureShape("circle") == .circle)
        #expect(MXLParser.parseEnclosureShape("decagon") == .decagon)
        #expect(MXLParser.parseEnclosureShape("diamond") == .diamond)
        #expect(MXLParser.parseEnclosureShape("heptagon") == .heptagon)
        #expect(MXLParser.parseEnclosureShape("hexagon") == .hexagon)
        #expect(MXLParser.parseEnclosureShape("inverted-bracket") == .invertedBracket)
        #expect(MXLParser.parseEnclosureShape("nonagon") == .nonagon)
        #expect(MXLParser.parseEnclosureShape("none") == .unenclosed)
        #expect(MXLParser.parseEnclosureShape("octagon") == .octagon)
        #expect(MXLParser.parseEnclosureShape("oval") == .oval)
        #expect(MXLParser.parseEnclosureShape("pentagon") == .pentagon)
        #expect(MXLParser.parseEnclosureShape("rectangle") == .rectangle)
        #expect(MXLParser.parseEnclosureShape("square") == .square)
        #expect(MXLParser.parseEnclosureShape("triangle") == .triangle)
    }

    @Test
    func parseFontSize_cssOrPoint() {
        #expect(MXLParser.parseFontSize("x-large") == .css(.xLarge))
        #expect(MXLParser.parseFontSize("10.5") == .point(10.5))
        #expect(MXLParser.parseFontSize("huge") == nil)
    }

    @Test
    func parseFontStyle_invalidValue() {
        #expect(MXLParser.parseFontStyle("bogus") == nil)
    }

    @Test
    func parseFontStyle_validValues() {
        #expect(MXLParser.parseFontStyle("italic") == .italic)
        #expect(MXLParser.parseFontStyle("normal") == .normal)
    }

    @Test
    func parseFontWeight_invalidValue() {
        #expect(MXLParser.parseFontWeight("bogus") == nil)
    }

    @Test
    func parseFontWeight_validValues() {
        #expect(MXLParser.parseFontWeight("bold") == .bold)
        #expect(MXLParser.parseFontWeight("normal") == .normal)
    }

    @Test
    func parseFormattedText() throws {
        let text = try MXLParser.parseFormattedText(node(#"<words justify="center" font-weight="bold" underline="1" enclosure="oval">Dolce</words>"#))

        #expect(text.value == "Dolce")
        #expect(text.justify == .center)
        #expect(text.font.weight == .bold)
        #expect(text.underline?.uintValue == 1)
        #expect(text.enclosure == .oval)
    }

    @Test
    func parseImageAttributes_missingSourceThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseImageAttributes(node(#"<image type="image/png"/>"#))
        }
    }

    @Test
    func parseInt_validAndInvalid() {
        #expect(MXLParser.parseInt("-3") == -3)
        #expect(MXLParser.parseInt("3.5") == nil)
    }

    @Test
    func parseLeftCenterRight_invalidValue() {
        #expect(MXLParser.parseLeftCenterRight("bogus") == nil)
    }

    @Test
    func parseLeftCenterRight_validValues() {
        #expect(MXLParser.parseLeftCenterRight("center") == .center)
        #expect(MXLParser.parseLeftCenterRight("left") == .left)
        #expect(MXLParser.parseLeftCenterRight("right") == .right)
    }

    @Test
    func parseLeftRight_invalidValue() {
        #expect(MXLParser.parseLeftRight("bogus") == nil)
    }

    @Test
    func parseLeftRight_validValues() {
        #expect(MXLParser.parseLeftRight("left") == .left)
        #expect(MXLParser.parseLeftRight("right") == .right)
    }

    @Test
    func parseLineDetail_missingLineThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseLineDetail(node(#"<line-detail width="2"/>"#))
        }
    }

    @Test
    func parseLineEnd_invalidValue() {
        #expect(MXLParser.parseLineEnd("bogus") == nil)
    }

    @Test
    func parseLineEnd_validValues() {
        #expect(MXLParser.parseLineEnd("arrow") == .arrow)
        #expect(MXLParser.parseLineEnd("both") == .both)
        #expect(MXLParser.parseLineEnd("down") == .down)
        #expect(MXLParser.parseLineEnd("none") == .plain)
        #expect(MXLParser.parseLineEnd("up") == .up)
    }

    @Test
    func parseLineKind_invalidValue() {
        #expect(MXLParser.parseLineKind("bogus") == nil)
    }

    @Test
    func parseLineKind_validValues() {
        #expect(MXLParser.parseLineKind("dashed") == .dashed)
        #expect(MXLParser.parseLineKind("dotted") == .dotted)
        #expect(MXLParser.parseLineKind("solid") == .solid)
        #expect(MXLParser.parseLineKind("wavy") == .wavy)
    }

    @Test
    func parseLineLength_invalidValue() {
        #expect(MXLParser.parseLineLength("bogus") == nil)
    }

    @Test
    func parseLineLength_validValues() {
        #expect(MXLParser.parseLineLength("long") == .long)
        #expect(MXLParser.parseLineLength("medium") == .medium)
        #expect(MXLParser.parseLineLength("short") == .short)
    }

    @Test
    func parseLineShape_invalidValue() {
        #expect(MXLParser.parseLineShape("bogus") == nil)
    }

    @Test
    func parseLineShape_validValues() {
        #expect(MXLParser.parseLineShape("curved") == .curved)
        #expect(MXLParser.parseLineShape("straight") == .straight)
    }

    @Test
    func parseNumberOrNormal() {
        #expect(MXLParser.parseNumberOrNormal("normal") == .normal)
        #expect(MXLParser.parseNumberOrNormal("1.2") == .number(1.2))
        #expect(MXLParser.parseNumberOrNormal("tight") == nil)
    }
}
