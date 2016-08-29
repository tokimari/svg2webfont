'use strict';

const electron = require('electron');
const {app} = electron;
const {BrowserWindow} = electron;

let win;

function createWindow() {
  win = new BrowserWindow({
    width: 1000,
    height: 800,
    titleBarStyle: 'hidden-inset'
  });
  win.loadURL(`file://${__dirname}/index.html`);
  win.once('ready-to-show', () => {
    win.show()
  });

  // for develop mode
  win.webContents.openDevTools();

  win.on('closed', () => {
    win = null;
  });
}

app.on('ready', createWindow);

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});

app.on('activate', () => {
  if (win === null) {
    createWindow();
  }
})
