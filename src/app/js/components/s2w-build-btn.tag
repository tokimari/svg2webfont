<s2w-build-btn>
  <button
    onclick="{ onBuild }"
    class="c-button c-flat-button { is-processing: building, is-active: hasUpdateForBuild }"
    disabled="{ !hasGlyphsConfig || converting | hasUpdateForConvert }"
  >Build</button>

  <script>

    // require packages
    const
      stylus = require('stylus'),
      nib = require('nib'),
      jade = require('jade'),
      fs = require('fs'),
      exec = require('child_process').exec,
      util = require(opts.path.src.util);

    // initialization
    const initialFontName = sampleStore.getFontName();
    const initialFontFormats = sampleStore.getSelectedFormats();
    const initialSampleText = sampleStore.getText();
    const initialFontSizes = sampleStore.getSelectedFontSizes();
    this.hasUpdateForConvert = false;
    this.hasUpdateForBuild = false;
    this.hasGlyphsConfig = fontStore.getConfig() || false;

    function buildJade() {
      return new Promise((resolve, reject) => {
        const
          sampleText = sampleStore.getText(),
          fontName = sampleStore.getFontName(),
          fontSizes = sampleStore.getSelectedFontSizes(),
          glyphsConfig = fontStore.getConfig(),
          jadeStr = util.readFileSync(opts.path.src.jade),
          compileFunc = jade.compile(jadeStr, {
            pretty: true
          });
        let html = null;
        if(!glyphsConfig) {
          sampleAction.error({
            type: 'build:jade',
            name: 'Not Found',
            message: 'Not fount glyphs config.json'
          });
          reject();
          return
        }

        try {
          html = compileFunc({
            fontName: fontName,
            sampleText: sampleText,
            fontSize: fontSizes,
            glyphs: glyphsConfig,
            indexUnit: Math.round(glyphsConfig.icons.length / 5)
          });
        } catch (err) {
          sampleAction.error({
            type: 'build:jade',
            name: 'compile error',
            message: err.message
          });
          reject();
          return
        }

        if(!util.isExistFile(opts.path.dest.sample)) {
          fs.mkdirSync(opts.path.dest.sample);

        }
        fs.writeFileSync(opts.path.dest.files.html, html);
        resolve();
      })
    }

    function buildStylus() {
      return new Promise((resolve, reject) => {
        const stylusStr = util.readFileSync(opts.path.src.stylus);
        if(!util.isExistFile(opts.path.dest.sample)) {
          fs.mkdirSync(opts.path.dest.sample);
        }
        stylus(stylusStr)
        .define('fontName', sampleStore.getFontName())
        .define('fontFormats', sampleStore.getSelectedFormats())
        .define('fontSize', sampleStore.getSelectedFontSizes())
        .define('glyphs', fontStore.getConfig())
        .use(nib())
        .import('nib')
        .render((err, css) => {
          if(err) {
            fontAction.error({
              type: 'build:stylus',
              name: err.name,
              message: err.message
            });
            reject();
          }
          if(css) {
            fs.writeFileSync(opts.path.dest.files.css, css);
          }
          resolve();
        });
      })
    }

    fontStore.on('complete', () => {
      this.hasUpdateForConvert = false;
      this.hasUpdateForBuild = true;
      this.hasGlyphsConfig = true;
      this.update();
    })

    sampleStore.on('changed', (type) => {
      const fontName = sampleStore.getFontName();
      const formats = sampleStore.getSelectedFormats();
      const sampleText = sampleStore.getText();
      const fontSizes = sampleStore.getSelectedFontSizes();
      if(fontName !== initialFontName || formats !== initialFontFormats) {
        this.hasUpdateForConvert = true;
        this.update();
        return
      }

      if(sampleText !== initialSampleText || fontSizes !== initialFontSizes) {
        this.hasUpdateForBuild = true;
        this.update();
      }
    })

    this.onBuild = () => {
      // FIXME: sampleAction.startというnamingが変
      fontAction.start();
      this.hasUpdateForBuild = false;
      this.building = true;
      this.update();

      Promise.all([
        buildJade(),
        buildStylus()
      ]).then(() => {
        this.building = false;
        this.update();
        sampleAction.complete();
      }, (reason) => {
        this.building = false;
        this.update();
        sampleAction.openModal();
      });
    }

  </script>
</s2w-build-btn>
