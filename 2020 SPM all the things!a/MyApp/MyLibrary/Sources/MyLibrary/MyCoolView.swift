import SwiftUI

public struct MyCoolView: View {

  public init() {}

  public var body: some View {
    VStack {
      Image("coolImage", bundle: .module)
      Text("cool_view_text", bundle: .module)
    }
  }
}
