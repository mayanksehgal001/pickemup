const { environment } = require('@rails/webpacker')
const webpack = require('webpack')
const path = require('path');

const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')
const yaml = require('./loaders/yaml')

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin());
environment.plugins.append("Provide", new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
}))
environment.loaders.prepend('vue', vue)
environment.loaders.prepend('yaml', yaml)
environment.config.resolve.alias = {
  'vue$': 'vue/dist/vue.esm.js',
  '@': path.resolve(__dirname, '..', '..', 'app/javascript')
 };

module.exports = environment
