var path = require('path')
var fs = require('fs')
var chalk = require('chalk')
var webpack = require('webpack')
var merge = require('webpack-merge')
var HtmlWebpackPlugin = require('html-webpack-plugin')
var autoprefixer = require('autoprefixer')
var ExtractTextPlugin = require('extract-text-webpack-plugin')
var CopyWebpackPlugin = require('copy-webpack-plugin')

const PROD = 'production'
const DEV  = 'development'

// determine build env
const TARGET_ENV = process.env.npm_lifecycle_event === 'build' ? PROD : DEV
const isDev = TARGET_ENV == DEV
const isProd = TARGET_ENV == PROD

// entry and output path/filename variables
const rendererEntryPath      = path.join(__dirname, 'src/static/index.js')
const rendererOutputPath     = path.join(__dirname, 'dist')
const rendererOutputFilename = isProd ? '[name]-[hash].js' : '[name].js'

console.log('WEBPACK GO! Building for ' + TARGET_ENV)

// common webpack config (valid for dev and prod)
module.exports = {
  output: {
    path: rendererOutputPath,
    filename: `static/js/${rendererOutputFilename}`,
  },
  resolve: {
    extensions: ['.js', '.elm'],
    modules: ['node_modules']
  },
  module: {
    noParse: /\.elm$/,
    rules: [{
      test: /\.(eot|ttf|woff|woff2|svg)$/,
      use: 'file-loader?publicPath=../../&name=static/css/[hash].[ext]'
    }]
  },
  plugins: [
    new webpack.LoaderOptionsPlugin({
      options: {
        postcss: [autoprefixer()]
      }
    }),
    new HtmlWebpackPlugin({
      template: 'src/static/index.html',
      inject: 'body',
      filename: 'index.html'
    })
  ]
}
