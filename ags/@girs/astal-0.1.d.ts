/// <reference path="./gobject-2.0.d.ts" />
/// <reference path="./glib-2.0.d.ts" />
/// <reference path="./gdk-3.0.d.ts" />
/// <reference path="./cairo-1.0.d.ts" />
/// <reference path="./pango-1.0.d.ts" />
/// <reference path="./harfbuzz-0.0.d.ts" />
/// <reference path="./freetype2-2.0.d.ts" />
/// <reference path="./gio-2.0.d.ts" />
/// <reference path="./gmodule-2.0.d.ts" />
/// <reference path="./gdkpixbuf-2.0.d.ts" />
/// <reference path="./gtk-3.0.d.ts" />
/// <reference path="./xlib-2.0.d.ts" />
/// <reference path="./atk-1.0.d.ts" />

/**
 * Type Definitions for Gjs (https://gjs.guide/)
 *
 * These type definitions are automatically generated, do not edit them by hand.
 * If you found a bug fix it in `ts-for-gir` or create a bug report on https://github.com/gjsify/ts-for-gir
 *
 * The based EJS template file is used for the generated .d.ts file of each GIR module like Gtk-4.0, GObject-2.0, ...
 */

declare module 'gi://Astal?version=0.1' {
    // Module dependencies
    import type GObject from 'gi://GObject?version=2.0';
    import type GLib from 'gi://GLib?version=2.0';
    import type Gdk from 'gi://Gdk?version=3.0';
    import type cairo from 'gi://cairo?version=1.0';
    import type Pango from 'gi://Pango?version=1.0';
    import type HarfBuzz from 'gi://HarfBuzz?version=0.0';
    import type freetype2 from 'gi://freetype2?version=2.0';
    import type Gio from 'gi://Gio?version=2.0';
    import type GModule from 'gi://GModule?version=2.0';
    import type GdkPixbuf from 'gi://GdkPixbuf?version=2.0';
    import type Gtk from 'gi://Gtk?version=3.0';
    import type xlib from 'gi://xlib?version=2.0';
    import type Atk from 'gi://Atk?version=1.0';

    export namespace Astal {
        /**
         * Astal-0.1
         */

        export namespace MouseButton {
            export const $gtype: GObject.GType<MouseButton>;
        }

        enum MouseButton {
            PRIMARY,
            MIDDLE,
            SECONDARY,
            BACK,
            FORWARD,
        }

        export namespace WindowAnchor {
            export const $gtype: GObject.GType<WindowAnchor>;
        }

        enum WindowAnchor {
            NONE,
            TOP,
            RIGHT,
            LEFT,
            BOTTOM,
        }

        export namespace Exclusivity {
            export const $gtype: GObject.GType<Exclusivity>;
        }

        enum Exclusivity {
            NORMAL,
            EXCLUSIVE,
            IGNORE,
        }

        export namespace Layer {
            export const $gtype: GObject.GType<Layer>;
        }

        enum Layer {
            BACKGROUND,
            BOTTOM,
            TOP,
            OVERLAY,
        }

        export namespace Keymode {
            export const $gtype: GObject.GType<Keymode>;
        }

        enum Keymode {
            NONE,
            ON_DEMAND,
            EXCLUSIVE,
        }
        const MAJOR_VERSION: number;
        const MINOR_VERSION: number;
        const MICRO_VERSION: number;
        const VERSION: string;
        function lookup_icon(icon: string): Gtk.IconInfo | null;
        function widget_set_css(widget: Gtk.Widget, css: string): void;
        function widget_get_css(widget: Gtk.Widget): string;
        function widget_set_class_names(widget: Gtk.Widget, class_names: string[]): void;
        function widget_get_class_names(widget: Gtk.Widget): string[];
        function widget_toggle_class_name(widget: Gtk.Widget, class_name: string, condition: boolean): void;
        function widget_set_cursor(widget: Gtk.Widget, cursor: string): void;
        function widget_get_cursor(widget: Gtk.Widget): string;
        function widget_set_click_through(widget: Gtk.Widget, click_through: boolean): void;
        function widget_get_click_through(widget: Gtk.Widget): boolean;
        function get_num_monitors(): number;
        function read_sock(conn: Gio.SocketConnection): Promise<string>;
        function read_sock(
            conn: Gio.SocketConnection,
            _callback_: Gio.AsyncReadyCallback<Gio.SocketConnection> | null,
        ): void;
        function read_sock(
            conn: Gio.SocketConnection,
            _callback_?: Gio.AsyncReadyCallback<Gio.SocketConnection> | null,
        ): Promise<string> | void;
        function read_sock_finish(_res_: Gio.AsyncResult): string;
        function write_sock(conn: Gio.SocketConnection, response: string): Promise<void>;
        function write_sock(
            conn: Gio.SocketConnection,
            response: string,
            _callback_: Gio.AsyncReadyCallback<Gio.SocketConnection> | null,
        ): void;
        function write_sock(
            conn: Gio.SocketConnection,
            response: string,
            _callback_?: Gio.AsyncReadyCallback<Gio.SocketConnection> | null,
        ): Promise<void> | void;
        function write_sock_finish(_res_: Gio.AsyncResult): void;
        function read_file(path: string): string;
        function read_file_async(path: string): Promise<string>;
        function read_file_async(path: string, _callback_: Gio.AsyncReadyCallback<string> | null): void;
        function read_file_async(
            path: string,
            _callback_?: Gio.AsyncReadyCallback<string> | null,
        ): Promise<string> | void;
        function read_file_finish(_res_: Gio.AsyncResult): string;
        function write_file(path: string, content: string): void;
        function write_file_async(path: string, content: string): Promise<void>;
        function write_file_async(
            path: string,
            content: string,
            _callback_: Gio.AsyncReadyCallback<string> | null,
        ): void;
        function write_file_async(
            path: string,
            content: string,
            _callback_?: Gio.AsyncReadyCallback<string> | null,
        ): Promise<void> | void;
        function write_file_finish(_res_: Gio.AsyncResult): void;
        function monitor_file(path: string, callback: GObject.Closure): Gio.FileMonitor | null;
        module Box {
            // Constructor properties interface

