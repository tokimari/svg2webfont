<s2w-download-btn>
  <button
    onclick="{ onDownload }"
    class="c-button c-flat-button c-flat-button--primary { is-active: hasUpdateForDownload }"
    disabled="{ building || !hasZipFile }"
  >Download</button>

  <script>
    // require packages
    const
      exec = require('child_process').exec,
      util = require(opts.path.src.util);

    // initialization
    this.hasUpdateForDownload = false;
    this.hasZipFile = util.isExistFile(opts.path.dest.files.zip);

    function zipDirectory(directory) {
      return new Promise((resolve, reject) => {
        exec('zip -jr ' + opts.path.dest.files.zip + ' ' + directory, (err) => {
          if(err) {
            sampleAction.error({
              type: 'zip',
              name: err.cmd,
              message: err.message
            });
            reject();
          }
          resolve();
        });
      });
    }

    fontStore.on('start', () => {
      this.building = true;
    });

    /**
     * sample build完了時
     */
    sampleStore.on('complete', () => {
      zipDirectory(sampleStore.getResources()).then(() => {
        this.building = false;
        this.hasUpdateForDownload = true;
        this.hasZipFile = true;
        this.update();
      });
    })

    this.onDownload = () => {
      this.hasUpdateForDownload = false;
      location.href = opts.path.dest.files.zip;
    }
  </script>
</s2w-download-btn>
