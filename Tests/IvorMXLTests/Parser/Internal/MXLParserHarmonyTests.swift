// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing
import XestiXML

struct MXLParserHarmonyTests {
}

// MARK: -

extension MXLParserHarmonyTests {
    @Test
    func parseDegreeKindValue_invalidValue() {
        #expect(MXLParser.parseDegreeKindValue("bogus") == nil)
    }

    @Test
    func parseDegreeKindValue_validValues() {
        #expect(MXLParser.parseDegreeKindValue("add") == .add)
        #expect(MXLParser.parseDegreeKindValue("alter") == .alter)
        #expect(MXLParser.parseDegreeKindValue("subtract") == .subtract)
    }

    @Test
    func parseDegreeSymbolValue_invalidValue() {
        #expect(MXLParser.parseDegreeSymbolValue("bogus") == nil)
    }

    @Test
    func parseDegreeSymbolValue_validValues() {
        #expect(MXLParser.parseDegreeSymbolValue("augmented") == .augmented)
        #expect(MXLParser.parseDegreeSymbolValue("diminished") == .diminished)
        #expect(MXLParser.parseDegreeSymbolValue("half-diminished") == .halfDiminished)
        #expect(MXLParser.parseDegreeSymbolValue("major") == .major)
        #expect(MXLParser.parseDegreeSymbolValue("minor") == .minor)
    }

