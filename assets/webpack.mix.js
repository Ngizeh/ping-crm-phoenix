let mix = require('laravel-mix');
let path = require('path');

/*
|--------------------------------------------------------------------------
| Mix Asset Management
|--------------------------------------------------------------------------
|
| Mix provides a clean, fluent API for defining some Webpack build steps
| for your Laravel application. By default, we are compiling the Sass
| file for the application as well as bundling up all the JS files.
|
*/

mix.setPublicPath('../priv/static/assets')
.js('js/app.js', 'app.js')
.vue()
.alias({
    '@': '../assets/js',
})
.webpackConfig({
    output: {
        chunkFilename: 'js/[name].js?id=[chunkhash]',
    },
})
.version()
.sourceMaps()