# Linreg

A simple linear regression model built using Elixir and made interactive and visual using Phoenix LiveView. Read the blogposts [here](https://tiemenwaterreus.com/posts/linear-regression-elixir-phoenix-liveview-i/)

![Example](./assets/static/images/finished_product.gif)

## To start

1. Clone this repo
2. cd into `linreg`
3. Start the Phoenix server: `mix phx.server`
4. Play around with it over at http://localhost:4000

## Troubleshooting

### Clicks not appearing

If you've been following the blogpost and it doesn't appear to register clicks, it is probably due to an update in Phoenix Live View (since 0.13.0) where the [metadata of each event is not included by default](https://github.com/phoenixframework/phoenix_live_view/blob/master/CHANGELOG.md#backwards-incompatible-changes) anymore. To fix this; open up `assets/js/app.js` and find the line where it says `let liveSocket = new LiveSocket(..snip..)` and replace it with:

```javascript
let liveSocket = new LiveSocket("/live", Socket, {
  params: {_csrf_token: csrfToken},
  metadata: {
    click: (e, _el) => {
      return {
        offsetX: e.offsetX,
        offsetY: e.offsetY
      }
    }
  }
})
```

Thanks to @rinbo for [making me aware](https://github.com/Tmw/linreg/issues/2)

## License

[MIT](./LICENSE)
