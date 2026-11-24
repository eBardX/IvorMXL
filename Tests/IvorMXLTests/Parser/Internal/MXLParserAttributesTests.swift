// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing
import XestiXML

struct MXLParserAttributesTests {
}

// MARK: -

extension MXLParserAttributesTests {
    @Test
    func parseAttributes() throws {
        let attributes = try MXLParser.parseAttributes(node(#"""
            <attributes><divisions>4</divisions><key><fifths>2</fifths><mode>major</mode></key><time symbol="common">
            <beats>4</beats><beat-type>4</beat-type></time><staves>2</staves><clef number="1"><sign>G</sign><line>2</line>
            </clef><clef number="2"><sign>F</sign><line>4</line></clef><transpose><diatonic>-1</diatonic>
            <chromatic>-2</chromatic></transpose></attributes>
            """#))

        #expect(attributes.divisions?.intValue == 4)
        #expect(attributes.staves == 2)
        #expect(attributes.clef.map(\.content.sign) == [.g, .f])
        #expect(attributes.key.count == 1)
        #expect(attributes.time.count == 1)
    }

    @Test
    func parseAttributesContent_forPart() throws {
        let content = try MXLParser.parseAttributesContent(node(#"""
            <attributes><for-part><part-transpose><chromatic>2</chromatic></part-transpose></for-part></attributes>
            """#))

        guard case let .forPart(forParts) = content
        else { Issue.record("expected for-part content"); return }

        #expect(forParts.first?.transpose.chromatic == 2)
    }

    @Test
    func parseAttributesContent_transposeByDefault() throws {
        let content = try MXLParser.parseAttributesContent(node("<attributes/>"))

        #expect(content == .transpose([]))
    }

    @Test
    func parseCancelLocation_invalidValue() {
        #expect(MXLParser.parseCancelLocation("bogus") == nil)
    }

    @Test
    func parseCancelLocation_validValues() {
        #expect(MXLParser.parseCancelLocation("before-barline") == .beforeBarline)
        #expect(MXLParser.parseCancelLocation("left") == .left)
        #expect(MXLParser.parseCancelLocation("right") == .right)
    }

    @Test
    func parseClef() throws {
        let clef = try MXLParser.parseClef(node(#"<clef number="2"><sign>F</sign><line>4</line><clef-octave-change>-1</clef-octave-change></clef>"#))

        #expect(clef.content.sign == .f)
        #expect(clef.content.line?.intValue == 4)
        #expect(clef.content.octaveChange?.intValue == -1)
        #expect(clef.number?.uintValue == 2)
    }

    @Test
    func parseClefContent_missingSignThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseClefContent(node(#"<clef><line>2</line></clef>"#))
        }
    }

    @Test
    func parseClefSign_invalidValue() {
        #expect(MXLParser.parseClefSign("g") == nil)
    }

    @Test
    func parseClefSign_validValues() {
        #expect(MXLParser.parseClefSign("C") == .c)
        #expect(MXLParser.parseClefSign("F") == .f)
        #expect(MXLParser.parseClefSign("G") == .g)
        #expect(MXLParser.parseClefSign("jianpu") == .jianpu)
        #expect(MXLParser.parseClefSign("none") == .invisible)
        #expect(MXLParser.parseClefSign("percussion") == .percussion)
        #expect(MXLParser.parseClefSign("TAB") == .tAB)
    }

    @Test
    func parseFifths_validAndInvalid() {
        #expect(MXLParser.parseFifths("-7")?.intValue == -7)
        #expect(MXLParser.parseFifths("sharp") == nil)
    }

    @Test
    func parseKeyOctave_missingNumberThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseKeyOctave(node(#"<key-octave>4</key-octave>"#))
        }
    }

    @Test
    func parseMeasureStyle_missingContentThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseMeasureStyle(node(#"<measure-style/>"#))
        }
    }

    @Test
    func parseMeasureStyle_multipleRest() throws {
        let style = try MXLParser.parseMeasureStyle(node(#"<measure-style><multiple-rest use-symbols="yes">4</multiple-rest></measure-style>"#))

        guard case let .multipleRest(rest) = style.content
        else { Issue.record("expected a multiple rest"); return }

        #expect(rest.value == 4)
        #expect(rest.usesSymbols == true)
    }

    @Test
    func parsePositiveDivisions_validAndInvalid() {
        #expect(MXLParser.parsePositiveDivisions("480")?.intValue == 480)
        #expect(MXLParser.parsePositiveDivisions("0") == nil)
    }

    @Test
    func parseShowTuplet_invalidValue() {
        #expect(MXLParser.parseShowTuplet("bogus") == nil)
    }

    @Test
    func parseShowTuplet_validValues() {
        #expect(MXLParser.parseShowTuplet("actual") == .actual)
        #expect(MXLParser.parseShowTuplet("both") == .both)
        #expect(MXLParser.parseShowTuplet("none") == .neither)
    }

    @Test
    func parseStaffDetailsKind_invalidValue() {
        #expect(MXLParser.parseStaffDetailsKind("bogus") == nil)
    }

    @Test
    func parseStaffDetailsKind_validValues() {
        #expect(MXLParser.parseStaffDetailsKind("alternate") == .alternate)
        #expect(MXLParser.parseStaffDetailsKind("cue") == .cue)
        #expect(MXLParser.parseStaffDetailsKind("editorial") == .editorial)
        #expect(MXLParser.parseStaffDetailsKind("ossia") == .ossia)
        #expect(MXLParser.parseStaffDetailsKind("regular") == .regular)
    }

    @Test
    func parseStaffDivideSymbol_invalidValue() {
        #expect(MXLParser.parseStaffDivideSymbol("bogus") == nil)
    }

    @Test
    func parseStaffDivideSymbol_validValues() {
        #expect(MXLParser.parseStaffDivideSymbol("down") == .down)
        #expect(MXLParser.parseStaffDivideSymbol("up") == .up)
        #expect(MXLParser.parseStaffDivideSymbol("up-down") == .upDown)
    }

    @Test
    func parseTime_senzaMisura() throws {
        let time = try MXLParser.parseTime(node("<time><senza-misura>X</senza-misura></time>"))

        #expect(time.content == .senzaMisura("X"))
    }

    @Test
    func parseTime_signature() throws {
        let time = try MXLParser.parseTime(node(#"<time symbol="cut"><beats>2</beats><beat-type>2</beat-type></time>"#))

        #expect(time.content == .timeSignature([MXLTimeSignature(beats: "2",
                                                                 beatType: "2")],
                                               interchangeable: nil))
        #expect(time.symbol == .cut)
    }

    @Test
    func parseTimeSignatures_dropsUnpairedBeats() throws {
        let signatures = try MXLParser.parseTimeSignatures(node("<time><beats>3</beats><beat-type>8</beat-type><beats>2</beats></time>"))

        #expect(signatures == [MXLTimeSignature(beats: "3",
                                                beatType: "8")])
    }

    @Test
    func parseTransposeContent_missingChromaticThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseTransposeContent(node(#"<transpose><diatonic>1</diatonic></transpose>"#))
        }
    }
}
