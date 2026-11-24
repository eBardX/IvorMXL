// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLParserPercussion2Tests {
}

// MARK: -

extension MXLParserPercussion2Tests {
    @Test
    func parsePercussion_stick() throws {
        let percussion = try MXLParser.parsePercussion(node(#"""
            <percussion enclosure="none"><stick tip="down" parentheses="yes"><stick-type>xylophone</stick-type>
            <stick-material>hard</stick-material></stick></percussion>
            """#))

        guard case let .stick(stick) = percussion.content
        else { Issue.record("expected stick content"); return }

        #expect(stick.kind == .xylophone)
        #expect(stick.material == .hard)
        #expect(stick.hasParentheses == true)
        #expect(percussion.enclosure == .unenclosed)
    }

    @Test
    func parsePercussionContent_emptyThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parsePercussionContent(node(#"<percussion/>"#))
        }
    }

    @Test
    func parsePitchedValue_invalidValue() {
        #expect(MXLParser.parsePitchedValue("bogus") == nil)
    }

    @Test
    func parsePitchedValue_validValues() {
        #expect(MXLParser.parsePitchedValue("celesta") == .celesta)
        #expect(MXLParser.parsePitchedValue("chimes") == .chimes)
        #expect(MXLParser.parsePitchedValue("glockenspiel") == .glockenspiel)
        #expect(MXLParser.parsePitchedValue("lithophone") == .lithophone)
        #expect(MXLParser.parsePitchedValue("mallet") == .mallet)
        #expect(MXLParser.parsePitchedValue("marimba") == .marimba)
        #expect(MXLParser.parsePitchedValue("steel drums") == .steelDrums)
        #expect(MXLParser.parsePitchedValue("tubaphone") == .tubaphone)
        #expect(MXLParser.parsePitchedValue("tubular chimes") == .tubularChimes)
        #expect(MXLParser.parsePitchedValue("vibraphone") == .vibraphone)
        #expect(MXLParser.parsePitchedValue("xylophone") == .xylophone)
    }

    @Test
    func parseStick_missingMaterialThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseStick(node(#"<stick><stick-type>timpani</stick-type></stick>"#))
        }
    }

    @Test
    func parseStickKind_invalidValue() {
        #expect(MXLParser.parseStickKind("bogus") == nil)
    }

    @Test
    func parseStickKind_validValues() {
        #expect(MXLParser.parseStickKind("bass drum") == .bassDrum)
        #expect(MXLParser.parseStickKind("double bass drum") == .doubleBassDrum)
        #expect(MXLParser.parseStickKind("glockenspiel") == .glockenspiel)
        #expect(MXLParser.parseStickKind("gum") == .gum)
        #expect(MXLParser.parseStickKind("hammer") == .hammer)
        #expect(MXLParser.parseStickKind("superball") == .superball)
        #expect(MXLParser.parseStickKind("timpani") == .timpani)
        #expect(MXLParser.parseStickKind("wound") == .wound)
        #expect(MXLParser.parseStickKind("xylophone") == .xylophone)
        #expect(MXLParser.parseStickKind("yarn") == .yarn)
    }

    @Test
    func parseStickLocation_invalidValue() {
        #expect(MXLParser.parseStickLocation("bogus") == nil)
    }

    @Test
    func parseStickLocation_validValues() {
        #expect(MXLParser.parseStickLocation("center") == .center)
        #expect(MXLParser.parseStickLocation("cymbal bell") == .cymbalBell)
        #expect(MXLParser.parseStickLocation("cymbal edge") == .cymbalEdge)
        #expect(MXLParser.parseStickLocation("rim") == .rim)
    }

    @Test
    func parseStickMaterial_invalidValue() {
        #expect(MXLParser.parseStickMaterial("bogus") == nil)
    }

    @Test
    func parseStickMaterial_validValues() {
        #expect(MXLParser.parseStickMaterial("hard") == .hard)
        #expect(MXLParser.parseStickMaterial("medium") == .medium)
        #expect(MXLParser.parseStickMaterial("shaded") == .shaded)
        #expect(MXLParser.parseStickMaterial("soft") == .soft)
        #expect(MXLParser.parseStickMaterial("x") == .x)
    }

    @Test
    func parseTimpani() throws {
        let timpani = try MXLParser.parseTimpani(node(#"<timpani smufl="pictTimpani"/>"#))

        #expect(timpani.smufl?.stringValue == "pictTimpani")
    }

    @Test
    func parseWoodValue_invalidValue() {
        #expect(MXLParser.parseWoodValue("bogus") == nil)
    }

    @Test
    func parseWoodValue_validValues() {
        #expect(MXLParser.parseWoodValue("bamboo scraper") == .bambooScraper)
        #expect(MXLParser.parseWoodValue("board clapper") == .boardClapper)
        #expect(MXLParser.parseWoodValue("cabasa") == .cabasa)
        #expect(MXLParser.parseWoodValue("castanets") == .castanets)
        #expect(MXLParser.parseWoodValue("castanets with handle") == .castanetsWithHandle)
        #expect(MXLParser.parseWoodValue("claves") == .claves)
        #expect(MXLParser.parseWoodValue("football rattle") == .footballRattle)
        #expect(MXLParser.parseWoodValue("guiro") == .guiro)
        #expect(MXLParser.parseWoodValue("log drum") == .logDrum)
        #expect(MXLParser.parseWoodValue("maraca") == .maraca)
        #expect(MXLParser.parseWoodValue("maracas") == .maracas)
        #expect(MXLParser.parseWoodValue("quijada") == .quijada)
        #expect(MXLParser.parseWoodValue("rainstick") == .rainstick)
        #expect(MXLParser.parseWoodValue("ratchet") == .ratchet)
        #expect(MXLParser.parseWoodValue("reco-reco") == .recoReco)
        #expect(MXLParser.parseWoodValue("sandpaper blocks") == .sandpaperBlocks)
        #expect(MXLParser.parseWoodValue("slit drum") == .slitDrum)
        #expect(MXLParser.parseWoodValue("temple block") == .templeBlock)
        #expect(MXLParser.parseWoodValue("vibraslap") == .vibraslap)
        #expect(MXLParser.parseWoodValue("whip") == .whip)
        #expect(MXLParser.parseWoodValue("wood block") == .woodBlock)
    }
}
