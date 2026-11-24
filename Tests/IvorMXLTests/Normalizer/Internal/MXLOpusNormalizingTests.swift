// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLOpusNormalizingTests {
}

// MARK: -

extension MXLOpusNormalizingTests {
    @Test
    func minimumVersion_findsTheOldestNestedOpus() {
        let inner = MXLOpus(version: .v1_0,
                            items: [])
        let outer = MXLOpus(version: .v3_0,
                            items: [.opus(inner)])

        #expect(outer.minimumVersion == .v1_0)
    }

    @Test
    func minimumVersion_withoutNestedOpus() {
        let opus = MXLOpus(version: .v2_0,
                           items: [.opusLink(MXLXLink(href: "a.xml"))])

        #expect(opus.minimumVersion == .v2_0)
    }

    @Test
    func withVersion_stampsNestedOpuses() {
        let inner = MXLOpus(version: .v1_0,
                            items: [])
        let outer = MXLOpus(version: .v3_0,
                            items: [.opus(inner), .opusLink(MXLXLink(href: "a.xml"))])

        let stamped = outer.withVersion(.v4_0)

        #expect(stamped.minimumVersion == .v4_0)
        #expect(stamped.items.count == 2)
    }
}