            interface ConstructorProps extends Gtk.Box.ConstructorProps {
                vertical: boolean;
                no_implicit_destroy: boolean;
                noImplicitDestroy: boolean;
                children: Gtk.Widget[];
                child: Gtk.Widget;
            }
        }

        class Box extends Gtk.Box {
            static $gtype: GObject.GType<Box>;

            // Properties

            get vertical(): boolean;
            set vertical(val: boolean);
            get no_implicit_destroy(): boolean;
            set no_implicit_destroy(val: boolean);
            get noImplicitDestroy(): boolean;
            set noImplicitDestroy(val: boolean);
            get children(): Gtk.Widget[];
            set children(val: Gtk.Widget[]);
            get child(): Gtk.Widget;
            set child(val: Gtk.Widget);

            // Constructors

            constructor(properties?: Partial<Box.ConstructorProps>, ...args: any[]);

            _init(...args: any[]): void;

            static ['new'](vertical: boolean, children: Gtk.Widget[]): Box;
            // Conflicted with Gtk.Box.new

            static ['new'](...args: never[]): any;

            static newh(children: Gtk.Widget[]): Box;

            static newv(children: Gtk.Widget[]): Box;
            // Conflicted with GObject.Object.newv

            static newv(...args: never[]): any;

            // Methods

            get_vertical(): boolean;
            set_vertical(value: boolean): void;
            get_no_implicit_destroy(): boolean;
            set_no_implicit_destroy(value: boolean): void;
            get_children(): Gtk.Widget[];
            set_children(value: Gtk.Widget[]): void;
            get_child(): Gtk.Widget;
            set_child(value: Gtk.Widget): void;
        }

        module Button {
            // Signal callback interfaces

            interface Hover {
                (event: HoverEvent): void;
            }

            interface HoverLost {
                (event: HoverEvent): void;
            }

            interface Click {
                (event: ClickEvent): void;
            }

            interface ClickRelease {
                (event: ClickEvent): void;
            }

            interface Scroll {
                (event: ScrollEvent): void;
            }

            // Constructor properties interface

            interface ConstructorProps extends Gtk.Button.ConstructorProps {}
        }

        class Button extends Gtk.Button {
            static $gtype: GObject.GType<Button>;

            // Constructors

            constructor(properties?: Partial<Button.ConstructorProps>, ...args: any[]);

            _init(...args: any[]): void;

            static ['new'](): Button;

            // Signals

            connect(id: string, callback: (...args: any[]) => any): number;
            connect_after(id: string, callback: (...args: any[]) => any): number;
            emit(id: string, ...args: any[]): void;
            connect(signal: 'hover', callback: (_source: this, event: HoverEvent) => void): number;
            connect_after(signal: 'hover', callback: (_source: this, event: HoverEvent) => void): number;
            emit(signal: 'hover', event: HoverEvent): void;
            connect(signal: 'hover-lost', callback: (_source: this, event: HoverEvent) => void): number;
            connect_after(signal: 'hover-lost', callback: (_source: this, event: HoverEvent) => void): number;
            emit(signal: 'hover-lost', event: HoverEvent): void;
            connect(signal: 'click', callback: (_source: this, event: ClickEvent) => void): number;
            connect_after(signal: 'click', callback: (_source: this, event: ClickEvent) => void): number;
            emit(signal: 'click', event: ClickEvent): void;
            connect(signal: 'click-release', callback: (_source: this, event: ClickEvent) => void): number;
            connect_after(signal: 'click-release', callback: (_source: this, event: ClickEvent) => void): number;
            emit(signal: 'click-release', event: ClickEvent): void;
            connect(signal: 'scroll', callback: (_source: this, event: ScrollEvent) => void): number;
            connect_after(signal: 'scroll', callback: (_source: this, event: ScrollEvent) => void): number;
            emit(signal: 'scroll', event: ScrollEvent): void;
        }

        module CenterBox {
            // Constructor properties interface

            interface ConstructorProps extends Gtk.Box.ConstructorProps {
                vertical: boolean;
                start_widget: Gtk.Widget;
                startWidget: Gtk.Widget;
                end_widget: Gtk.Widget;
                endWidget: Gtk.Widget;
                center_widget: Gtk.Widget;
                centerWidget: Gtk.Widget;
            }
        }

        class CenterBox extends Gtk.Box {
            static $gtype: GObject.GType<CenterBox>;

            // Properties

