const { environment } = require('@rails/webpacker')
const webpack = require('webpack')
// referenciando su forma de acceder y sus fuentes, esto en ayuda de acceder de forma global a los contextos graficos
environment.plugins.prepend('Provide',
    new webpack.ProvidePlugin({
        $: 'jquery',
        jQuery: 'jquery',
        'window.jQuery':'jquery',
        Popper: ['popper.js', 'default']

    })
)
module.exports = environment
