// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLTimeOnlyTests {
}

// MARK: -

extension MXLTimeOnlyTests {
    @Test
    func formatTimeOnly() {
        #expect(MXLFormatter.Writer().formatTimeOnly([1, 3]) == "1,3")
    }

    @Test
    func formatTimeOnly_roundTrips() {
        let text = MXLFormatter.Writer().formatTimeOnly([2, 4, 6])

        #expect(MXLParser.parseTimeOnly(text) == [2, 4, 6])
    }

    @Test
    func parseTimeOnly_list() {
        #expect(MXLParser.parseTimeOnly("1, 2,3") == [1, 2, 3])
    }

    @Test
    func parseTimeOnly_nonNumericItem() {
        #expect(MXLParser.parseTimeOnly("1, x") == nil)
    }

    @Test
    func parseTimeOnly_single() {
        #expect(MXLParser.parseTimeOnly("2") == [2])
    }
}
