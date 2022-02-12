
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

    readonly property string user: ""
    readonly property string plug: ""
    readonly property string folder: ""
    readonly property string statistics: ""
    readonly property string warning: ""
    readonly property string card: ""
    readonly property string loup: ""
    readonly property string filter: ""
    readonly property string addUser: ""
    readonly property string refresh: ""
    readonly property string minus: ""
    readonly property string plus: ""
    readonly property string check: ""
    readonly property string cart: ""
    readonly property string leftArrow: ""
    readonly property string downArrow: ""
    readonly property string lasercutter: ""
    readonly property string printer3d: ""
    readonly property string running: ""
    readonly property string power: ""
    readonly property string plotter: ""
    readonly property string userSuccess: ""
    readonly property string handTool: ""
    readonly property string userDelete: ""
    //readonly property string user: ""
    readonly property string settings: ""
    readonly property string save: ""
    readonly property string money: ""
    readonly property string gear: ""
    readonly property string trash: ""
    readonly property string forbidden: ""
    readonly property string warning2: ""
    readonly property string shield: ""
    readonly property string rightAngle: ""
    readonly property string leftAngle: ""
    readonly property string blizzard: ""
    readonly property string coins: ""
    readonly property string borrowBox: ""
    readonly property string admin: ""
    readonly property string logout: ""
    readonly property string lock: ""
    readonly property string eMail: ""
    readonly property string server: ""
    readonly property string swap: ""
    readonly property string link: ""
    readonly property string fan: ""
    readonly property string circle: ""
    readonly property string document: ""
    readonly property string group: ""
    readonly property string uploadFile: ""
    readonly property string downloadFile: ""
    readonly property string dot: ""
    readonly property string prompt: ""
    readonly property string keyboard: ""
    readonly property string disconnect: ""
    readonly property string calendar: ""
    readonly property string piechart: ""
    readonly property string no: ""
    readonly property string cancel: ""
    readonly property string yes: check
    readonly property string earth: ""
    readonly property string offline: ""
    readonly property string payDesk: ""
    readonly property string banknote: ""

    readonly property string products: ""
    readonly property string lockOpen: ""
    readonly property string lockClosed: ""

    readonly property string wifi: ""

    readonly property string burger: ""

    readonly property string info: ""
    readonly property string infoRound: ""
    readonly property string question: ""

    //readonly property string warning: ""

    //readonly property string card: ""
    property int iconSize24: scale(24)
    property int iconSize300: scale(300)

    function scale(val) {
        return parseInt(val * 1)
    }
}
