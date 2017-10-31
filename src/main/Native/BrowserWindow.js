const Electron = require('electron')

var mainWindow = null

var _ghivert$calliope$Native_BrowserWindow = function () {

  function create(browserWindow) {
    return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback) {
      callback(
        _elm_lang$core$Native_Scheduler.succeed(
          createWindow(browserWindow)
        )
      )
    })
  }

  function createWindow(browserWindow) {
    mainWindow = new Electron.BrowserWindow()
    mainWindow.loadURL(browserWindow.url)
    return mainWindow
  }

  function computeOptions(browserWindow) {
    var options = {}
    if (browserWindow.width.ctor == 'Just') {
      options.width = browserWindow.width._0
    }
    if (browserWindow.height.ctor == 'Just') {
      options.height = browserWindow.height._0
    }
    if (browserWindow.backgroundColor.ctor == 'Just') {
      options.backgroundColor = browserWindow.backgroundColor._0
    }
    if (browserWindow.coordinates.ctor == 'Just') {
      options.coordinates = browserWindow.coordinates._0
    }
    if (browserWindow.show.ctor == 'Just') {
      options.show = browserWindow.show._0
    }
    return options
  }

  return {
    create: create
  }
}()
