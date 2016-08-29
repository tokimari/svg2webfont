import gulp from 'gulp';
import stylus from 'gulp-stylus';
import jade from 'gulp-jade';
import riot from 'gulp-riot';
import watch from 'gulp-watch';
import babel from 'gulp-babel';
import nib from 'nib';
import concat from 'gulp-concat';
import del from 'del';
import aigis from 'gulp-aigis';

const _path = {
  src: {
    stylus: [__dirname + "/src/app/stylus/**/*.styl", "!**/_*.styl"],
    components: __dirname + "/src/app/js/components/**/*.tag",
    js: __dirname + "/src/app/js/*.js",
    icon: __dirname + "/src/app/samplicons.woff2",
    iconConfig: __dirname + "/src/app/config.json",
    styleguide: __dirname + "/aigis_config.yml"
  },
  dest: {
    css: __dirname + "/dest/app/css/",
    js: __dirname + "/dest/app/js/"
  }
};

const samplicons = require(_path.src.iconConfig);

gulp.task('clean', () => {
  del(['dest']);
})

gulp.task('build', [
  'build:stylus',
  'build:js'
])

gulp.task('watch', () => {
  gulp.watch([
    _path.src.components,
    _path.src.js
  ], ['build:js']);

  gulp.watch(_path.src.stylus, ['build:stylus']);
})

gulp.task('copy', () => {
  gulp.src(_path.src.icon)
  .pipe(gulp.dest(_path.dest.css))
})

gulp.task('build:stylus', ['copy'], () => {
  gulp.src(_path.src.stylus)
    .pipe(stylus({
      compress: false,
      define: {
        iconData: samplicons
      },
      use: [nib()]
    }))
    .pipe(gulp.dest(_path.dest.css));
})

gulp.task('build:components', () => {
  gulp.src([_path.src.components])
    .pipe(riot({
      compact: true,
      parserOptions: {
        js: {
          babelrc: false,
          presets: ["es2015-riot"]
        }
      }
    }))
    .pipe(concat('components.js'))
    .pipe(gulp.dest(_path.dest.js));
})

gulp.task('build:js', ['build:components'], () => {
  gulp.src(_path.src.js)
    .pipe(babel({
      presets: ["es2015"]
    }))
    .pipe(gulp.dest(_path.dest.js));

})

gulp.task('styleguide', () => {
  gulp.src(_path.src.styleguide)
    .pipe(aigis());
})
