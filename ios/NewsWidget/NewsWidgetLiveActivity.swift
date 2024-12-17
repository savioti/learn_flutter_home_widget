//
//  NewsWidgetLiveActivity.swift
//  NewsWidget
//
//  Created by user253537 on 12/17/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct NewsWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct NewsWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: NewsWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension NewsWidgetAttributes {
    fileprivate static var preview: NewsWidgetAttributes {
        NewsWidgetAttributes(name: "World")
    }
}

extension NewsWidgetAttributes.ContentState {
    fileprivate static var smiley: NewsWidgetAttributes.ContentState {
        NewsWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: NewsWidgetAttributes.ContentState {
         NewsWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: NewsWidgetAttributes.preview) {
   NewsWidgetLiveActivity()
} contentStates: {
    NewsWidgetAttributes.ContentState.smiley
    NewsWidgetAttributes.ContentState.starEyes
}
