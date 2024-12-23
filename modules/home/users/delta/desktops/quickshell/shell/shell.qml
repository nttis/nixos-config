import Quickshell

import QtQuick
import QtQuick.Layouts

ShellRoot {
    PanelWindow {
        anchors {
            left: true
            right: true
            bottom: true
        }

        margins {
            right: 50
            bottom: 50
        }

        exclusionMode: ExclusionMode.Ignore
        color: "transparent"
        mask: Region {}

        ColumnLayout {
            id: content

            anchors {
                right: parent.right
            }

            Text {
                text: "Activate Linux"
                color: "#50ffffff"
                font.pointSize: 22
            }

            Text {
                text: "Go to Settings to activate Linux"
                color: "#50ffffff"
                font.pointSize: 14
            }
        }
    }
}
