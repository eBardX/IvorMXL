// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLParserCommon2Tests {
}

// MARK: -

extension MXLParserCommon2Tests {
    @Test
    func parseOnOff() {
        #expect(MXLParser.parseOnOff("on") == true)
        #expect(MXLParser.parseOnOff("off") == false)
        #expect(MXLParser.parseOnOff("yes") == nil)
    }

    @Test
    func parseOverUnder_invalidValue() {
        #expect(MXLParser.parseOverUnder("bogus") == nil)
    }

    @Test
    func parseOverUnder_validValues() {
        #expect(MXLParser.parseOverUnder("over") == .over)
        #expect(MXLParser.parseOverUnder("under") == .under)
    }

    @Test
    func parsePosition() throws {
        let position = try MXLParser.parsePosition(node(#"<words default-x="1" default-y="-2" relative-x="3.5" relative-y="4">x</words>"#))

        #expect(position == MXLPosition(defaultX: 1,
                                        defaultY: -2,
                                        relativeX: 3.5,
                                        relativeY: 4))
    }

    @Test
    func parseRightLeftMiddle_invalidValue() {
        #expect(MXLParser.parseRightLeftMiddle("bogus") == nil)
    }

    @Test
    func parseRightLeftMiddle_validValues() {
        #expect(MXLParser.parseRightLeftMiddle("left") == .left)
        #expect(MXLParser.parseRightLeftMiddle("middle") == .middle)
        #expect(MXLParser.parseRightLeftMiddle("right") == .right)
    }

    @Test
    func parseSmuflGlyphName_validAndInvalid() {
        #expect(MXLParser.parseSmuflGlyphName("noteheadBlack")?.stringValue == "noteheadBlack")
        #expect(MXLParser.parseSmuflGlyphName("note head") == nil)
    }

    @Test
    func parseStartStop_invalidValue() {
        #expect(MXLParser.parseStartStop("bogus") == nil)
    }

    @Test
    func parseStartStop_validValues() {
        #expect(MXLParser.parseStartStop("start") == .start)
        #expect(MXLParser.parseStartStop("stop") == .stop)
    }

    @Test
    func parseStartStopContinue_invalidValue() {
        #expect(MXLParser.parseStartStopContinue("bogus") == nil)
    }

    @Test
    func parseStartStopContinue_validValues() {
        #expect(MXLParser.parseStartStopContinue("continue") == .continue)
        #expect(MXLParser.parseStartStopContinue("start") == .start)
        #expect(MXLParser.parseStartStopContinue("stop") == .stop)
    }

    @Test
    func parseStartStopDiscontinue_invalidValue() {
        #expect(MXLParser.parseStartStopDiscontinue("bogus") == nil)
    }

    @Test
    func parseStartStopDiscontinue_validValues() {
        #expect(MXLParser.parseStartStopDiscontinue("discontinue") == .discontinue)
        #expect(MXLParser.parseStartStopDiscontinue("start") == .start)
        #expect(MXLParser.parseStartStopDiscontinue("stop") == .stop)
    }

    @Test
    func parseStartStopSingle_invalidValue() {
        #expect(MXLParser.parseStartStopSingle("bogus") == nil)
    }

    @Test
    func parseStartStopSingle_validValues() {
        #expect(MXLParser.parseStartStopSingle("single") == .single)
        #expect(MXLParser.parseStartStopSingle("start") == .start)
        #expect(MXLParser.parseStartStopSingle("stop") == .stop)
    }

    @Test
    func parseSymbolSize_invalidValue() {
        #expect(MXLParser.parseSymbolSize("bogus") == nil)
    }

    @Test
    func parseSymbolSize_validValues() {
        #expect(MXLParser.parseSymbolSize("cue") == .cue)
        #expect(MXLParser.parseSymbolSize("full") == .full)
        #expect(MXLParser.parseSymbolSize("grace-cue") == .graceCue)
        #expect(MXLParser.parseSymbolSize("large") == .large)
    }

    @Test
    func parseTextDirection_invalidValue() {
        #expect(MXLParser.parseTextDirection("bogus") == nil)
    }

    @Test
    func parseTextDirection_validValues() {
        #expect(MXLParser.parseTextDirection("lro") == .lro)
        #expect(MXLParser.parseTextDirection("ltr") == .ltr)
        #expect(MXLParser.parseTextDirection("rlo") == .rlo)
        #expect(MXLParser.parseTextDirection("rtl") == .rtl)
    }

