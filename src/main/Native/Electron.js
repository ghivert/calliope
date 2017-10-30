import Electron from 'electron'

const app = Electron.app
let mainWindow = null

function platform() {
  return process.platform
}

function quit() {
  app.quit()
}

var windowAllClosed = _elm_lang$core$Native_Scheduler.nativeBinding(function(callback) {
  app.on('window-all-closed', function() {
    callback(_elm_lang$core$Native_Scheduler.succeed(
      // send subscriptions
    ))
  })
}

app.on('ready', async () => {
  if (process.env.NODE_ENV === 'development' || process.env.DEBUG_PROD === 'true') {
    await installExtensions();
  }

  mainWindow = new BrowserWindow({
    show: false,
    width: 1024,
    height: 728
  });

  mainWindow.loadURL(`file://${__dirname}/app.html`);

  // @TODO: Use 'ready-to-show' event
  //        https://github.com/electron/electron/blob/master/docs/api/browser-window.md#using-ready-to-show-event
  mainWindow.webContents.on('did-finish-load', () => {
    if (!mainWindow) {
      throw new Error('"mainWindow" is not defined');
    }
    mainWindow.show();
    mainWindow.focus();
  });

  mainWindow.on('closed', () => {
    mainWindow = null;
  });

  const menuBuilder = new MenuBuilder(mainWindow);
  menuBuilder.buildMenu();
});
