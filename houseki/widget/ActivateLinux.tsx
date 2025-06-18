import { Astal, Gdk, Gtk, Widget } from "astal/gtk4"

export default (monitor: Gdk.Monitor) => {
    return Widget.Window(
        {
            gdkmonitor: monitor,
            anchor: Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.RIGHT,
            cssClasses: ["activate-linux"],
            visible: true,
            layer: Astal.Layer.OVERLAY,
        },
        Widget.Box(
            {
                vertical: true,
            },

            Widget.Label({
                label: "Activate Linux",
                cssClasses: ["activate-text"],
                halign: Gtk.Align.START,
            }),
            Widget.Label({
                label: "Open terminal to activate Linux",
                cssClasses: ["subtext"],
            }),
        ),
    )
}
