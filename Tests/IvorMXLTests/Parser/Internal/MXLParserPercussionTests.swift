// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing
import XestiXML

struct MXLParserPercussionTests {
}

// MARK: -

extension MXLParserPercussionTests {
    @Test
    func parseBeater() throws {
        let beater = try MXLParser.parseBeater(node(#"<beater tip="up">snare stick</beater>"#))

        #expect(beater.value == .snareStick)
        #expect(beater.tip == .up)
    }

    @Test
    func parseBeaterValue_invalidValue() {
        #expect(MXLParser.parseBeaterValue("bogus") == nil)
    }

    @Test
    func parseBeaterValue_validValues() {
        #expect(MXLParser.parseBeaterValue("bow") == .bow)
        #expect(MXLParser.parseBeaterValue("chime hammer") == .chimeHammer)
        #expect(MXLParser.parseBeaterValue("coin") == .coin)
        #expect(MXLParser.parseBeaterValue("drum stick") == .drumStick)
        #expect(MXLParser.parseBeaterValue("finger") == .finger)
        #expect(MXLParser.parseBeaterValue("fingernail") == .fingernail)
        #expect(MXLParser.parseBeaterValue("fist") == .fist)
        #expect(MXLParser.parseBeaterValue("guiro scraper") == .guiroScraper)
        #expect(MXLParser.parseBeaterValue("hammer") == .hammer)
        #expect(MXLParser.parseBeaterValue("hand") == .hand)
        #expect(MXLParser.parseBeaterValue("jazz stick") == .jazzStick)
        #expect(MXLParser.parseBeaterValue("knitting needle") == .knittingNeedle)
        #expect(MXLParser.parseBeaterValue("metal hammer") == .metalHammer)
        #expect(MXLParser.parseBeaterValue("slide brush on gong") == .slideBrushOnGong)
        #expect(MXLParser.parseBeaterValue("snare stick") == .snareStick)
        #expect(MXLParser.parseBeaterValue("spoon mallet") == .spoonMallet)
        #expect(MXLParser.parseBeaterValue("superball") == .superball)
        #expect(MXLParser.parseBeaterValue("triangle beater") == .triangleBeater)
        #expect(MXLParser.parseBeaterValue("triangle beater plain") == .triangleBeaterPlain)
        #expect(MXLParser.parseBeaterValue("wire brush") == .wireBrush)
    }

    @Test
    func parseEffectValue_invalidValue() {
        #expect(MXLParser.parseEffectValue("bogus") == nil)
    }

    @Test
    func parseEffectValue_validValues() {
        #expect(MXLParser.parseEffectValue("anvil") == .anvil)
        #expect(MXLParser.parseEffectValue("auto horn") == .autoHorn)
        #expect(MXLParser.parseEffectValue("bird whistle") == .birdWhistle)
        #expect(MXLParser.parseEffectValue("cannon") == .cannon)
        #expect(MXLParser.parseEffectValue("duck call") == .duckCall)
        #expect(MXLParser.parseEffectValue("gun shot") == .gunShot)
        #expect(MXLParser.parseEffectValue("klaxon horn") == .klaxonHorn)
        #expect(MXLParser.parseEffectValue("lions roar") == .lionsRoar)
        #expect(MXLParser.parseEffectValue("lotus flute") == .lotusFlute)
        #expect(MXLParser.parseEffectValue("megaphone") == .megaphone)
        #expect(MXLParser.parseEffectValue("police whistle") == .policeWhistle)
        #expect(MXLParser.parseEffectValue("siren") == .siren)
        #expect(MXLParser.parseEffectValue("slide whistle") == .slideWhistle)
        #expect(MXLParser.parseEffectValue("thunder sheet") == .thunderSheet)
        #expect(MXLParser.parseEffectValue("wind machine") == .windMachine)
        #expect(MXLParser.parseEffectValue("wind whistle") == .windWhistle)
    }

    @Test
    func parseGlass_invalidValueThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseGlass(node(#"<glass>tumbler</glass>"#))
        }
    }

    @Test
    func parseGlassValue_invalidValue() {
        #expect(MXLParser.parseGlassValue("bogus") == nil)
    }

    @Test
    func parseGlassValue_validValues() {
        #expect(MXLParser.parseGlassValue("glass harmonica") == .glassHarmonica)
        #expect(MXLParser.parseGlassValue("glass harp") == .glassHarp)
        #expect(MXLParser.parseGlassValue("wind chimes") == .windChimes)
    }

    @Test
    func parseMembraneValue_invalidValue() {
        #expect(MXLParser.parseMembraneValue("bogus") == nil)
    }

    @Test
    func parseMembraneValue_validValues() {
        #expect(MXLParser.parseMembraneValue("bass drum") == .bassDrum)
        #expect(MXLParser.parseMembraneValue("bass drum on side") == .bassDrumOnSide)
        #expect(MXLParser.parseMembraneValue("bongos") == .bongos)
        #expect(MXLParser.parseMembraneValue("Chinese tomtom") == .chineseTomtom)
        #expect(MXLParser.parseMembraneValue("conga drum") == .congaDrum)
        #expect(MXLParser.parseMembraneValue("cuica") == .cuica)
        #expect(MXLParser.parseMembraneValue("goblet drum") == .gobletDrum)
        #expect(MXLParser.parseMembraneValue("Indo-American tomtom") == .indoAmericanTomtom)
        #expect(MXLParser.parseMembraneValue("Japanese tomtom") == .japaneseTomtom)
        #expect(MXLParser.parseMembraneValue("military drum") == .militaryDrum)
        #expect(MXLParser.parseMembraneValue("snare drum") == .snareDrum)
        #expect(MXLParser.parseMembraneValue("snare drum snares off") == .snareDrumSnaresOff)
        #expect(MXLParser.parseMembraneValue("tabla") == .tabla)
        #expect(MXLParser.parseMembraneValue("tambourine") == .tambourine)
        #expect(MXLParser.parseMembraneValue("tenor drum") == .tenorDrum)
        #expect(MXLParser.parseMembraneValue("timbales") == .timbales)
        #expect(MXLParser.parseMembraneValue("tomtom") == .tomtom)
    }

    @Test
    func parseMetal() throws {
        let metal = try MXLParser.parseMetal(node(#"<metal smufl="pictCowbell">cowbell</metal>"#))

        #expect(metal.value == .cowbell)
        #expect(metal.smufl?.stringValue == "pictCowbell")
    }

    @Test
    func parseMetalValue_invalidValue() {
        #expect(MXLParser.parseMetalValue("bogus") == nil)
    }

    @Test
    func parseMetalValue_validValues() {
        #expect(MXLParser.parseMetalValue("agogo") == .agogo)
        #expect(MXLParser.parseMetalValue("almglocken") == .almglocken)
        #expect(MXLParser.parseMetalValue("bell") == .bell)
        #expect(MXLParser.parseMetalValue("bell plate") == .bellPlate)
        #expect(MXLParser.parseMetalValue("bell tree") == .bellTree)
        #expect(MXLParser.parseMetalValue("brake drum") == .brakeDrum)
        #expect(MXLParser.parseMetalValue("cencerro") == .cencerro)
        #expect(MXLParser.parseMetalValue("chain rattle") == .chainRattle)
        #expect(MXLParser.parseMetalValue("Chinese cymbal") == .chineseCymbal)
        #expect(MXLParser.parseMetalValue("cowbell") == .cowbell)
        #expect(MXLParser.parseMetalValue("crash cymbals") == .crashCymbals)
        #expect(MXLParser.parseMetalValue("crotale") == .crotale)
        #expect(MXLParser.parseMetalValue("cymbal tongs") == .cymbalTongs)
        #expect(MXLParser.parseMetalValue("domed gong") == .domedGong)
        #expect(MXLParser.parseMetalValue("finger cymbals") == .fingerCymbals)
        #expect(MXLParser.parseMetalValue("flexatone") == .flexatone)
        #expect(MXLParser.parseMetalValue("gong") == .gong)
        #expect(MXLParser.parseMetalValue("handbell") == .handbell)
        #expect(MXLParser.parseMetalValue("hi-hat") == .hiHat)
        #expect(MXLParser.parseMetalValue("high-hat cymbals") == .highHatCymbals)
        #expect(MXLParser.parseMetalValue("jaw harp") == .jawHarp)
        #expect(MXLParser.parseMetalValue("jingle bells") == .jingleBells)
        #expect(MXLParser.parseMetalValue("musical saw") == .musicalSaw)
        #expect(MXLParser.parseMetalValue("shell bells") == .shellBells)
        #expect(MXLParser.parseMetalValue("sistrum") == .sistrum)
        #expect(MXLParser.parseMetalValue("sizzle cymbal") == .sizzleCymbal)
        #expect(MXLParser.parseMetalValue("sleigh bells") == .sleighBells)
        #expect(MXLParser.parseMetalValue("suspended cymbal") == .suspendedCymbal)
        #expect(MXLParser.parseMetalValue("tam tam") == .tamTam)
        #expect(MXLParser.parseMetalValue("tam tam with beater") == .tamTamWithBeater)
        #expect(MXLParser.parseMetalValue("triangle") == .triangle)
        #expect(MXLParser.parseMetalValue("Vietnamese hat") == .vietnameseHat)
    }
}