            get vertical(): boolean;
            set vertical(val: boolean);
            get start_widget(): Gtk.Widget;
            set start_widget(val: Gtk.Widget);
            get startWidget(): Gtk.Widget;
            set startWidget(val: Gtk.Widget);
            get end_widget(): Gtk.Widget;
            set end_widget(val: Gtk.Widget);
            get endWidget(): Gtk.Widget;
            set endWidget(val: Gtk.Widget);
            get center_widget(): Gtk.Widget;
            set center_widget(val: Gtk.Widget);
            get centerWidget(): Gtk.Widget;
            set centerWidget(val: Gtk.Widget);

            // Constructors

            constructor(properties?: Partial<CenterBox.ConstructorProps>, ...args: any[]);

            _init(...args: any[]): void;

            static ['new'](): CenterBox;

            // Methods

            get_vertical(): boolean;
            set_vertical(value: boolean): void;
            get_start_widget(): Gtk.Widget;
            set_start_widget(value: Gtk.Widget): void;
            get_end_widget(): Gtk.Widget;
            set_end_widget(value: Gtk.Widget): void;
            get_center_widget(): Gtk.Widget;
            // Conflicted with Gtk.Box.get_center_widget
            get_center_widget(...args: never[]): any;
            set_center_widget(value: Gtk.Widget): void;
            // Conflicted with Gtk.Box.set_center_widget
            set_center_widget(...args: never[]): any;
        }

        module CircularProgress {
            // Constructor properties interface

            interface ConstructorProps extends Gtk.Bin.ConstructorProps {
                start_at: number;
                startAt: number;
                end_at: number;
                endAt: number;
                value: number;
                inverted: boolean;
                rounded: boolean;
            }
        }

        class CircularProgress extends Gtk.Bin {
            static $gtype: GObject.GType<CircularProgress>;

            // Properties

            get start_at(): number;
            set start_at(val: number);
            get startAt(): number;
            set startAt(val: number);
            get end_at(): number;
            set end_at(val: number);
            get endAt(): number;
            set endAt(val: number);
            get value(): number;
            set value(val: number);
            get inverted(): boolean;
            set inverted(val: boolean);
            get rounded(): boolean;
            set rounded(val: boolean);

            // Constructors

            constructor(properties?: Partial<CircularProgress.ConstructorProps>, ...args: any[]);

            _init(...args: any[]): void;

            static ['new'](): CircularProgress;

            // Methods

            get_start_at(): number;
            set_start_at(value: number): void;
            get_end_at(): number;
            set_end_at(value: number): void;
            get_value(): number;
            set_value(value: number): void;
            get_inverted(): boolean;
            set_inverted(value: boolean): void;
            get_rounded(): boolean;
            set_rounded(value: boolean): void;
        }

        module EventBox {
            // Signal callback interfaces

            interface Hover {
                (event: HoverEvent): void;
            }

            interface HoverLost {
                (event: HoverEvent): void;
            }

            interface Click {
                (event: ClickEvent): void;
            }

            interface ClickRelease {
                (event: ClickEvent): void;
            }

            interface Scroll {
                (event: ScrollEvent): void;
            }

            interface Motion {
                (event: MotionEvent): void;
            }

            // Constructor properties interface

            interface ConstructorProps extends Gtk.EventBox.ConstructorProps {}
        }

        class EventBox extends Gtk.EventBox {
            static $gtype: GObject.GType<EventBox>;

            // Constructors

            constructor(properties?: Partial<EventBox.ConstructorProps>, ...args: any[]);

            _init(...args: any[]): void;

            static ['new'](): EventBox;

            // Signals

            connect(id: string, callback: (...args: any[]) => any): number;
            connect_after(id: string, callback: (...args: any[]) => any): number;
            emit(id: string, ...args: any[]): void;
            connect(signal: 'hover', callback: (_source: this, event: HoverEvent) => void): number;
            connect_after(signal: 'hover', callback: (_source: this, event: HoverEvent) => void): number;
            emit(signal: 'hover', event: HoverEvent): void;
            connect(signal: 'hover-lost', callback: (_source: this, event: HoverEvent) => void): number;
            connect_after(signal: 'hover-lost', callback: (_source: this, event: HoverEvent) => void): number;
            emit(signal: 'hover-lost', event: HoverEvent): void;
            connect(signal: 'click', callback: (_source: this, event: ClickEvent) => void): number;
            connect_after(signal: 'click', callback: (_source: this, event: ClickEvent) => void): number;
            emit(signal: 'click', event: ClickEvent): void;
            connect(signal: 'click-release', callback: (_source: this, event: ClickEvent) => void): number;
            connect_after(signal: 'click-release', callback: (_source: this, event: ClickEvent) => void): number;
            emit(signal: 'click-release', event: ClickEvent): void;
            connect(signal: 'scroll', callback: (_source: this, event: ScrollEvent) => void): number;
            connect_after(signal: 'scroll', callback: (_source: this, event: ScrollEvent) => void): number;
            emit(signal: 'scroll', event: ScrollEvent): void;
            connect(signal: 'motion', callback: (_source: this, event: MotionEvent) => void): number;
            connect_after(signal: 'motion', callback: (_source: this, event: MotionEvent) => void): number;
            emit(signal: 'motion', event: MotionEvent): void;
        }

        module Icon {
            // Constructor properties interface

