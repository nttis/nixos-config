import { Astal, Gdk, Widget } from "astal/gtk4"

export default (monitor: Gdk.Monitor) => {
    return Widget.Window(
        {
            gdkmonitor: monitor,
            anchor:
                Astal.WindowAnchor.LEFT |
                Astal.WindowAnchor.RIGHT |
                Astal.WindowAnchor.TOP,
            cssClasses: ["bar"],
            exclusivity: Astal.Exclusivity.EXCLUSIVE,
            visible: true,
        },

        Widget.Image({
            iconName: "network-wireless",
        }),
    )
}
