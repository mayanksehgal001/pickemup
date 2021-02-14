module.exports = {
  test: /\.vue(\.haml)?$/,
  use: [{
    loader: 'vue-loader',
    options: {
        hotReload: true
      }
  }]
}
