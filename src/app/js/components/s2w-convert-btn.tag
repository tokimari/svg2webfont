<s2w-convert-btn>
  <button
    onclick="{ onConvert }"
    class="c-button c-flat-button { is-processing: converting, is-active: hasUpdateForConvert }"
    disabled="{ !svgItems.length > 0 }"
  >Convert</button>

  <script>
    const
      gulp = require('gulp'),
      iconfont = require('gulp-iconfont'),
      consolidate = require('gulp-consolidate'),
      fs = require('fs'),
      exec = require('child_process').exec,
      util = require(opts.path.src.util);

    const initialSvgItems = fontStore.getSvgs();
    const initialFontName = sampleStore.getFontName();
    const initialFontFormats = sampleStore.getSelectedFormats();
    this.svgItems = initialSvgItems;
    this.hasUpdateForConvert = false;

    function gulpIconfont(svgItems, cb) {
      const fontName = sampleStore.getFontName();
      gulp.src(svgItems)
        .pipe(iconfont({
          fontName: fontName,
          prependUnicode: true,
          formats: sampleStore.getSelectedFormats()
        }))
      .on('glyphs', function(glyphs, options) {
        // NOTE: icon名とunicodeの対応一覧の生成
        console.log('glyphs', glyphs, options);
        gulp.src(opts.path.conf.glyphs)
          .pipe(consolidate('lodash', {
            fontName: fontName,
            glyphs: glyphs
          }))
        .pipe(gulp.dest(opts.path.dest.sample))
      })
      .pipe(gulp.dest(opts.path.dest.fonts))
      .on('end', function() {
        cb();
      });
    }

    /**
     * dropareaにファイルが追加された時
     */
    fontStore.on('changed', () => {
      this.svgItems = fontStore.getSvgs();
      if(this.svgItems !== initialSvgItems) {
        this.hasUpdateForConvert = true;
      }
      this.update();
    })
    sampleStore.on('changed', (type) => {
      const fontName = sampleStore.getFontName();
      const formats = sampleStore.getSelectedFormats();
      if(fontName !== initialFontName || formats !== initialFontFormats) {
        this.hasUpdateForConvert = true;
      }
      this.update();
    })

    this.onConvert = () => {
      if(this.svgItems.length === 0) {
        alert('not exist SVG files');
        return
      }
      this.hasUpdateForConvert = false;
      this.converting = true;

      gulpIconfont(this.svgItems, () => {
        fontAction.complete();
        this.converting = false;
        this.update();
      });
    }
  </script>
</s2w-convert-btn>
