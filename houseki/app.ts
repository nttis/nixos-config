import { App } from "astal/gtk4"

import style from "./style.scss"

import ActivateLinux from "./widget/ActivateLinux"
import Bar from "./widget/Bar"

App.start({
    css: style,
    main() {
        App.get_monitors().map(ActivateLinux)
        App.get_monitors().map(Bar)
    },
})