    @Test
    func parseFiguredBass() throws {
        let figuredBass = try MXLParser.parseFiguredBass(node(#"""
            <figured-bass parentheses="yes" placement="below"><figure><prefix>flat</prefix>
            <figure-number>6</figure-number><extend type="start"/></figure><figure><figure-number>4</figure-number>
            </figure><duration>2</duration></figured-bass>
            """#))

        #expect(figuredBass.figure.count == 2)
        #expect(figuredBass.duration?.intValue == 2)
        #expect(figuredBass.hasParentheses == true)
    }

    @Test
    func parseFrame() throws {
        let frame = try MXLParser.parseFrame(node(#"""
            <frame unplayed="x" height="40" width="30"><frame-strings>6</frame-strings><frame-frets>4</frame-frets>
            <first-fret text="5fr" location="right">5</first-fret><frame-note><string>6</string><fret>1</fret>
            <fingering>1</fingering><barre type="start"/></frame-note><frame-note><string>1</string><fret>1</fret>
            <barre type="stop"/></frame-note></frame>
            """#))

        #expect(frame.strings == 6)
        #expect(frame.frets == 4)
        #expect(frame.note.count == 2)
        #expect(frame.unplayed == "x")
    }

    @Test
    func parseFrame_missingStringsThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseFrame(node(#"<frame><frame-frets>4</frame-frets></frame>"#))
        }
    }

    @Test
    func parseHarmony() throws {
        let harmony = try MXLParser.parseHarmony(node(#"""
            <harmony print-frame="no"><root><root-step>D</root-step><root-alter>-1</root-alter></root>
            <kind text="m7">minor-seventh</kind><bass><bass-step>F</bass-step></bass></harmony>
            """#))

        #expect(harmony.printsFrame == false)
        #expect(harmony.chord.count == 1)
        #expect(harmony.chord.first?.kind.value == .minorSeventh)
        #expect(harmony.chord.first?.bass?.step.value == .f)
    }

    @Test
    func parseHarmonyArrangement_invalidValue() {
        #expect(MXLParser.parseHarmonyArrangement("bogus") == nil)
    }

    @Test
    func parseHarmonyArrangement_validValues() {
        #expect(MXLParser.parseHarmonyArrangement("diagonal") == .diagonal)
        #expect(MXLParser.parseHarmonyArrangement("horizontal") == .horizontal)
        #expect(MXLParser.parseHarmonyArrangement("vertical") == .vertical)
    }

    @Test
    func parseHarmonyChordKindValue_invalidValue() {
        #expect(MXLParser.parseHarmonyChordKindValue("bogus") == nil)
    }

    @Test
    func parseHarmonyChordKindValue_validValues() {
        #expect(MXLParser.parseHarmonyChordKindValue("augmented") == .augmented)
        #expect(MXLParser.parseHarmonyChordKindValue("augmented-seventh") == .augmentedSeventh)
        #expect(MXLParser.parseHarmonyChordKindValue("diminished") == .diminished)
        #expect(MXLParser.parseHarmonyChordKindValue("diminished-seventh") == .diminishedSeventh)
        #expect(MXLParser.parseHarmonyChordKindValue("dominant") == .dominant)
        #expect(MXLParser.parseHarmonyChordKindValue("dominant-11th") == .dominant11th)
        #expect(MXLParser.parseHarmonyChordKindValue("dominant-13th") == .dominant13th)
        #expect(MXLParser.parseHarmonyChordKindValue("dominant-ninth") == .dominantNinth)
        #expect(MXLParser.parseHarmonyChordKindValue("French") == .french)
        #expect(MXLParser.parseHarmonyChordKindValue("German") == .german)
        #expect(MXLParser.parseHarmonyChordKindValue("half-diminished") == .halfDiminished)
        #expect(MXLParser.parseHarmonyChordKindValue("Italian") == .italian)
        #expect(MXLParser.parseHarmonyChordKindValue("major") == .major)
        #expect(MXLParser.parseHarmonyChordKindValue("major-11th") == .major11th)
        #expect(MXLParser.parseHarmonyChordKindValue("major-13th") == .major13th)
        #expect(MXLParser.parseHarmonyChordKindValue("major-minor") == .majorMinor)
        #expect(MXLParser.parseHarmonyChordKindValue("major-ninth") == .majorNinth)
        #expect(MXLParser.parseHarmonyChordKindValue("major-seventh") == .majorSeventh)
        #expect(MXLParser.parseHarmonyChordKindValue("major-sixth") == .majorSixth)
        #expect(MXLParser.parseHarmonyChordKindValue("minor") == .minor)
        #expect(MXLParser.parseHarmonyChordKindValue("minor-11th") == .minor11th)
        #expect(MXLParser.parseHarmonyChordKindValue("minor-13th") == .minor13th)
        #expect(MXLParser.parseHarmonyChordKindValue("minor-ninth") == .minorNinth)
        #expect(MXLParser.parseHarmonyChordKindValue("minor-seventh") == .minorSeventh)
        #expect(MXLParser.parseHarmonyChordKindValue("minor-sixth") == .minorSixth)
        #expect(MXLParser.parseHarmonyChordKindValue("Neapolitan") == .neapolitan)
        #expect(MXLParser.parseHarmonyChordKindValue("none") == .noChord)
        #expect(MXLParser.parseHarmonyChordKindValue("other") == .other)
        #expect(MXLParser.parseHarmonyChordKindValue("pedal") == .pedal)
        #expect(MXLParser.parseHarmonyChordKindValue("power") == .power)
        #expect(MXLParser.parseHarmonyChordKindValue("suspended-fourth") == .suspendedFourth)
        #expect(MXLParser.parseHarmonyChordKindValue("suspended-second") == .suspendedSecond)
        #expect(MXLParser.parseHarmonyChordKindValue("Tristan") == .tristan)
    }

    @Test
    func parseHarmonyChords_oneChordPerKind() throws {
        let chords = try MXLParser.parseHarmonyChords(node(#"""
            <harmony><root><root-step>C</root-step></root><kind>major</kind><root><root-step>G</root-step></root>
            <kind>dominant</kind></harmony>
            """#))

        #expect(chords.map(\.kind.value) == [.major, .dominant])
    }

    @Test
    func parseHarmonyKind_invalidValue() {
        #expect(MXLParser.parseHarmonyKind("bogus") == nil)
    }

    @Test
    func parseHarmonyKind_validValues() {
        #expect(MXLParser.parseHarmonyKind("alternate") == .alternate)
        #expect(MXLParser.parseHarmonyKind("explicit") == .explicit)
        #expect(MXLParser.parseHarmonyKind("implied") == .implied)
    }

    @Test
    func parseNumeral() throws {
        let numeral = try MXLParser.parseNumeral(node(#"""
            <numeral><numeral-root text="IV">4</numeral-root><numeral-alter location="left">-1</numeral-alter>
            <numeral-key print-object="no"><numeral-fifths>-3</numeral-fifths><numeral-mode>harmonic minor</numeral-mode>
            </numeral-key></numeral>
            """#))

        #expect(numeral.root.value.uintValue == 4)
        #expect(numeral.alter?.value == -1)
        #expect(numeral.key?.mode == .harmonicMinor)
    }

    @Test
    func parseNumeralMode_invalidValue() {
        #expect(MXLParser.parseNumeralMode("bogus") == nil)
    }

    @Test
    func parseNumeralMode_validValues() {
        #expect(MXLParser.parseNumeralMode("harmonic minor") == .harmonicMinor)
        #expect(MXLParser.parseNumeralMode("major") == .major)
        #expect(MXLParser.parseNumeralMode("melodic minor") == .melodicMinor)
        #expect(MXLParser.parseNumeralMode("minor") == .minor)
        #expect(MXLParser.parseNumeralMode("natural minor") == .naturalMinor)
    }

    @Test
    func parseNumeralValue_validAndInvalid() {
        #expect(MXLParser.parseNumeralValue("7")?.uintValue == 7)
        #expect(MXLParser.parseNumeralValue("8") == nil)
    }

    @Test
    func parseRoot_missingStepThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseRoot(node(#"<root><root-alter>1</root-alter></root>"#))
        }
    }

    @Test
    func parseShowFrets_invalidValue() {
        #expect(MXLParser.parseShowFrets("bogus") == nil)
    }

    @Test
    func parseShowFrets_validValues() {
        #expect(MXLParser.parseShowFrets("letters") == .letters)
        #expect(MXLParser.parseShowFrets("numbers") == .numbers)
    }
}
