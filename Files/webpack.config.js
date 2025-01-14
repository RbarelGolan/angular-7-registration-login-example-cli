const webpack = require('webpack');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const path = require('path');

module.exports = {
  mode: 'development', // or 'production'
  entry: './src/main.ts',
  module: {
    rules: [
      {
        test: /\.ts$/,
        use: [
          {
            loader: 'ts-loader',
            options: {configFile: 'tsconfig.json'},
          },
          'angular2-template-loader',
        ],
      },
      {
        test: /\.html$/,
        use: 'raw-loader',
      },
      {
        test: /\.(scss|css)$/,
        use: ['style-loader', 'css-loader', 'sass-loader'],
      },
    ],
  },
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: 'bundle.js',
  },
  resolve: {
    extensions: ['.ts', '.js'],
    modules: [path.resolve(__dirname, 'src'), 'node_modules'],
    alias: {
      '@app': path.resolve(__dirname, 'src/app'),
      '@environments': path.resolve(__dirname, 'src/environments'),
    },
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: './src/index.html',
      filename: 'index.html',
      inject: 'body'
    }),
  ],
  devServer: {
    compress: true,
    port: 4200,
    historyApiFallback: true,
  },
};
