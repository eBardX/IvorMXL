// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing
import XestiXML

struct MXLParserLayoutTests {
}

// MARK: -

extension MXLParserLayoutTests {
    @Test
    func parseLayout() throws {
        let layout = try MXLParser.parseLayout(node(#"""
            <defaults><page-layout><page-height>1683</page-height><page-width>1190</page-width><page-margins type="both">
            <left-margin>70</left-margin><right-margin>70</right-margin><top-margin>88</top-margin>
            <bottom-margin>88</bottom-margin></page-margins></page-layout><system-layout>
            <system-distance>121</system-distance></system-layout><staff-layout number="2">
            <staff-distance>65</staff-distance></staff-layout></defaults>
            """#))

        #expect(layout.pageLayout?.group?.pageHeight == 1_683)
        #expect(layout.pageLayout?.pageMargins.first?.kind == .both)
        #expect(layout.systemLayout?.systemDistance == 121)
        #expect(layout.staffLayout.first?.staffDistance == 65)
    }

    @Test
    func parseLeftRightMargins_missingRightThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseLeftRightMargins(node(#"<system-margins><left-margin>0</left-margin></system-margins>"#))
        }
    }

    @Test
    func parseMeasureNumberingValue_invalidValue() {
        #expect(MXLParser.parseMeasureNumberingValue("bogus") == nil)
    }

    @Test
    func parseMeasureNumberingValue_validValues() {
        #expect(MXLParser.parseMeasureNumberingValue("measure") == .measure)
        #expect(MXLParser.parseMeasureNumberingValue("none") == .never)
        #expect(MXLParser.parseMeasureNumberingValue("system") == .system)
    }

    @Test
    func parsePageMarginsKind_invalidValue() {
        #expect(MXLParser.parsePageMarginsKind("bogus") == nil)
    }

    @Test
    func parsePageMarginsKind_validValues() {
        #expect(MXLParser.parsePageMarginsKind("both") == .both)
        #expect(MXLParser.parsePageMarginsKind("even") == .even)
        #expect(MXLParser.parsePageMarginsKind("odd") == .odd)
    }

    @Test
    func parsePrint() throws {
        let print = try MXLParser.parsePrint(node(#"""
            <print new-page="yes" page-number="3" staff-spacing="80">
            <measure-numbering system="only-top">system</measure-numbering></print>
            """#))

        #expect(print.attributes.startsNewPage == true)
        #expect(print.attributes.pageNumber == "3")
        #expect(print.attributes.staffSpacing == 80)
        #expect(print.measureNumbering?.value == .system)
    }

    @Test
    func parsePrintout() throws {
        let printout = try MXLParser.parsePrintout(node(#"<note print-object="no" print-dot="yes"/>"#))

        #expect(printout.printsObject == false)
        #expect(printout.printsDot == true)
        #expect(printout.printsLyric == true)
    }

    @Test
    func parseScaling_missingTenthsThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseScaling(node(#"<scaling><millimeters>7</millimeters></scaling>"#))
        }
    }
}
