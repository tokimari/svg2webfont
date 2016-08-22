const fs = require('fs');

const Utilities = {
  openFile: (file) => {
    fs.readFile(file,'utf8', function(err, data) {
      console.log('openFile', err, data);
      return data;
    });
  },

  readFileSync: (file) => {
    return fs.readFileSync(file, 'utf8');
  },

  isExistFile: (file) => {
    try {
      console.info('isExistFile', file);
      fs.statSync(file);
      return true
    } catch(err) {
      if(err.code === 'ENOENT') return false
    }
  }
}

module.exports = Utilities;
