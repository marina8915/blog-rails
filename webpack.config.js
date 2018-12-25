const webpack = require("webpack");

module.exports = {
    context: __dirname + "/app/javascript/packs",

    entry: {
        application: ["application.js"],
    },

    output: {
        path: __dirname + "/public/packs",
    },

    module: {
        rules: [
            {
                test: /\.css$/,
                use:
                    ['style-loader', 'css-loader']
            },
            {
                test: /\.scss$/,
                use:
                    [
                        {
                            loader: "style-loader" // creates style nodes from JS strings
                        },
                        {
                            loader: "css-loader" // translates CSS into CommonJS
                        },
                        {
                            loader: "sass-loader" // compiles Sass to CSS
                        }
                    ]
            },
            { test: /bootstrap.+\.(jsx|js)$/, loader: 'imports?jQuery=jquery,$=jquery,this=>window' },
            // tinymce
            {
                test: require.resolve('tinymce/tinymce'),
                loaders: [
                    'imports?this=>window',
                    'exports?window.tinymce'
                ]
            },
            {
                test: /tinymce\/(themes|plugins)\//,
                loaders: [
                    'imports?this=>window'
                ]
            }
        ]
    },
    plugins: [
        new webpack.ProvidePlugin({
            $: "jquery",
            jQuery: "jquery"
        }),
    ]
};
