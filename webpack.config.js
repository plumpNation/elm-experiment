const path = require('path');

module.exports = {
    mode: 'development',

    entry: {
        app: [
            './src/index.js'
        ]
    },

    output: {
        path: path.resolve(__dirname + '/dist'),
        filename: '[name].js',
    },

    module: {
        rules: [
            {
                test: /\.html$/,
                exclude: /node_modules/,
                loader:    'file-loader?name=[name].[ext]',
            },

            {
                test: /\.elm$/,
                exclude: [/elm-stuff/, /node_modules/],
                use: {
                    loader: 'elm-webpack-loader',
                    options: {
                        verbose: true,
                        warn: true
                    }
                }
            },

            // STYLES
            {
                test: /\.(css|scss)$/,
                use: [
                    'style-loader',
                    'css-loader',
                ]
            },

            {
                test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
                loader: 'url-loader?limit=10000&mimetype=application/font-woff',
            },

            {
                test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
                loader: 'file-loader',
            }
        ],

        noParse: /\.elm$/,
    },

    devServer: {
        inline: true,
        stats: { colors: true },
    }
};
