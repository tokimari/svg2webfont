const path = require(__dirname + '/src/app/js/_path.js')(__dirname);
const util = require(path.src.util);

class Store {
  constructor() {
    riot.observable(this);
  }
}
class FontStore extends Store {
  constructor() {
    super();
    this._svgItems = [];
    this._configFilePath = path.dest.files.glyphs;
    this.on('add', this.addSvgs.bind(this));
    this.on('start', this.trigger('start'));
  }
  addSvgs(items) {
    this._svgItems = this._svgItems.concat(items);
    this.trigger('changed');
  }
  getSvgs() {
    return this._svgItems;
  }
  getConfig() {
    if (util.isExistFile(this._configFilePath)) {
      return JSON.parse(util.readFileSync(this._configFilePath));
    }
    return null
  }
}
class SampleStore extends Store {
  constructor() {
    super();
    function _getSelectedItems(items) {
      let selectedItems = [];
      items.forEach((item) => {
        if(item.selected) {
          selectedItems.push(item.value);
        }
      })
      return selectedItems;
    }
    this._params = require(path.src.params);
    this._item = {
      text: 'xAhyq鈴',
      fontName: 'myFont',
      formats: _getSelectedItems(this._params.formats),
      fontSizes: _getSelectedItems(this._params.fontSizes)
    };
    this.on('change', this.onChange.bind(this));
    this.on('openModal', this.trigger('openModal'));
    this.on('closeModal', this.trigger('closeModal'));
  }
  onChange(item) {
    this._item[item.type] = item.value;
    this.trigger('changed', item.type);
  }
  getResources() {
    return path.dest.sample;
  }
  getText() {
    return this._item.text;
  }
  getFontName() {
    return this._item.fontName;
  }
  getSelectedFormats() {
    return this._item.formats;
  }
  getAllFormats() {
    return this._params.formats;
  }
  getSelectedFontSizes() {
    return this._item.fontSizes;
  }
  getAllFontSizes() {
    return this._params.fontSizes;
  }
}


class ActionCreator {
  constructor(dispatcher) {
    this.dispatcher = dispatcher;
  }
  add(items) {
    this.dispatcher.trigger('add', items);
  }
  start() {
    this.dispatcher.trigger('start');
  }
  complete() {
    this.dispatcher.trigger('complete');
  }
  error(err) {
    this.dispatcher.trigger('error', err);
  }
  change(item) {
    this.dispatcher.trigger('change', item);
  }
}

class SampleAction extends ActionCreator {
  openModal() {
    this.dispatcher.trigger('openModal');
  }
  closeModal() {
    this.dispatcher.trigger('closeModal');
  }
}

const fontStore = new FontStore();
const sampleStore = new SampleStore();
const fontAction = new ActionCreator(fontStore);
const sampleAction = new SampleAction(sampleStore);

// initialization
riot.mount('*', { path: path });
