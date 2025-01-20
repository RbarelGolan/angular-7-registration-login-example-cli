const webpack = require('webpack');
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const ModuleFederationPlugin = require('webpack/lib/container/ModuleFederationPlugin');
const share = require('@angular-architects/module-federation/webpack').share;

module.exports = {
  mode: 'development', // or 'production'
  entry: './src/main.ts',
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist'),

    uniqueName: "Angular7MF",
    publicPath: "auto",
  },
  optimization: {
    runtimeChunk: false,
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
    }),
    new ModuleFederationPlugin({
      name: "Angular7MF",
      filename: "remoteEntry.js",
      exposes: {
        // './Component': './src/app/app.component.ts',
        './Component': './src/app/login/login.component.ts',
      },
      shared: share({
        "@angular/core": {singleton: true, strictVersion: true, eager: true, requiredVersion: 'auto'},
        "@angular/common": {singleton: true, strictVersion: true, eager: true, requiredVersion: 'auto'},
        "@angular/router": {singleton: true, strictVersion: true, eager: true, requiredVersion: 'auto'},
        // other shared libraries
      }),
    }),
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