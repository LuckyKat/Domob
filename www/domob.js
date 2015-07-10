module.exports = {
showVideoWall: function (callback) {
    cordova.exec(callback, null, "LNDomob", "showVideoWall", []);
},
checkVideoAvailable: function (callback) {
    cordova.exec(callback, null, "LNDomob", "checkVideoAvailable", []);
},
}
