import { App } from "astal"

import style from "./css/main.scss"

import Bar from "./widgets/Bar"

App.start({
	css: style,
	main() {
		Bar(0)
	},
})