    @Test
    func parseTopBottom_invalidValue() {
        #expect(MXLParser.parseTopBottom("bogus") == nil)
    }

    @Test
    func parseTopBottom_validValues() {
        #expect(MXLParser.parseTopBottom("bottom") == .bottom)
        #expect(MXLParser.parseTopBottom("top") == .top)
    }

    @Test
    func parseTuning_missingStepThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseTuning(node(#"<staff-tuning><tuning-octave>3</tuning-octave></staff-tuning>"#))
        }
    }

    @Test
    func parseTypedText() throws {
        let text = try MXLParser.parseTypedText(node(#"<creator type="composer">Clara Schumann</creator>"#))

        #expect(text == MXLTypedText(value: "Clara Schumann",
                                     kind: "composer"))
    }

    @Test
    func parseUpDown_invalidValue() {
        #expect(MXLParser.parseUpDown("bogus") == nil)
    }

    @Test
    func parseUpDown_validValues() {
        #expect(MXLParser.parseUpDown("down") == .down)
        #expect(MXLParser.parseUpDown("up") == .up)
    }

    @Test
    func parseUpDownStopContinue_invalidValue() {
        #expect(MXLParser.parseUpDownStopContinue("bogus") == nil)
    }

    @Test
    func parseUpDownStopContinue_validValues() {
        #expect(MXLParser.parseUpDownStopContinue("continue") == .continue)
        #expect(MXLParser.parseUpDownStopContinue("down") == .down)
        #expect(MXLParser.parseUpDownStopContinue("stop") == .stop)
        #expect(MXLParser.parseUpDownStopContinue("up") == .up)
    }

    @Test
    func parseUprightInverted_invalidValue() {
        #expect(MXLParser.parseUprightInverted("bogus") == nil)
    }

    @Test
    func parseUprightInverted_validValues() {
        #expect(MXLParser.parseUprightInverted("inverted") == .inverted)
        #expect(MXLParser.parseUprightInverted("upright") == .upright)
    }

    @Test
    func parseValign_invalidValue() {
        #expect(MXLParser.parseValign("bogus") == nil)
    }

    @Test
    func parseValign_validValues() {
        #expect(MXLParser.parseValign("baseline") == .baseline)
        #expect(MXLParser.parseValign("bottom") == .bottom)
        #expect(MXLParser.parseValign("middle") == .middle)
        #expect(MXLParser.parseValign("top") == .top)
    }

    @Test
    func parseValignImage_invalidValue() {
        #expect(MXLParser.parseValignImage("bogus") == nil)
    }

    @Test
    func parseValignImage_validValues() {
        #expect(MXLParser.parseValignImage("bottom") == .bottom)
        #expect(MXLParser.parseValignImage("middle") == .middle)
        #expect(MXLParser.parseValignImage("top") == .top)
    }

    @Test
    func parseWinged_invalidValue() {
        #expect(MXLParser.parseWinged("bogus") == nil)
    }

    @Test
    func parseWinged_validValues() {
        #expect(MXLParser.parseWinged("curved") == .curved)
        #expect(MXLParser.parseWinged("double-curved") == .doubleCurved)
        #expect(MXLParser.parseWinged("double-straight") == .doubleStraight)
        #expect(MXLParser.parseWinged("none") == .wingless)
        #expect(MXLParser.parseWinged("straight") == .straight)
    }

    @Test
    func parseXmlSpace_invalidValue() {
        #expect(MXLParser.parseXmlSpace("bogus") == nil)
    }

    @Test
    func parseXmlSpace_validValues() {
        #expect(MXLParser.parseXmlSpace("default") == .default)
        #expect(MXLParser.parseXmlSpace("preserve") == .preserve)
    }

    @Test
    func parseYesNo() {
        #expect(MXLParser.parseYesNo("yes") == true)
        #expect(MXLParser.parseYesNo("no") == false)
        #expect(MXLParser.parseYesNo("on") == nil)
    }

    @Test
    func parseYesNoNumber_invalidValue() {
        #expect(MXLParser.parseYesNoNumber("bogus") == nil)
    }

    @Test
    func parseYesNoNumber_number() {
        #expect(MXLParser.parseYesNoNumber("1.5") == .number(1.5))
    }

    @Test
    func parseYesNoNumber_validValues() {
        #expect(MXLParser.parseYesNoNumber("no") == .no)
        #expect(MXLParser.parseYesNoNumber("yes") == .yes)
    }
}
