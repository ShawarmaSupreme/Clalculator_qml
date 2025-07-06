cmake_minimum_required(VERSION 3.16)

project(QMLCalculator VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

set(APP_SOURCES
    main.cpp
    Calculator.cpp
)

qt_add_executable(appQMLCalculator
    ${APP_SOURCES}
)

qt_add_qml_module(appQMLCalculator
    URI QMLCalculator
    VERSION 1.0
    QML_FILES
    main.qml
    RESOURCES
        images/bkt.png
        images/division.png
        images/equal.png
        images/minus.png
        images/multiplication.png
        images/percent.png
        images/plus.png
        images/plus_minus.png
        fonts/Open_Sans_Semibold.ttf
        images/active.png
        images/normal.png
    SOURCES
        Calculator.h
)

set_target_properties(appQMLCalculator PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appQMLCalculator
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appQMLCalculator
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
