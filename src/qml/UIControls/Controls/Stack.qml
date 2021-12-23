

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
import QtQuick.Controls 2.5
import QtQuick 2.12

StackView {
    id: stackView
    clip: true
    padding: 0

    replaceEnter: Transition {
        SequentialAnimation {
            PropertyAction {
                property: "opacity"
                value: 0
            }
            PauseAnimation {
                duration: 100
            }

            OpacityAnimator {
                from: 0
                to: 1
                duration: 100
            }
        }
    }

    replaceExit: Transition {
        OpacityAnimator {
            from: 1
            to: 0.3
            duration: 100
        }

        PauseAnimation {
            duration: 100
        }
    }
    pushEnter: Transition {
        id: pushEnter
        ParallelAnimation {

            XAnimator {
                from: pushEnter.ViewTransition.item.width
                to: 0
                duration: 400
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                from: 0
                to: 1
                duration: 400
                easing.type: Easing.OutCubic
                properties: "opacity"
            }
        }
    }
    pushExit: Transition {
        id: pushExit
        ParallelAnimation {
            XAnimator {
                from: 0
                to: -pushEnter.ViewTransition.item.width
                duration: 400
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                from: 1
                to: 0
                duration: 400
                easing.type: Easing.OutCubic
                properties: "opacity"
            }
        }
    }

    popEnter: Transition {
        id: popEnter
        ParallelAnimation {
            XAnimator {
                from: -pushEnter.ViewTransition.item.width
                to: 0
                duration: 400
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                from: 0
                to: 1
                duration: 400
                easing.type: Easing.OutCubic
                properties: "opacity"
            }
        }
    }

    popExit: Transition {
        id: popExit
        ParallelAnimation {
            XAnimator {
                from: 0
                to: pushEnter.ViewTransition.item.width
                duration: 400
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                from: 1
                to: 0
                duration: 400
                easing.type: Easing.OutCubic
                properties: "opacity"
            }
        }
    }
}
