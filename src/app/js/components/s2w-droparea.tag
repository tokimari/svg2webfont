<s2w-droparea>
  <a class="p-drop { is-active: svgFiles.length > 0 }" href="#">
    <div if={ svgFiles.length === 0 } class="p-drop__placeholder">Drop SVG files here</div>
    <div if={ svgFiles.length !== 0 } class="p-drop__placeholder">{ svgFiles.length } files here</div>
    <input class="p-drop__input" type="file" multiple name="file" accept="image" id="dropArea" onchange="{ onChange }" ondrop="{ onDrop }">
  </a>

  <script>
    const self = this;
    this.svgFiles = [];

    function showFiles(files) {
      for (let i = 0; i < files.length; i++) {
        var file = files[i];
        if(file.type !== "image/svg+xml") {
          alert('You can convert SVG file only.')
          return
        }
        self.svgFiles.push(file.path);
      }
      fontAction.add(self.svgFiles);
      self.update();
    }

    this.onChange = (e) => {
      e.preventDefault();
      e.stopPropagation();
      showFiles(e.currentTarget.files);
    }
    this.onDrop = (e) => {
      e.preventDefault();
      e.stopPropagation();
      showFiles(e.dataTransfer.files);
    }
  </script>
</s2w-droparea>

