// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLYyyyMmDdTests {
}

// MARK: -

extension MXLYyyyMmDdTests {
    @Test
    func parseEncodingItem_keepsDateVerbatim() throws {
        let item = try MXLParser.parseEncodingItem(node("<encoding-date>2026-11-24</encoding-date>"))

        #expect(item == .encodingDate("2026-11-24"))
    }

    @Test
    func writeEncodingItem_roundTrips() throws {
        let item = MXLEncoding.Item.encodingDate("2026-01-31")
        let written = writtenNode { $0.writeEncodingItem(item) }

        #expect(try MXLParser.parseEncodingItem(written) == item)
    }
}
