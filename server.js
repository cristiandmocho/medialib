const express = require('express');
const app = express();
const expressLayouts = require('express-ejs-layouts');
const AppContext = require('./models/appcontext');

app.set('view engine', 'ejs');
app.set('layout', 'MainLayout');

app.use(express.static('public'), express.urlencoded({ extended: true }));
app.use(expressLayouts);

// App State
const context = new AppContext();

// Default settings
context.setKey('lang', 'en');

// Routes
[
  { path: '/', view: 'Home' },
  { path: '/login', view: 'Login' },
  { path: '/register', view: 'Register' },
  { path: '/post/new', view: 'NewPost' },
  { path: '/post/read/:id', view: 'ReadPost' },
  { path: '/posts/category/:category', view: 'ListPosts' },
  { path: '/albums', view: 'ReadAlbum' },
  { path: '/album/new', view: 'NewAlbum' },
].forEach((route) => {
  console.log('Creating route ' + route.path);

  app.get(route.path, (req, res) => {
    console.log(req.params);
    res.render(route.view, { state: context.AppState, params: req.params });
  });
});

// 404
app.get('*', (req, res) => {
  res.render('Page404', { state: context.AppState, params: req.params });
});

// Starting app server
const port = 8080;
app.listen(port, () => {
  console.log(`Server started on http://localhost:${port}!`);
});
