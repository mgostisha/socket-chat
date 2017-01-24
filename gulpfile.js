'use strict'
const gulp = require('gulp-help')(require('gulp'))
const coffee = require('gulp-coffee');
const sourcemaps = require('gulp-sourcemaps')
const cache = require('gulp-cached')

gulp.task('build', () => {
  return gulp.src('src/**/*.coffee')
    .pipe(cache('build:server'))
    .pipe(sourcemaps.init())
    .pipe(coffee({ bare: true }))
    .pipe(sourcemaps.write('../test/maps'))
    .pipe(gulp.dest('dist'))
})

gulp.task('dist:package', () => {
  return gulp.src('package.json')
    .pipe(gulp.dest('dist'))
})

gulp.task('dist', [ 'build', 'dist:package' ])

gulp.task('default', [ 'help' ])