            interface ConstructorProps extends Gtk.Image.ConstructorProps {
                pixbuf: GdkPixbuf.Pixbuf;
                icon: string;
                g_icon: Gio.Icon;
                gIcon: Gio.Icon;
            }
        }

        class Icon extends Gtk.Image {
            static $gtype: GObject.GType<Icon>;

            // Properties

            get pixbuf(): GdkPixbuf.Pixbuf;
            set pixbuf(val: GdkPixbuf.Pixbuf);
            get icon(): string;
            set icon(val: string);
            get g_icon(): Gio.Icon;
            set g_icon(val: Gio.Icon);
            get gIcon(): Gio.Icon;
            set gIcon(val: Gio.Icon);

            // Constructors

            constructor(properties?: Partial<Icon.ConstructorProps>, ...args: any[]);

            _init(...args: any[]): void;

            static ['new'](): Icon;

            // Methods

            get_pixbuf(): GdkPixbuf.Pixbuf;
            // Conflicted with Gtk.Image.get_pixbuf
            get_pixbuf(...args: never[]): any;
            set_pixbuf(value: GdkPixbuf.Pixbuf): void;
            get_icon(): string;
            set_icon(value: string): void;
            get_g_icon(): Gio.Icon;
            set_g_icon(value: Gio.Icon): void;
        }

        module Label {
            // Constructor properties interface

            interface ConstructorProps extends Gtk.Label.ConstructorProps {
                truncate: boolean;
                justify_fill: boolean;
                justifyFill: boolean;
            }
        }

        class Label extends Gtk.Label {
            static $gtype: GObject.GType<Label>;

            // Properties

            get truncate(): boolean;
            set truncate(val: boolean);
            get justify_fill(): boolean;
            set justify_fill(val: boolean);
            get justifyFill(): boolean;
            set justifyFill(val: boolean);

            // Constructors

            constructor(properties?: Partial<Label.ConstructorProps>, ...args: any[]);

            _init(...args: any[]): void;

            static ['new'](): Label;

            // Methods

            get_truncate(): boolean;
            set_truncate(value: boolean): void;
            get_justify_fill(): boolean;
            set_justify_fill(value: boolean): void;
        }

        module LevelBar {
            // Constructor properties interface

            interface ConstructorProps extends Gtk.LevelBar.ConstructorProps {
                vertical: boolean;
            }
        }

        class LevelBar extends Gtk.LevelBar {
            static $gtype: GObject.GType<LevelBar>;

            // Properties

            get vertical(): boolean;
            set vertical(val: boolean);

            // Constructors

            constructor(properties?: Partial<LevelBar.ConstructorProps>, ...args: any[]);

            _init(...args: any[]): void;

            static ['new'](): LevelBar;

            // Methods

            get_vertical(): boolean;
            set_vertical(value: boolean): void;
        }

        module Overlay {
            // Constructor properties interface

            interface ConstructorProps extends Gtk.Overlay.ConstructorProps {
                pass_through: boolean;
                passThrough: boolean;
                overlay: Gtk.Widget;
                overlays: Gtk.Widget[];
                child: Gtk.Widget;
            }
        }

        class Overlay extends Gtk.Overlay {
            static $gtype: GObject.GType<Overlay>;

            // Properties

            get pass_through(): boolean;
            set pass_through(val: boolean);
            get passThrough(): boolean;
            set passThrough(val: boolean);
            get overlay(): Gtk.Widget;
            set overlay(val: Gtk.Widget);
            get overlays(): Gtk.Widget[];
            set overlays(val: Gtk.Widget[]);
            get child(): Gtk.Widget;
            set child(val: Gtk.Widget);

            // Constructors

            constructor(properties?: Partial<Overlay.ConstructorProps>, ...args: any[]);

            _init(...args: any[]): void;

            static ['new'](): Overlay;

            // Methods

            add_overlay(widget: Gtk.Widget): void;
            get_pass_through(): boolean;
            set_pass_through(value: boolean): void;
            get_overlay(): Gtk.Widget | null;
            set_overlay(value?: Gtk.Widget | null): void;
            get_overlays(): Gtk.Widget[];
            set_overlays(value: Gtk.Widget[]): void;
            get_child(): Gtk.Widget | null;
            set_child(value?: Gtk.Widget | null): void;
        }

        module Scrollable {
            // Constructor properties interface

            interface ConstructorProps extends Gtk.ScrolledWindow.ConstructorProps {
                hscroll: Gtk.PolicyType;
                vscroll: Gtk.PolicyType;
            }
        }

        class Scrollable extends Gtk.ScrolledWindow {
            static $gtype: GObject.GType<Scrollable>;

            // Properties

            get hscroll(): Gtk.PolicyType;
            set hscroll(val: Gtk.PolicyType);
            get vscroll(): Gtk.PolicyType;
            set vscroll(val: Gtk.PolicyType);

            // Constructors

            constructor(properties?: Partial<Scrollable.ConstructorProps>, ...args: any[]);

            _init(...args: any[]): void;

            static ['new'](): Scrollable;

            // Methods

            get_child(): Gtk.Widget;
            // Conflicted with Gtk.Bin.get_child
            get_child(...args: never[]): any;
            get_hscroll(): Gtk.PolicyType;
            set_hscroll(value: Gtk.PolicyType): void;
            get_vscroll(): Gtk.PolicyType;
            set_vscroll(value: Gtk.PolicyType): void;
        }

