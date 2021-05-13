const EventEmitter = require('events');

const AppState = {};

class AppContext extends EventEmitter {
  constructor() {
    super();
  }

  get AppState() {
    return AppState;
  }

  setKey(key, value) {
    AppState[key] = value;
    this.emit('changed', { key, value });
  }

  getKey(key) {
    return AppState[key];
  }
}

module.exports = AppContext;
