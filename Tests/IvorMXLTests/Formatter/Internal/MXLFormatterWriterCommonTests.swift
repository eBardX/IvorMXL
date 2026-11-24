// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLFormatterWriterCommonTests {
}

// MARK: -

extension MXLFormatterWriterCommonTests {
    @Test
    func colorAttributes_omitsNil() {
        #expect(MXLFormatter.Writer().colorAttributes(nil).isEmpty)
    }

    @Test
    func fontAttributes_omitsEmptyFont() {
        #expect(MXLFormatter.Writer().fontAttributes(MXLFont()).isEmpty)
    }

    @Test
    func formatAboveBelow_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLAboveBelow] = [.above, .below]

        for value in values {
            #expect(MXLParser.parseAboveBelow(writer.formatAboveBelow(value)) == value)
        }
    }

    @Test
    func formatDecimal() {
        #expect(MXLFormatter.Writer().formatDecimal(2.5) == "2.5")
    }

    @Test
    func formatLeftCenterRight_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLLeftCenterRight] = [.center, .left, .right]

        for value in values {
            #expect(MXLParser.parseLeftCenterRight(writer.formatLeftCenterRight(value)) == value)
        }
    }

    @Test
    func formatLeftRight_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLLeftRight] = [.left, .right]

        for value in values {
            #expect(MXLParser.parseLeftRight(writer.formatLeftRight(value)) == value)
        }
    }

    @Test
    func formatLineKind_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLLineKind] = [.dashed, .dotted, .solid, .wavy]

        for value in values {
            #expect(MXLParser.parseLineKind(writer.formatLineKind(value)) == value)
        }
    }

    @Test
    func formatLineLength_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLLineLength] = [.long, .medium, .short]

        for value in values {
            #expect(MXLParser.parseLineLength(writer.formatLineLength(value)) == value)
        }
    }

    @Test
    func formatLineShape_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLLineShape] = [.curved, .straight]

        for value in values {
            #expect(MXLParser.parseLineShape(writer.formatLineShape(value)) == value)
        }
    }

    @Test
    func formatNoteKindValue_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLNoteKindValue] = [.n1024th,
                                          .n128th,
                                          .n16th,
                                          .n256th,
                                          .n32nd,
                                          .n512th,
                                          .n64th,
                                          .breve,
                                          .eighth,
                                          .half,
                                          .long,
                                          .maxima,
                                          .quarter,
                                          .whole]

        for value in values {
            #expect(MXLParser.parseNoteKindValue(writer.formatNoteKindValue(value)) == value)
        }
    }

    @Test
    func formatNumberOrNormal_roundTrips() {
        let writer = MXLFormatter.Writer()

        #expect(MXLParser.parseNumberOrNormal(writer.formatNumberOrNormal(.normal)) == .normal)
        #expect(MXLParser.parseNumberOrNormal(writer.formatNumberOrNormal(.number(1.5))) == .number(1.5))
    }

    @Test
    func formatOverUnder_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLOverUnder] = [.over, .under]

        for value in values {
            #expect(MXLParser.parseOverUnder(writer.formatOverUnder(value)) == value)
        }
    }

    @Test
    func formatRightLeftMiddle_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLRightLeftMiddle] = [.left, .middle, .right]

        for value in values {
            #expect(MXLParser.parseRightLeftMiddle(writer.formatRightLeftMiddle(value)) == value)
        }
    }

    @Test
    func formatShowFrets_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLShowFrets] = [.letters, .numbers]

        for value in values {
            #expect(MXLParser.parseShowFrets(writer.formatShowFrets(value)) == value)
        }
    }

    @Test
    func formatShowTuplet_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLShowTuplet] = [.actual, .both, .neither]

        for value in values {
            #expect(MXLParser.parseShowTuplet(writer.formatShowTuplet(value)) == value)
        }
    }

    @Test
    func formatStartStop_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLStartStop] = [.start, .stop]

        for value in values {
            #expect(MXLParser.parseStartStop(writer.formatStartStop(value)) == value)
        }
    }

    @Test
    func formatStartStopContinue_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLStartStopContinue] = [.continue, .start, .stop]

        for value in values {
            #expect(MXLParser.parseStartStopContinue(writer.formatStartStopContinue(value)) == value)
        }
    }

    @Test
    func formatStartStopDiscontinue_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLStartStopDiscontinue] = [.discontinue, .start, .stop]

        for value in values {
            #expect(MXLParser.parseStartStopDiscontinue(writer.formatStartStopDiscontinue(value)) == value)
        }
    }

    @Test
    func formatStartStopSingle_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLStartStopSingle] = [.single, .start, .stop]

        for value in values {
            #expect(MXLParser.parseStartStopSingle(writer.formatStartStopSingle(value)) == value)
        }
    }

    @Test
    func formatStep_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLStep] = [.a, .b, .c, .d, .e, .f, .g]

        for value in values {
            #expect(MXLParser.parseStep(writer.formatStep(value)) == value)
        }
    }

    @Test
    func formatSymbolSize_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLSymbolSize] = [.cue, .full, .graceCue, .large]

        for value in values {
            #expect(MXLParser.parseSymbolSize(writer.formatSymbolSize(value)) == value)
        }
    }

    @Test
    func formatSystemRelation_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLSystemRelation] = [.alsoTop, .onlyPart, .onlyTop]

        for value in values {
            #expect(MXLParser.parseSystemRelation(writer.formatSystemRelation(value)) == value)
        }
    }

    @Test
    func formatTopBottom_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLTopBottom] = [.bottom, .top]

        for value in values {
            #expect(MXLParser.parseTopBottom(writer.formatTopBottom(value)) == value)
        }
    }

    @Test
    func formatUpDown_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLUpDown] = [.down, .up]

        for value in values {
            #expect(MXLParser.parseUpDown(writer.formatUpDown(value)) == value)
        }
    }

    @Test
    func formatUprightInverted_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLUprightInverted] = [.inverted, .upright]

        for value in values {
            #expect(MXLParser.parseUprightInverted(writer.formatUprightInverted(value)) == value)
        }
    }

    @Test
    func formatValign_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLValign] = [.baseline, .bottom, .middle, .top]

        for value in values {
            #expect(MXLParser.parseValign(writer.formatValign(value)) == value)
        }
    }

    @Test
    func formatValignImage_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLValignImage] = [.bottom, .middle, .top]

        for value in values {
            #expect(MXLParser.parseValignImage(writer.formatValignImage(value)) == value)
        }
    }

    @Test
    func formatWinged_roundTripsEveryCase() {
        let writer = MXLFormatter.Writer()
        let values: [MXLWinged] = [.curved, .doubleCurved, .doubleStraight, .wingless, .straight]

        for value in values {
            #expect(MXLParser.parseWinged(writer.formatWinged(value)) == value)
        }
    }

    @Test
    func formatYesNo_roundTrips() {
        let writer = MXLFormatter.Writer()

        #expect(MXLParser.parseYesNo(writer.formatYesNo(true)) == true)
        #expect(MXLParser.parseYesNo(writer.formatYesNo(false)) == false)
    }

    @Test
    func positionAttributes_roundTrips() throws {
        let position = MXLPosition(defaultX: 1,
                                   relativeY: -2)
        let written = writtenNode { writer in
            writer.writeEmptyElement(.segno,
                                     attributes: writer.positionAttributes(position))
        }

        #expect(try MXLParser.parsePosition(written) == position)
    }
}