        module Slider {
            // Signal callback interfaces

            interface Dragged {
                (): void;
            }

            // Constructor properties interface

            interface ConstructorProps extends Gtk.Scale.ConstructorProps {
                vertical: boolean;
                dragging: boolean;
                value: number;
                min: number;
                max: number;
                step: number;
            }
        }

        class Slider extends Gtk.Scale {
            static $gtype: GObject.GType<Slider>;

            // Properties

            get vertical(): boolean;
            set vertical(val: boolean);
            get dragging(): boolean;
            set dragging(val: boolean);
            get value(): number;
            set value(val: number);
            get min(): number;
            set min(val: number);
            get max(): number;
            set max(val: number);
            get step(): number;
            set step(val: number);

            // Constructors

            constructor(properties?: Partial<Slider.ConstructorProps>, ...args: any[]);

            _init(...args: any[]): void;

            static ['new'](): Slider;

            // Signals

            connect(id: string, callback: (...args: any[]) => any): number;
            connect_after(id: string, callback: (...args: any[]) => any): number;
            emit(id: string, ...args: any[]): void;
            connect(signal: 'dragged', callback: (_source: this) => void): number;
            connect_after(signal: 'dragged', callback: (_source: this) => void): number;
            emit(signal: 'dragged'): void;

            // Methods

            get_vertical(): boolean;
            set_vertical(value: boolean): void;
            get_dragging(): boolean;
            get_value(): number;
            set_value(value: number): void;
            get_min(): number;
            set_min(value: number): void;
            get_max(): number;
            set_max(value: number): void;
            get_step(): number;
            set_step(value: number): void;
        }

        module Stack {
            // Constructor properties interface

            interface ConstructorProps extends Gtk.Stack.ConstructorProps {
                no_implicit_destroy: boolean;
                noImplicitDestroy: boolean;
                shown: string;
                children: Gtk.Widget[];
            }
        }

        class Stack extends Gtk.Stack {
            static $gtype: GObject.GType<Stack>;

            // Properties

            get no_implicit_destroy(): boolean;
            set no_implicit_destroy(val: boolean);
            get noImplicitDestroy(): boolean;
            set noImplicitDestroy(val: boolean);
            get shown(): string;
            set shown(val: string);
            get children(): Gtk.Widget[];
            set children(val: Gtk.Widget[]);

            // Constructors

            constructor(properties?: Partial<Stack.ConstructorProps>, ...args: any[]);

            _init(...args: any[]): void;

            static ['new'](): Stack;

            // Methods

            get_no_implicit_destroy(): boolean;
            set_no_implicit_destroy(value: boolean): void;
            get_shown(): string;
            set_shown(value: string): void;
            get_children(): Gtk.Widget[];
            set_children(value: Gtk.Widget[]): void;
        }

        module Window {
            // Constructor properties interface

            interface ConstructorProps extends Gtk.Window.ConstructorProps {
                namespace: string;
                anchor: number;
                exclusivity: Exclusivity;
                layer: Layer;
                keymode: Keymode;
                gdkmonitor: Gdk.Monitor;
                margin_top: number;
                marginTop: number;
                margin_bottom: number;
                marginBottom: number;
                margin_left: number;
                marginLeft: number;
                margin_right: number;
                marginRight: number;
                margin: number;
                monitor: number;
            }
        }

        class Window extends Gtk.Window {
            static $gtype: GObject.GType<Window>;

            // Properties

            get namespace(): string;
            set namespace(val: string);
            get anchor(): number;
            set anchor(val: number);
            get exclusivity(): Exclusivity;
            set exclusivity(val: Exclusivity);
            get layer(): Layer;
            set layer(val: Layer);
            get keymode(): Keymode;
            set keymode(val: Keymode);
            get gdkmonitor(): Gdk.Monitor;
            set gdkmonitor(val: Gdk.Monitor);
            get margin_top(): number;
            set margin_top(val: number);
            get marginTop(): number;
            set marginTop(val: number);
            get margin_bottom(): number;
            set margin_bottom(val: number);
            get marginBottom(): number;
            set marginBottom(val: number);
            get margin_left(): number;
            set margin_left(val: number);
            get marginLeft(): number;
            set marginLeft(val: number);
            get margin_right(): number;
            set margin_right(val: number);
            get marginRight(): number;
            set marginRight(val: number);
            set margin(val: number);
            get monitor(): number;
            set monitor(val: number);

            // Constructors

            constructor(properties?: Partial<Window.ConstructorProps>, ...args: any[]);

            _init(...args: any[]): void;

            static ['new'](): Window;

            // Methods

            get_namespace(): string;
            set_namespace(value: string): void;
            get_anchor(): number;
            set_anchor(value: number): void;
            get_exclusivity(): Exclusivity;
            set_exclusivity(value: Exclusivity): void;
            get_layer(): Layer;
            set_layer(value: Layer): void;
            get_keymode(): Keymode;
            set_keymode(value: Keymode): void;
            get_gdkmonitor(): Gdk.Monitor;
            set_gdkmonitor(value: Gdk.Monitor): void;
            get_margin_top(): number;
            set_margin_top(value: number): void;
            get_margin_bottom(): number;
            set_margin_bottom(value: number): void;
            get_margin_left(): number;
            set_margin_left(value: number): void;
            get_margin_right(): number;
            set_margin_right(value: number): void;
            set_margin(value: number): void;
            get_monitor(): number;
            set_monitor(value: number): void;
        }

