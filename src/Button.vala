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

/* Button.vala - Widget that represents a selectable button */

using Curses;
using Gee;
using GRX;

namespace EV3devKit {
    public class Button : EV3devKit.Container {
        public signal void pressed ();

        public Button (Widget? child = null) {
            base (ContainerType.SINGLE);
            if (child != null)
                add (child);
            border = 1;
            padding = 2;
            can_focus = true;
        }

        public Button.with_label (string? text = null) {
            this (new Label (text));
        }

        protected override void draw_background () {
            if (has_focus) {
                var color = window.screen.mid_color;
                filled_box (border_bounds.x1, border_bounds.y1, border_bounds.x2,
                    border_bounds.y2, color);
            }
        }

        public override bool key_pressed (uint key_code) {
            if (key_code == '\n') {
                pressed ();
                Signal.stop_emission_by_name (this, "key-pressed");
                return true;
            }
            return base.key_pressed (key_code);
        }
    }
}
