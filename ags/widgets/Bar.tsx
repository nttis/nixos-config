import { App, Variable, Astal, Gtk, bind } from "astal"

import Network from "gi://AstalNetwork"
import Wp from "gi://AstalWp"

const time = Variable<string>("").poll(1000, `date +"%A, %D, %T"`)

function Wifi() {
	const { wifi } = Network.get_default()

	return (
		<icon
			tooltipText={bind(wifi, "ssid").as(String)}
			className="Wifi"
			icon={bind(wifi, "iconName")}
		/>
	)
}

export default function Bar(monitor: number) {
	return (
		<window
			className="Bar"
			monitor={monitor}
			exclusivity={Astal.Exclusivity.EXCLUSIVE}
			layer={Astal.Layer.TOP}
			anchor={
				Astal.WindowAnchor.TOP |
				Astal.WindowAnchor.LEFT |
				Astal.WindowAnchor.RIGHT
			}
			application={App}
		>
			<centerbox>
				<box />
				<box />
				<box hexpand halign={Gtk.Align.END}>
					
					<Wifi />
				</box>
			</centerbox>
		</window>
	)
}