        module Application {
            // Signal callback interfaces

            interface MonitorAdded {
                (monitor: Gdk.Monitor): void;
            }

            interface MonitorRemoved {
                (monitor: Gdk.Monitor): void;
            }

            // Constructor properties interface

            interface ConstructorProps extends Gtk.Application.ConstructorProps {
                socket_path: string;
                socketPath: string;
                monitors: Gdk.Monitor[];
                instance_name: string;
                instanceName: string;
                windows: Gtk.Window[];
                settings: Gtk.Settings;
                screen: Gdk.Screen;
                gtk_theme: string;
                gtkTheme: string;
                icon_theme: string;
                iconTheme: string;
                cursor_theme: string;
                cursorTheme: string;
            }
        }

        class Application extends Gtk.Application {
            static $gtype: GObject.GType<Application>;

            // Properties

            get socket_path(): string;
            set socket_path(val: string);
            get socketPath(): string;
            set socketPath(val: string);
            get monitors(): Gdk.Monitor[];
            get instance_name(): string;
            set instance_name(val: string);
            get instanceName(): string;
            set instanceName(val: string);
            get windows(): Gtk.Window[];
            get settings(): Gtk.Settings;
            get screen(): Gdk.Screen;
            get gtk_theme(): string;
            set gtk_theme(val: string);
            get gtkTheme(): string;
            set gtkTheme(val: string);
            get icon_theme(): string;
            set icon_theme(val: string);
            get iconTheme(): string;
            set iconTheme(val: string);
            get cursor_theme(): string;
            set cursor_theme(val: string);
            get cursorTheme(): string;
            set cursorTheme(val: string);

            // Constructors

            constructor(properties?: Partial<Application.ConstructorProps>, ...args: any[]);

            _init(...args: any[]): void;

            static ['new'](): Application;

            // Signals

            connect(id: string, callback: (...args: any[]) => any): number;
            connect_after(id: string, callback: (...args: any[]) => any): number;
            emit(id: string, ...args: any[]): void;
            connect(signal: 'monitor-added', callback: (_source: this, monitor: Gdk.Monitor) => void): number;
            connect_after(signal: 'monitor-added', callback: (_source: this, monitor: Gdk.Monitor) => void): number;
            emit(signal: 'monitor-added', monitor: Gdk.Monitor): void;
            connect(signal: 'monitor-removed', callback: (_source: this, monitor: Gdk.Monitor) => void): number;
            connect_after(signal: 'monitor-removed', callback: (_source: this, monitor: Gdk.Monitor) => void): number;
            emit(signal: 'monitor-removed', monitor: Gdk.Monitor): void;

            // Static methods

            static get_instances(): string[];
            static quit_instance(instance: string): void;
            static open_inspector(instance: string): void;
            static toggle_window_by_name(instance: string, window: string): void;
            static send_message(instance_name: string, msg: string): string;

            // Virtual methods

            vfunc_request(msg: string, conn: Gio.SocketConnection): void;

            // Methods

            reset_css(): void;
            inspector(): void;
            get_window(name: string): Gtk.Window | null;
            toggle_window(window: string): void;
            apply_css(style: string, reset: boolean): void;
            add_icons(path?: string | null): void;
            request(msg: string, conn: Gio.SocketConnection): void;
            acquire_socket(): boolean;
            message(msg?: string | null): string;
            quit(): void;
            get_socket_path(): string;
            get_monitors(): Gdk.Monitor[];
            get_instance_name(): string;
            set_instance_name(value: string): void;
            get_windows(): Gtk.Window[];
            get_settings(): Gtk.Settings;
            get_screen(): Gdk.Screen;
            get_gtk_theme(): string;
            set_gtk_theme(value: string): void;
            get_icon_theme(): string;
            set_icon_theme(value: string): void;
            get_cursor_theme(): string;
            set_cursor_theme(value: string): void;
        }

        module Process {
            // Signal callback interfaces

            interface Stdout {
                (out: string): void;
            }

            interface Stderr {
                (err: string): void;
            }

            // Constructor properties interface

            interface ConstructorProps extends GObject.Object.ConstructorProps {
                argv: string[];
            }
        }

        class Process extends GObject.Object {
            static $gtype: GObject.GType<Process>;

            // Properties

            get argv(): string[];

            // Constructors

            constructor(properties?: Partial<Process.ConstructorProps>, ...args: any[]);

            _init(...args: any[]): void;

            static subprocessv(cmd: string[]): Process;

            static ['new'](): Process;

            // Signals

            connect(id: string, callback: (...args: any[]) => any): number;
            connect_after(id: string, callback: (...args: any[]) => any): number;
            emit(id: string, ...args: any[]): void;
            connect(signal: 'stdout', callback: (_source: this, out: string) => void): number;
            connect_after(signal: 'stdout', callback: (_source: this, out: string) => void): number;
            emit(signal: 'stdout', out: string): void;
            connect(signal: 'stderr', callback: (_source: this, err: string) => void): number;
            connect_after(signal: 'stderr', callback: (_source: this, err: string) => void): number;
            emit(signal: 'stderr', err: string): void;

            // Static methods

