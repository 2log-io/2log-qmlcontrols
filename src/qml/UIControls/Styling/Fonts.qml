
/*   2log.io
 *   Copyright (C) 2021 - 2log.io | mail@2log.io,  mail@friedemann-metzger.de
 *
 *   This program is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU Affero General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Affero General Public License for more details.
 *
 *   You should have received a copy of the GNU Affero General Public License
 *   along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
pragma Singleton

import QtQuick 2.5

Item {

    property var fontAwesome_free_solid_loader: FontLoader {
        source: "../Assets/Fonts/Font Awesome 5 Free-Solid-900.otf"
    }

    property var simplonNorm_Medium_loader: FontLoader {
        source: "../Assets/Fonts/SimplonNorm-Medium.otf"
    }
    property var simplonNorm_Regular_loader: FontLoader {
        source: "../Assets/Fonts/SimplonNorm-Regular.otf"
    }
    property var simplonNorm_Light_loader: FontLoader {
        source: "../Assets/Fonts/SimplonNorm-Light.otf"
    }
    property var simplonNorm_Bold_loader: FontLoader {
        source: "../Assets/Fonts/SimplonNorm-Bold.otf"
    }
    property var simplonMono_Medium_loader: FontLoader {
        source: "../Assets/Fonts/SimplonMono-Medium.otf"
    }
    property var simplonMono_Light_loader: FontLoader {
        source: "../Assets/Fonts/SimplonMono-Light.otf"
    }
    property var simplonMono_Regular_loader: FontLoader {
        source: "../Assets/Fonts/SimplonMono-Regular.otf"
    }

    readonly property var simplonNorm_Medium: simplonNorm_Medium_loader.name
    readonly property var simplonNorm_Regular: simplonNorm_Regular_loader.name
    readonly property var simplonNorm_Light: simplonNorm_Light_loader.name
    readonly property var simplonMono: simplonMono_Medium_loader.name

    readonly property var iconFont: fontAwesome_free_solid_loader.name

    readonly property int headerFontSze: 20
    readonly property int subHeaderFontSize: 16
    readonly property int contentFontSize: 15
    readonly property int smallControlFontSize: 14
    readonly property int verySmallControlFontSize: 12
    readonly property int listDelegateSize: contentFontSize
    readonly property int controlFontSize: contentFontSize
    readonly property int bigDisplayFontSize: 36
    readonly property int bigDisplayUnitFontSize: 18
    readonly property int actionFontSize: 24
}
