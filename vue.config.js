module.exports = {
  pages: {
    popup: {
      template: 'public/browser-extension.html',
      entry: './src/popup/main.ts',
      title: 'Popup',
    },
    button: {
      template: 'public/browser-extension.html',
      entry: './src/button/main.ts',
      title: 'Button',
    },
    devtools: {
      template: 'public/browser-extension.html',
      entry: './src/devtools/main.ts',
      title: 'Devtools',
    },
  },
  pluginOptions: {
    browserExtension: {
      componentOptions: {
        background: {
          entry: 'src/background.ts',
        },
        contentScripts: {
          entries: {
            button: 'src/button/main.ts',
          },
        },
      },
    },
  },
};
