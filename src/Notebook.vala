/*
 * ev3devKit - ev3dev toolkit for LEGO MINDSTORMS EV3
 *
 * Copyright 2014 David Lechner <david@lechnology.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 */

/* Notebook.vala - Widget that represents a checkbox or radio button */

using Curses;
using Gee;
using GRX;

namespace EV3devKit {
    public class Notebook : EV3devKit.Container {
        Box notebook_vbox;
        Box tab_hbox;
        Gee.List<NotebookTab> tabs;
        Gee.Map<weak NotebookTab, weak TabButton> button_map;

        weak NotebookTab _active_tab;
        public weak NotebookTab active_tab {
            get { return _active_tab; }
            set {
                if (_active_tab != null) {
                    button_map[_active_tab].active = false;
                    notebook_vbox.remove (_active_tab);
                }
                button_map[value].active = true;
                notebook_vbox.add (value);
                _active_tab = value;
            }
        }

        public Notebook () {
            base (ContainerType.SINGLE);
            tabs = new LinkedList<NotebookTab> ();
            button_map = new Gee.HashMap<weak NotebookTab, weak Button> ();

            notebook_vbox = new Box.vertical ();
            tab_hbox = new Box.horizontal () {
                horizontal_align = WidgetAlign.START,
                vertical_align = WidgetAlign.START,
                spacing = -1
            };
            notebook_vbox.add (tab_hbox);

            margin = 10;
            border = 1;
            add (notebook_vbox);
            notify["active_tab"].connect (redraw);
        }

        public void add_tab (NotebookTab tab) {
            if (tab.notebook != null)
                tab.notebook.remove (tab);
            tabs.add (tab);
            var button = new TabButton (tab.title);
            button.pressed.connect (() => active_tab = tab);
            tab_hbox.add (button);
            button_map[tab] = button;
            if (active_tab == null)
                active_tab = tab;
        }

        public void remove_tab (NotebookTab tab) {
            tabs.remove (tab);
            var button = button_map[tab];
            button.parent.remove (button);
            button_map.unset (tab);
        }

        protected override void draw_border (GRX.Color color = window.screen.fg_color) {
            var notebook_y1 = border_bounds.y1 + tab_hbox.bounds. height;
            if (border_top != 0)
                filled_box (border_bounds.x1 + tab_hbox.bounds.width, notebook_y1,
                    border_bounds.x2 - border_radius,
                    notebook_y1 + border_top - 1, color);
            if (border_bottom != 0)
                filled_box (border_bounds.x1 + border_radius,
                    border_bounds.y2 - border_bottom + 1,
                    border_bounds.x2 - border_radius, border_bounds.y2, color);
            if (border_left != 0)
                filled_box (border_bounds.x1, notebook_y1 + border_radius,
                    border_bounds.x1 + border_left- 1,
                    border_bounds.y2 - border_radius, color);
            if (border_right != 0)
                filled_box (border_bounds.x2 - border_left + 1,
                    notebook_y1 + border_radius, border_bounds.x2,
                    border_bounds.y2 - border_radius, color);
            if (border_radius != 0) {
                circle_arc (border_bounds.x2 - border_radius,
                    notebook_y1 + border_radius, border_radius, 0, 900,
                    ArcStyle.OPEN, color);
                circle_arc (border_bounds.x1 + border_radius,
                    notebook_y1 + border_radius, border_radius, 900, 1800,
                    ArcStyle.OPEN, color);
                circle_arc (border_bounds.x1 + border_radius,
                    border_bounds.y2 - border_radius, border_radius, 1800, 2700,
                    ArcStyle.OPEN, color);
                circle_arc (border_bounds.x2 - border_radius,
                    border_bounds.y2 - border_radius, border_radius, 2700, 3600,
                    ArcStyle.OPEN, color);
            }
        }
    }
}
