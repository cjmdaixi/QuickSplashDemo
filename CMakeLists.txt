cmake_policy(VERSION 3.5)
project(QuickSplashDemo)
cmake_minimum_required(VERSION 3.9)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set_property(DIRECTORY PROPERTY VS_STARTUP_PROJECT ${PROJECT_NAME})
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

find_package(Qt5 COMPONENTS Core Gui Qml Quick REQUIRED)


set(CMAKE_DEBUG_POSTFIX "d" CACHE STRING "add a postfix, usually d on windows")


set(SOURCES 
    main.cpp
)

set(RESOURCES 
    qml.qrc
)

set(QMLS
    main.qml
	MainView.qml
	Splash.qml
)

option(OPEN_CONSOLE OFF)

if(OPEN_CONSOLE)
	add_executable(${PROJECT_NAME} ${HEADERS} ${SOURCES} ${RESOURCES} ${QMLS})
else()
	add_executable(${PROJECT_NAME} WIN32 ${HEADERS} ${SOURCES} ${RESOURCES} ${QMLS})
endif()

source_group("UI Files" FILES ${QMLS})

target_link_libraries(${PROJECT_NAME} Qt5::Core Qt5::Gui Qt5::Qml Qt5::Quick)