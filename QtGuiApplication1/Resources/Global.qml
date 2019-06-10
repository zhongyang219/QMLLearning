import QtQml 2.0
import QtQuick.Window 2.7

QtObject {
    function dpi(pixel) {
        var logicalDpi = Qt.application.screens[0].logicalPixelDensity*25.4;
        var dpi = pixel*logicalDpi/96;
        return dpi | 0
    }
}
