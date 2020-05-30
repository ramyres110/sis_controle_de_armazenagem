const { src, dest, series } = require('gulp');

function build() {
    return src('./src/**/*.js')
        .pipe(dest('./bin'));
}

exports.build = build;
exports.default = series(build);