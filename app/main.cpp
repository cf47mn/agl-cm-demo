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

#include <QtAGLExtras/AGLApplication>
#include <QtQml/QQmlApplicationEngine>
#include <QtQml/QQmlContext>

#include "FileIO.hpp"

int main(int argc, char *argv[])
{
    AGLApplication app(argc, argv);
    app.setApplicationName("AGL-CM-DEMO");
    app.setupApplicationRole("cm"); 

    qmlRegisterType<FileIO>("agl.examples.FileIO", 1, 0, "FileIO");

    app.load(QUrl(QStringLiteral("qrc:/ContainerManagerDemo.qml")));
    return app.exec();
}

