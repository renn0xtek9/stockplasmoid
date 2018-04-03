set(warrantmodel)

find_package(Qt5 ${QT_MIN_VERSION} CONFIG REQUIRED COMPONENTS Core Widgets Qml)

find_package(KF5IconThemes)


file (GLOB SRC "*.cpp" ) 
set (SRC ${SRC} ./../warrantmodel.cpp ./../abstract_stock.cpp )
include_directories(./../)

add_executable(warrantmodelTEST ${SRC})
target_link_libraries(warrantmodelTEST Qt5::Widgets Qt5::Qml  KF5::IconThemes)

