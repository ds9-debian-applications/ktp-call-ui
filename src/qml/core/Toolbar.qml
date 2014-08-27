/*
 *  Copyright (C) 2014 Ekaitz Zárraga <ekaitz.zarraga@gmail.com>
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 1.1

Item{

    id: root
    width: toolsWidth; height: toolsHeight
    property int toolsWidth: menu.width +20
    property int toolsHeight: menu.height +30

      function setHoldEnabled(enable){ hold.setEnabled(enable)}

    //SIGNALS
    signal hangup()
    signal hold()

    function changeHoldIcon(icon){
      if(icon=="start")
      {
	hold.iconSource= "/usr/share/icons/oxygen/32x32/actions/media-playback-start.png"
      }else{
	hold.iconSource= "/usr/share/icons/oxygen/32x32/actions/media-playback-pause.png"
      }
    }


    Rectangle{
      id: background
      anchors.fill: parent
      color: "black"
      opacity: 0.7
      border.width: 1
      border.color: "dimgrey"
    }
    MouseArea{
      id:mouse
      hoverEnabled: true
      anchors.fill: parent
      onExited: {showTimer.restart()}
      onEntered: {root.state=""}
      Timer {
	id:showTimer
	interval: 3000
	running: !parent.containsMouse
	onTriggered: {root.state= "hidden"}
      }
    }

    Row{
      id: menu
      spacing: 10
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.topMargin: 15
      anchors.top: parent.top
      Button{
	id: hangup
	iconSource: "/usr/share/icons/oxygen/32x32/actions/call-stop.png"
	onButtonClick: root.hangup()
	enabled:true
	Tooltip{
	  text: qsTr("hangup")
	}
      }
      Button{
	id: hold
	iconSource: "/usr/share/icons/oxygen/32x32/actions/media-playback-pause.png"
	onButtonClick: root.hold()
	enabled:false
	Tooltip{
	  text: qsTr("Hold")
	}
      }
      Separator{}
      ToggleButton{
	id: sound
	iconSource: "/usr/share/icons/oxygen/32x32/status/audio-volume-medium.png"
	onButtonClick: muteAction.toggle();
	enabled: muteAction.enabled
	checked: muteAction.checked
	Tooltip{
	  text: qsTr("Mute")
	}
      }
      ToggleButton{
	id: showMyVideo
	iconSource: "/usr/share/icons/oxygen/32x32/devices/camera-web.png"
	onButtonClick: showMyVideoAction.toggle();
	enabled: showMyVideoAction.enabled
	checked: showMyVideoAction.checked
	Tooltip{
	  text: qsTr("Show my video")
	}
      }
      Separator{}
      ToggleButton{
	id:showDialpad
	iconSource: "/usr/share/icons/oxygen/32x32/devices/phone.png"
	onButtonClick: showDtmfAction.toggle();
	enabled: showDtmfAction.enabled
        checked: showDtmfAction.checked
	Tooltip{
	  text: qsTr("Show dialpad")
	}
      }
   }

   states:[
   State{
     name: ""
     PropertyChanges{ target: root; height:60}
   },
   State{
     name: "hidden"
     PropertyChanges{ target: root; height:10}
  }]
  transitions:[
    Transition{
      from: ""; to:"hidden"
      PropertyAnimation{target: root; properties:"height"; easing.type: Easing.InOutQuad; duration: 300}
    },
    Transition{
      from: "hidden"; to:""
      PropertyAnimation{target: root; properties:"height"; easing.type: Easing.InOutQuad}
    }
  ]

}