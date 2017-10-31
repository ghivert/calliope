/**
 * Builds the DLL for development electron renderer process
 */

var webpack = require('webpack')
var path = require('path')
var merge = require('webpack-merge')
var commonConfig = require('./webpack.config.base')
var { dependencies } = require('./package.json')

// CheckNodeEnv('development');

const dist = path.resolve(process.cwd(), 'dll');
// Additional webpack settings for local env (when invoked by 'npm start')
// if (isDev === true) {
//   module.exports = merge(commonConfig, {
//     target: 'electron-renderer',
//     entry: [
//       `webpack-dev-server/client?http://localhost:${port}/`,
//       // 'webpack/hot/only-dev-server',
//       rendererEntryPath
//     ],
//     devServer: {
//       // serve index.html in place of 404 responses
//       historyApiFallback: true,
//       contentBase: './src',
//       hot: true,
//       before() {
//         if (process.env.START_HOT) {
//           console.log('Starting Main Process...');
//           spawn(
//             'npm',
//             ['run', 'start-main-dev'],
//             { shell: true, env: process.env, stdio: 'inherit' }
//           )
//           .on('close', code => process.exit(code))
//           .on('error', spawnError => console.error(spawnError));
//         }
//       }
//     },
//
//     output: {
//       publicPath: `http://localhost:${port}/dist/`
//     },
//     plugins: [
//       new webpack.DllReferencePlugin({
//         context: process.cwd(),
//         manifest: require(manifest),
//         sourceType: 'var',
//       })
//     ]
//   })
// }

module.exports = merge.smart(commonConfig, {
  context: process.cwd(),

  devtool: 'eval',

  target: 'electron-renderer',

  externals: ['fsevents', 'crypto-browserify'],

  /**
   * @HACK: Copy and pasted from renderer dev config. Consider merging these
   *        rules into the base config. May cause breaking changes.
   */
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
  resolve: {
    modules: [
      'src',
    ],
  },

  entry: {
    renderer: (
      Object
        .keys(dependencies || {})
        .filter(dependency => dependency !== 'font-awesome')
    )
  },

  output: {
    library: 'renderer',
    path: dist,
    filename: '[name].dev.dll.js',
    libraryTarget: 'var'
  },

  plugins: [
    new webpack.DllPlugin({
      path: path.join(dist, '[name].json'),
      name: '[name]',
    }),

    /**
     * Create global constants which can be configured at compile time.
     *
     * Useful for allowing different behaviour between development builds and
     * release builds
     *
     * NODE_ENV should be production so that modules do not perform certain
     * development checks
     */
    new webpack.DefinePlugin({
      'process.env.NODE_ENV': JSON.stringify(process.env.NODE_ENV || 'development')
    }),

    new webpack.LoaderOptionsPlugin({
      debug: true,
      options: {
        context: path.resolve(process.cwd(), 'app'),
        output: {
          path: path.resolve(process.cwd(), 'dll'),
        },
      },
    })
  ],
});
