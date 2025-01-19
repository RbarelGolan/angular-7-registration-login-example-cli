const webpack = require('webpack');
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  mode: 'development', // or 'production'
  entry: './src/main.ts',
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist')
  },
  resolve: {
    extensions: ['.ts', '.js'],
    alias: {
      '@app': path.resolve(__dirname, 'src/app'),
      '@environments': path.resolve(__dirname, 'src/environments'),
    },
  },
  module: {
    rules: [
      {
        test: /\.ts$/,
        use: [
          {
            loader: 'ts-loader',
            options: {configFile: 'tsconfig.app.json'}
          },
          'angular2-template-loader'
        ],
        exclude: /node_modules/
      },
      {
        test: /\.html$/,
        use: 'html-loader',
        exclude: /node_modules/
      }
    ]
  },
  plugins: [
    new webpack.ContextReplacementPlugin(
      /(.+)?angular([\\/])core(.+)?/,
      path.resolve(__dirname, 'src'),
      {}
    ),
    new HtmlWebpackPlugin({
      template: './src/index.html'
    })
  ],
  devServer: {
    static: {
      directory: path.join(__dirname, 'dist')
    },
    compress: true,
    port: 4201,
    historyApiFallback: true
  }
}