            static subprocess(cmd: string): Process;
            static execv(cmd: string[]): string;
            static exec(cmd: string): string;
            static exec_asyncv(cmd: string[], _callback_?: Gio.AsyncReadyCallback<Process> | null): void;
            static exec_asyncv_finish(_res_: Gio.AsyncResult): string;
            static exec_async(cmd: string, _callback_?: Gio.AsyncReadyCallback<Process> | null): void;
            static exec_finish(_res_: Gio.AsyncResult): string;

            // Methods

            kill(): void;
            signal(signal_num: number): void;
            write(_in: string): void;
            write_async(_in: string): void;
            get_argv(): string[];
        }

        module Time {
            // Signal callback interfaces

            interface Now {
                (): void;
            }

            interface Cancelled {
                (): void;
            }

            // Constructor properties interface

            interface ConstructorProps extends GObject.Object.ConstructorProps {}
        }

        class Time extends GObject.Object {
            static $gtype: GObject.GType<Time>;

            // Constructors

            constructor(properties?: Partial<Time.ConstructorProps>, ...args: any[]);

            _init(...args: any[]): void;

            static interval_prio(interval: number, prio: number, fn?: GObject.Closure | null): Time;

            static timeout_prio(timeout: number, prio: number, fn?: GObject.Closure | null): Time;

            static idle_prio(prio: number, fn?: GObject.Closure | null): Time;

            static ['new'](): Time;

            // Signals

            connect(id: string, callback: (...args: any[]) => any): number;
            connect_after(id: string, callback: (...args: any[]) => any): number;
            emit(id: string, ...args: any[]): void;
            connect(signal: 'now', callback: (_source: this) => void): number;
            connect_after(signal: 'now', callback: (_source: this) => void): number;
            emit(signal: 'now'): void;
            connect(signal: 'cancelled', callback: (_source: this) => void): number;
            connect_after(signal: 'cancelled', callback: (_source: this) => void): number;
            emit(signal: 'cancelled'): void;

            // Static methods

            static interval(interval: number, fn?: GObject.Closure | null): Time;
            static timeout(timeout: number, fn?: GObject.Closure | null): Time;
            static idle(fn?: GObject.Closure | null): Time;

            // Methods

            cancel(): void;
        }

        module VariableBase {
            // Signal callback interfaces

            interface Changed {
                (): void;
            }

            interface Dropped {
                (): void;
            }

            interface Error {
                (err: string): void;
            }

            // Constructor properties interface

            interface ConstructorProps extends GObject.Object.ConstructorProps {}
        }

        class VariableBase extends GObject.Object {
            static $gtype: GObject.GType<VariableBase>;

            // Constructors

            constructor(properties?: Partial<VariableBase.ConstructorProps>, ...args: any[]);

            _init(...args: any[]): void;

            static ['new'](): VariableBase;

            // Signals

            connect(id: string, callback: (...args: any[]) => any): number;
            connect_after(id: string, callback: (...args: any[]) => any): number;
            emit(id: string, ...args: any[]): void;
            connect(signal: 'changed', callback: (_source: this) => void): number;
            connect_after(signal: 'changed', callback: (_source: this) => void): number;
            emit(signal: 'changed'): void;
            connect(signal: 'dropped', callback: (_source: this) => void): number;
            connect_after(signal: 'dropped', callback: (_source: this) => void): number;
            emit(signal: 'dropped'): void;
            connect(signal: 'error', callback: (_source: this, err: string) => void): number;
            connect_after(signal: 'error', callback: (_source: this, err: string) => void): number;
            emit(signal: 'error', err: string): void;

            // Methods

            emit_changed(): void;
            emit_dropped(): void;
            emit_error(err: string): void;
        }

        module Variable {
            // Constructor properties interface

            interface ConstructorProps extends VariableBase.ConstructorProps {
                value: GObject.Value;
            }
        }

        class Variable extends VariableBase {
            static $gtype: GObject.GType<Variable>;

            // Properties

            get value(): GObject.Value;
            set value(val: GObject.Value);

            // Constructors

            constructor(properties?: Partial<Variable.ConstructorProps>, ...args: any[]);

            _init(...args: any[]): void;

            static ['new'](init: GObject.Value | any): Variable;
            // Conflicted with Astal.VariableBase.new

            static ['new'](...args: never[]): any;

            // Methods

            poll(interval: number, exec: string, transform?: GObject.Closure | null): Variable;
            pollv(interval: number, execv: string[], transform?: GObject.Closure | null): Variable;
            pollfn(interval: number, fn: GObject.Closure): Variable;
            watch(exec: string, transform?: GObject.Closure | null): Variable;
            watchv(execv: string[], transform?: GObject.Closure | null): Variable;
            start_poll(): void;
            start_watch(): void;
            stop_poll(): void;
            stop_watch(): void;
            is_polling(): boolean;
            is_watching(): boolean;
            get_value(): unknown;
            set_value(value: GObject.Value | any): void;
        }

        type BoxClass = typeof Box;
        abstract class BoxPrivate {
            static $gtype: GObject.GType<BoxPrivate>;

            // Constructors

            _init(...args: any[]): void;
        }

        type ButtonClass = typeof Button;
        abstract class ButtonPrivate {
            static $gtype: GObject.GType<ButtonPrivate>;

            // Constructors

