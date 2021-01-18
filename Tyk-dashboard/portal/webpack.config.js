const path = require('path');
const webpack = require('webpack');
const environment = process.env.NODE_ENV;
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const UglifyJsPlugin = require('uglifyjs-webpack-plugin')

let config = {
  entry: {
    'portal-assets/js/swagger.min': './portal-assets/js/swagger.js',
    'portal-assets/js/graphiql-init.min': './portal-assets/js/graphiql-init.js',
    'portal-assets/js/vendors.min': './portal-assets/js/vendors.js',
    'portal-assets/css/swagger.min': './portal-assets/css/swagger.scss',
    'portal-assets/css/graphql.min': './portal-assets/css/graphql.scss'
  },
  output: {
    path: path.resolve(__dirname),
    filename: '[name].js',
  },
  watch: true,
  watchOptions: {
    aggregateTimeout: 300,
    poll: 1000
  },
  module: {
    rules: [
      {
        test: /\.scss$/,
        use: [
          MiniCssExtractPlugin.loader,
          {
            loader: 'css-loader',
            options: {
              sourceMap: true
            }
          },
          'postcss-loader',
          'resolve-url-loader',
          {
            loader: 'sass-loader',
            options: {
              sourceMap: true
            }
          }
        ]
      },
      {
        test: /\.css$/,
        use: [
          MiniCssExtractPlugin.loader,
          {
            loader: 'css-loader',
            options: {
              url: false,
              minimize: true,
              sourceMap: true
            }
          },
          'postcss-loader',
          'resolve-url-loader',
        ]
      },
      {
        test: /\.(jpg|png)$/,
        use: {
          loader: 'file-loader',
          options: {
            name: './images/[name].[ext]'
          }
        }
      },
      {
        test: /\.(ttf|otf|eot|svg|woff(2)?)(\?[a-z0-9]+)?$/,
        use: {
          loader: 'file-loader',
          options: {
            name: '[name].[ext]'
          }
        }
      },
      {
        test: /\.jsx?$/,
        loader: 'babel-loader',
        exclude: /(node_modules(?!\/webpack-dev-server)|bower_components)/,
        options: {
          presets: ['@babel/preset-react', '@babel/env']
        },
      }
    ]
  },
  stats: 'errors-only',
  devServer: {
    contentBase: path.join(__dirname, './'),
    compress: true,
    historyApiFallback: true,
    hot: true,
    https: false,
    noInfo: true,
  },
  optimization: {
    minimize: true,
    removeAvailableModules: true,
    removeEmptyChunks: true,
    mergeDuplicateChunks: true,
    flagIncludedChunks: true,
    occurrenceOrder: true,
    usedExports: true,
    concatenateModules: true,
    noEmitOnErrors: false,
  },
  plugins: [
    new MiniCssExtractPlugin(),
    new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: JSON.stringify(environment)
      }
    }),
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery',
      'window.$': 'jquery',
      'window.jQuery': 'jquery'
    })
  ],
  mode: 'production',
  resolveLoader: { /* same as resolve */ },
  parallelism: 1,
  profile: true,
  bail: true,
  cache: false,
  watch: false,
  watchOptions: {
    aggregateTimeout: 1000,
    poll: true,
    poll: 500,
  },
  node: {
    console: false,
    global: true,
    process: true,
    __filename: 'mock',
    __dirname: 'mock',
    Buffer: true,
    setImmediate: true
  }
};

module.exports = config;
