var path = require('path')
var fs = require('fs')
var chalk = require('chalk')
var childProcess = require('child_process') //{ spawn, execSync } from 'child_process';
var webpack = require('webpack')
var merge = require('webpack-merge')
var HtmlWebpackPlugin = require('html-webpack-plugin')
var autoprefixer = require('autoprefixer')
var ExtractTextPlugin = require('extract-text-webpack-plugin')
var CopyWebpackPlugin = require('copy-webpack-plugin')
var commonConfig = require('./webpack.config.base')

const port = process.env.PORT || 1212;
const publicPath = `http://localhost:${port}/dist`;
const dll = path.resolve(process.cwd(), 'dll');
const manifest = path.resolve(dll, 'renderer.json');

if (!(fs.existsSync(dll) && fs.existsSync(manifest))) {
  console.log(chalk.black.bgYellow.bold(
    'The DLL files are missing. Sit back while we build them for you with "npm run build-dll"'
  ))
  childProcess.execSync('yarn run build-dll');
}

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

// Additional webpack settings for local env (when invoked by 'npm start')
if (isDev === true) {
  module.exports = merge(commonConfig, {
    target: 'electron-renderer',
    entry: [
      `webpack-dev-server/client?http://localhost:${port}/`,
      // 'webpack/hot/only-dev-server',
      rendererEntryPath
    ],
    devServer: {
      port: port,
      publicPath: publicPath,
      // serve index.html in place of 404 responses
      historyApiFallback: true,
      contentBase: path.join(__dirname, 'dist'),
      // contentBase: path.join(__dirname, 'src/static')
      hot: true,
      before() {
        if (process.env.START_HOT) {
          console.log('Starting Main Process...');
          childProcess.spawn(
            'npm',
            ['run', 'start-main-dev'],
            { shell: true, env: process.env, stdio: 'inherit' }
          )
          .on('close', code => process.exit(code))
          .on('error', spawnError => console.error(spawnError));
        }
      }
    },
    module: {
      rules: [{
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        use: [{
          loader: 'elm-webpack-loader',
          options: {
            verbose: true,
            warn: true,
            debug: true
          }
        }]
      }, {
        test: /\.sc?ss$/,
        use: ['style-loader', 'css-loader', 'postcss-loader', 'sass-loader']
      }]
    },
    output: {
      publicPath: `http://localhost:${port}/dist/`
    },
    plugins: [
      new webpack.DllReferencePlugin({
        context: process.cwd(),
        manifest: require(manifest),
        sourceType: 'var',
      })
    ]
  })
}

// Additional webpack settings for prod env (when invoked via 'npm run build')
if (isProd === true) {
  module.exports = merge(commonConfig, {
    // entry: entryPath,
    module: {
      rules: [{
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        use: 'elm-webpack-loader'
      }, {
        test: /\.sc?ss$/,
        use: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: ['css-loader', 'postcss-loader', 'sass-loader']
        })
      }]
    },
    plugins: [
      new ExtractTextPlugin({
        filename: 'static/css/[name]-[hash].css',
        allChunks: true,
      }),
      new CopyWebpackPlugin([{
        from: 'src/static/img/',
        to: 'static/img/'
      }, {
        from: 'src/favicon.ico'
      }]),

      // extract CSS into a separate file
      // minify & mangle JS/CSS
      new webpack.optimize.UglifyJsPlugin({
        minimize: true,
        compressor: {
          warnings: false
        }
        // mangle:  true
      })
    ]
  })
}
