

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
import QtQuick 2.5

Item {
    id: docroot

    property var target: parent
    property bool shadowTop: true
    property bool shadowBottom: true
    property bool shadowRight: true
    property bool shadowLeft: true
    property color shadowColor: "black"

    property int shadowSize: 8
    opacity: .02

    QtObject {
        id: p
    }

    function calcGradient(width) {
        return Math.sqrt(2) * width
    }

    Rectangle {
        id: top
        z: docroot.z
        visible: docroot.shadowTop
        height: shadowSize
        width: target.width
        y: -shadowSize
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: "transparent"
            }
            GradientStop {
                position: 1.0
                color: docroot.shadowColor
            }
        }
    }

    Rectangle {
        id: right
        z: docroot.z
        visible: docroot.shadowRight
        height: shadowSize
        width: target.height
        y: target.height / 2 - shadowSize / 2
        x: target.width - target.height / 2 + shadowSize
           / 2 //(target.width/2) - (shadowSize/2) + 50 +4
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: "transparent"
            }
            GradientStop {
                position: 1.0
                color: docroot.shadowColor
            }
        }
        rotation: 90
    }

    Rectangle {
        id: left
        z: docroot.z
        visible: docroot.shadowLeft
        height: shadowSize
        width: target.height
        y: target.height / 2 - shadowSize / 2
        x: -(target.height / 2 + shadowSize / 2)
        gradient: Gradient {
            GradientStop {
                position: 1.0
                color: "transparent"
            }
            GradientStop {
                position: 0.0
                color: docroot.shadowColor
            }
        }
        rotation: 90
    }

    Rectangle {
        id: bottom
        z: docroot.z
        visible: docroot.shadowBottom
        height: shadowSize
        width: target.width
        y: target.height
        gradient: Gradient {
            GradientStop {
                position: 1.0
                color: "transparent"
            }
            GradientStop {
                position: 0.0
                color: docroot.shadowColor
            }
        }
    }

    /*----------------------*/
    Rectangle {
        id: bottomLeft
        color: "transparent"
        x: -shadowSize
        y: target.height
        z: docroot.z
        visible: docroot.shadowBottom && docroot.shadowLeft
        width: docroot.shadowSize
        height: docroot.shadowSize
        clip: true

        Rectangle {
            width: docroot.calcGradient(parent.width)
            height: width
            anchors.centerIn: parent
            rotation: 45
            gradient: Gradient {
                GradientStop {
                    position: 0.5
                    color: "transparent"
                }
                GradientStop {
                    position: 0.0
                    color: docroot.shadowColor
                }
            }
        }
    }

    Rectangle {
        id: topRight
        color: "transparent"
        x: target.width
        y: -shadowSize
        z: docroot.z
        visible: docroot.shadowTop && docroot.shadowRight
        width: docroot.shadowSize
        height: docroot.shadowSize
        clip: true

        Rectangle {
            width: docroot.calcGradient(parent.width)
            height: width
            anchors.centerIn: parent
            rotation: 225
            gradient: Gradient {
                GradientStop {
                    position: 0.5
                    color: "transparent"
                }
                GradientStop {
                    position: 0.0
                    color: docroot.shadowColor
                }
            }
        }
    }

    Rectangle {
        id: bottomRight
        color: "transparent"
        x: target.width
        y: target.height
        z: docroot.z
        visible: docroot.shadowBottom && docroot.shadowRight
        width: docroot.shadowSize
        height: docroot.shadowSize
        clip: true

        Rectangle {
            width: docroot.calcGradient(parent.width)
            height: width
            anchors.centerIn: parent
            rotation: 315
            gradient: Gradient {
                GradientStop {
                    position: 0.5
                    color: "transparent"
                }
                GradientStop {
                    position: 0.0
                    color: docroot.shadowColor
                }
            }
        }
    }

    Rectangle {
        id: topLeft
        color: "transparent"
        x: -shadowSize
        y: -shadowSize
        z: docroot.z
        visible: docroot.shadowTop && docroot.shadowLeft
        width: docroot.shadowSize
        height: docroot.shadowSize
        clip: true

        Rectangle {
            width: docroot.calcGradient(parent.width)
            height: width
            anchors.centerIn: parent
            rotation: 135
            gradient: Gradient {
                GradientStop {
                    position: 0.5
                    color: "transparent"
                }
                GradientStop {
                    position: 0.0
                    color: docroot.shadowColor
                }
            }
        }
    }
}
