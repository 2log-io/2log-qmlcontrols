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


import QtQuick 2.8
import UIControls 1.0
import CloudAccess 1.0

Item
{
    id: docroot
    signal cardRead(var data)
    property bool ready: reader.deviceOnline || (isMobile && nfcReader.ready)
    property int state
    property string mapping
    property string lastCardID
    onMappingChanged: console.log("MAPPING:" + mapping);
    Component.onCompleted: if(isMobile) nfcReader.startRead()

    SynchronizedObjectModel
    {
        id: settingsModel
        resource: "home/settings/cardreader"
        onInitializedChanged:
        {
            var mapping = settingsModel.selectedReader
            if(mapping !== "")
                docroot.mapping = Qt.binding(function(){return settingsModel.selectedReader})
        }
    }

    DeviceModel
    {
        id: reader
        resource: docroot.mapping

        onDataReceived:
        {
            docroot.lastCardID = subject
            labService.call("getUserForCard", {"cardID": subject}, docroot.callback )
        }
    }

    ServiceModel
    {
        id: labService
        service: "lab"
    }

    Connections
    {
        enabled: isMobile
        target: enabled ? nfcReader : null
        onUidRead:
        {
            docroot.lastCardID = uid
            labService.call("getUserForCard", {"cardID": docroot.lastCardID}, docroot.callback )

        }
    }

    function callback(data)
    {
        docroot.cardRead(data)
    }
}
