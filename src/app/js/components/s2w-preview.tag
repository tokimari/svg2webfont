<s2w-preview class="p-preview">
  <iframe if={ srcUrl } src="{srcUrl}" frameborder="0" class="p-preview__inner"></iframe>

  <script>
    const
      util = require(opts.path.src.util),
      sampleFilePath = opts.path.dest.files.html;

    let cacheBaster = 0;
    this.srcUrl = '';

    this.on('mount', () => {
      if(util.isExistFile(sampleFilePath)) {
        this.srcUrl = sampleFilePath;
        this.update();
      } else {
        sampleAction.openModal();
      }
    })

    sampleStore.on('complete', () => {
      // iframe reload
      this.srcUrl = sampleFilePath + '?' + cacheBaster++;
      this.update();
    })
  </script>
</s2w-preview>
