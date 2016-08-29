# [WIP] svg2webfonts

Convert SVG icon files to webfonts on Desktop app(Electron), and generate sample HTML/CSS files.

NOTE:
* Format: SVG/TTF/EOT/WOFF/WOFF2
* This app use [gulp-iconfont](https://github.com/nfroidure/gulp-iconfont) to convert webfonts on background.


## For Developpers

How to build by yourself:

```
$ npm i

# for development
$ gulp build       # build for app resources.
$ npm run build    # open app

# for use
$ npm run package  # build & packaging this app

# for build styleguide for development
$ gulp styleguide && open ./dest/styleguide/index.html
```


## For Designers

Designers need make SVG files in the following format:

1. SVG icon file must be at least 500px or more.
2. SVG icon file name format:
  - u{unicode}-{icon name}.svg
  - example: uF000-home.svg, uF001-arrow.svg
