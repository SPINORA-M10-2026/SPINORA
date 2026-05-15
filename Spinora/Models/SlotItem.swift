import Foundation

struct SlotItem {
    var element: Element
    var hasRerolled: Bool = false

    init(element: Element) {
        self.element = element
    }
}
