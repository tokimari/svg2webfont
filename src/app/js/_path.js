const get = (dirName) => {
  return {
    conf: {
      glyphs: dirName + "/src/sample/config/config.json"
    },
    src: {
      jade: dirName + "/src/sample/jade/index.jade",
      stylus: dirName + "/src/sample/stylus/index.styl",
      util: dirName + "/src/app/js/utilities",
      params: dirName + "/src/app/js/_params.json"
    },
    dest: {
      sample: dirName + "/dest/sample/",
      fonts: dirName + "/dest/sample/",
      files: {
        html:dirName + "/dest/sample/index.html",
        css: dirName + "/dest/sample/index.css",
        glyphs: dirName + "/dest/sample/config.json",
        zip: dirName + "/dest/sample.zip"
      }
    }
  }
}
module.exports = get;