            _init(...args: any[]): void;
        }

        type CenterBoxClass = typeof CenterBox;
        abstract class CenterBoxPrivate {
            static $gtype: GObject.GType<CenterBoxPrivate>;

            // Constructors

            _init(...args: any[]): void;
        }

        type CircularProgressClass = typeof CircularProgress;
        abstract class CircularProgressPrivate {
            static $gtype: GObject.GType<CircularProgressPrivate>;

            // Constructors

            _init(...args: any[]): void;
        }

        type EventBoxClass = typeof EventBox;
        abstract class EventBoxPrivate {
            static $gtype: GObject.GType<EventBoxPrivate>;

            // Constructors

            _init(...args: any[]): void;
        }

        type IconClass = typeof Icon;
        abstract class IconPrivate {
            static $gtype: GObject.GType<IconPrivate>;

            // Constructors

            _init(...args: any[]): void;
        }

        type LabelClass = typeof Label;
        abstract class LabelPrivate {
            static $gtype: GObject.GType<LabelPrivate>;

            // Constructors

            _init(...args: any[]): void;
        }

        type LevelBarClass = typeof LevelBar;
        abstract class LevelBarPrivate {
            static $gtype: GObject.GType<LevelBarPrivate>;

            // Constructors

            _init(...args: any[]): void;
        }

        type OverlayClass = typeof Overlay;
        abstract class OverlayPrivate {
            static $gtype: GObject.GType<OverlayPrivate>;

            // Constructors

            _init(...args: any[]): void;
        }

        type ScrollableClass = typeof Scrollable;
        abstract class ScrollablePrivate {
            static $gtype: GObject.GType<ScrollablePrivate>;

            // Constructors

            _init(...args: any[]): void;
        }

        type SliderClass = typeof Slider;
        abstract class SliderPrivate {
            static $gtype: GObject.GType<SliderPrivate>;

            // Constructors

            _init(...args: any[]): void;
        }

        type StackClass = typeof Stack;
        abstract class StackPrivate {
            static $gtype: GObject.GType<StackPrivate>;

            // Constructors

            _init(...args: any[]): void;
        }

        type WindowClass = typeof Window;
        abstract class WindowPrivate {
            static $gtype: GObject.GType<WindowPrivate>;

            // Constructors

            _init(...args: any[]): void;
        }

        type ApplicationClass = typeof Application;
        abstract class ApplicationPrivate {
            static $gtype: GObject.GType<ApplicationPrivate>;

            // Constructors

            _init(...args: any[]): void;
        }

        type ProcessClass = typeof Process;
        abstract class ProcessPrivate {
            static $gtype: GObject.GType<ProcessPrivate>;

            // Constructors

            _init(...args: any[]): void;
        }

        type TimeClass = typeof Time;
        abstract class TimePrivate {
            static $gtype: GObject.GType<TimePrivate>;

            // Constructors

            _init(...args: any[]): void;
        }

        type VariableBaseClass = typeof VariableBase;
        abstract class VariableBasePrivate {
            static $gtype: GObject.GType<VariableBasePrivate>;

            // Constructors

            _init(...args: any[]): void;
        }

        type VariableClass = typeof Variable;
        abstract class VariablePrivate {
            static $gtype: GObject.GType<VariablePrivate>;

            // Constructors

            _init(...args: any[]): void;
        }

        class ClickEvent {
            static $gtype: GObject.GType<ClickEvent>;

            // Fields

            release: boolean;
            time: number;
            x: number;
            y: number;
            modifier: Gdk.ModifierType;
            button: MouseButton;

            // Constructors

            _init(...args: any[]): void;

            // Methods

            init(event: Gdk.EventButton): void;
        }

        class HoverEvent {
            static $gtype: GObject.GType<HoverEvent>;

            // Fields

            lost: boolean;
            time: number;
            x: number;
            y: number;
            modifier: Gdk.ModifierType;
            mode: Gdk.CrossingMode;
            detail: Gdk.NotifyType;

            // Constructors

            _init(...args: any[]): void;

            // Methods

            init(event: Gdk.EventCrossing): void;
        }

        class ScrollEvent {
            static $gtype: GObject.GType<ScrollEvent>;

            // Fields

            time: number;
            x: number;
            y: number;
            modifier: Gdk.ModifierType;
            direction: Gdk.ScrollDirection;
            delta_x: number;
            delta_y: number;

            // Constructors

            _init(...args: any[]): void;

            // Methods

            init(event: Gdk.EventScroll): void;
        }

        class MotionEvent {
            static $gtype: GObject.GType<MotionEvent>;

            // Fields

            time: number;
            x: number;
            y: number;
            modifier: Gdk.ModifierType;

            // Constructors

            _init(...args: any[]): void;

            // Methods

            init(event: Gdk.EventMotion): void;
        }

        /**
         * Name of the imported GIR library
         * `see` https://gitlab.gnome.org/GNOME/gjs/-/blob/master/gi/ns.cpp#L188
         */
        const __name__: string;
        /**
         * Version of the imported GIR library
         * `see` https://gitlab.gnome.org/GNOME/gjs/-/blob/master/gi/ns.cpp#L189
         */
        const __version__: string;
    }

    export default Astal;
}

declare module 'gi://Astal' {
    import Astal01 from 'gi://Astal?version=0.1';
    export default Astal01;
}
// END
