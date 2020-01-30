/*
 * Copyright (C) 2019,2020 Panasonic Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import QtQuick 2.6
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0
import AGL.Demo.Controls 1.0
import AGL.Demo.CircularProgressBar 1.0
import agl.examples.FileIO 1.0

ApplicationWindow {
    id: root

    width: container.width * container.scale
    height: container.height * container.scale

    Item {
        id: container
        anchors.centerIn: parent
        width: 1080
        height: 1487
        scale: screenInfo.scale_factor()

        property int count: 300

        Item {
            id: reboot
            property string file: ''
        }

        FileIO {
            id: fileio
        }

        Timer {
            id: timer_clean
            interval: 2000; running: false; repeat: false
            onTriggered: {
                start.visible = false
                circle.visible = false

                circle.animationDuration = 0
                circle.value = 1.0
                time.text = '3'

                trig_ivi.enabled = true
                trig_ic.enabled = true
                trig_system.enabled = true
            }
        }

        Timer {
            id: timer_fin
            interval: 100; running: false; repeat: false
            onTriggered: {
                fileio.open(reboot.file)
                timer_clean.running = true
            }
        }

        Timer {
            id: timer_fire
            interval: 1000; running: false; repeat: false
            onTriggered: {
                circle.visible = false
                start.visible = true
                timer_fin.running = true
            }
        }

        Timer {
            id: timer_2nd
            interval: 1000; running: false; repeat: false
            onTriggered: {
                time.text = '1'
                timer_fire.running = true
                circle.animationDuration = 0
                circle.value = 1.0
                circle.animationDuration = 1000
                circle.value = 0.0
            }
        }

        Timer {
            id: timer_1st
            interval: 1000; running: false; repeat: false
            onTriggered: {
                time.text = '2'
                timer_2nd.running = true
                circle.animationDuration = 0
                circle.value = 1.0
                circle.animationDuration = 1000
                circle.value = 0.0
            }
        }

        ColumnLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 20
            Layout.preferredWidth: 800
            Layout.preferredHeight: 800
            Layout.alignment: Qt.AlignHCenter
            spacing: 100

            Label {
                Layout.alignment: Qt.AlignHCenter
                text: 'REBOOT DEMO'
                font.pixelSize: 80
                font.underline: true
            }

            CircularProgressBar {
                id: circle
                lineWidth: 50
                value: 1.0
                size: 600
                secondaryColor: "#424143"
                primaryColor: "#00ADDC"
                visible: false

                Text {
                    id: time
                    anchors.centerIn: parent
                    font.pixelSize: 400
                    color: 'white'
                    text: '3'
                }
            }

            Item {
                height: 600
                width: 600
                Text {
                    anchors.centerIn: parent
                    id: start
                    font.pixelSize: 120
                    color: 'yellow'
                    text: 'START REBOOT'
                    visible: false
                }
            }
        }

        ColumnLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.margins: 20

            ColumnLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.margins: 20
                spacing: 20

                Label {
                    text: 'Restart Container (Quick REBOOT)'
                    color: '#00ADDC'
                    font.pixelSize: 45
                }
                Button {
                    id: trig_ivi
                    Layout.preferredWidth: 600
                    Layout.preferredHeight: 120
                    Layout.alignment: Qt.AlignHCenter
                    text: 'IVI'
                    font.pixelSize: 50
                    font.bold: true
                    onClicked: {
                        reboot.file = '/etc/lxc/trigger-reboot-container-ivi'
                        trig_ivi.enabled = false
                        trig_ic.enabled = false
                        trig_system.enabled = false
                        time.visible = true
                        circle.visible = true
                        circle.animationDuration = 1000
                        circle.value = 0.0
                        timer_1st.running = true
                    }
                }
                Button {
                    id: trig_ic
                    Layout.preferredWidth: 600
                    Layout.preferredHeight: 120
                    Layout.alignment: Qt.AlignHCenter
                    text: 'IC'
                    font.pixelSize: 50
                    font.bold: true
                    onClicked: {
                        reboot.file = '/etc/lxc/trigger-reboot-container-ic'
                        trig_ivi.enabled = false
                        trig_ic.enabled = false
                        trig_system.enabled = false
                        time.visible = true
                        circle.visible = true
                        circle.animationDuration = 1000
                        circle.value = 0.0
                        timer_1st.running = true
                    }
                }

                ColumnLayout {
                    spacing: 20
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignHCenter

                    Label {
                        text: 'Reboot (Power OFF/ON)'
                        color: 'red'
                        font.pixelSize: 45
                    }

                    Button {
                        id: trig_system
                        Layout.preferredWidth: 600
                        Layout.preferredHeight: 120
                        Layout.alignment: Qt.AlignHCenter
                        text: 'System'
                        font.pixelSize: 50
                        font.bold: true
                        onClicked: {
                            reboot.file = '/etc/lxc/trigger-reboot-system'
                            trig_ivi.enabled = false
                            trig_ic.enabled = false
                            trig_system.enabled = false
                            time.visible = true
                            circle.visible = true
                            circle.animationDuration = 1000
                            circle.value = 0.0
                            timer_1st.running = true
                        }
                    }
                }
            }
        }
    }
}
