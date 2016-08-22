<s2w-main>
  <div id="sidebar">
    <header id="header" class="l-header">
      <h1 class="l-header__inner">svg2webfonts converter</h1>
    </header>
    <s2w-droparea path={ opts.path } class="l-container"></s2w-droparea>

    <div class="l-container l-grid">
      <s2w-convert-btn path={ opts.path } class="l-grid__item l-grid__item--1n3"></s2w-convert-btn>
      <s2w-build-btn path={ opts.path } class="l-grid__item l-grid__item--1n3"></s2w-build-btn>
      <s2w-download-btn path={ opts.path } class="l-grid__item l-grid__item--1n3"></s2w-download-btn>
    </div>
    <s2w-form path={ opts.path } class="l-container">
      <h2 class="l-container__heading">Option Settings</h2>
    </s2w-form>
    <div class="l-container l-container--aside">
      <button class="c-button c-tooltip-outer p-help-button" onclick="{ onClickHelp }">
        <span class="c-tooltip">open help</span>
        <i class="icon icon--question"></i>
      </button>
    </div>
    <s2w-message path={ opts.path } class="l-container"></s2w-message>
  </div>
  <div id="preview">
    <s2w-preview path={ opts.path } class="p-preview__inner"></s2w-preview>
    <s2w-modal path={ opts.path }>
      <yield to="heading">Usage</yield>
      <yield to="body">
        <ol class="c-list">
          <li class="c-list__item">
            Drop SVG files
            <span class="u-note">File name format: "u\{unicode\}-\{iconName\}.svg"</span>
            <span class="u-note">Example: "uF000-home.svg", "uF001-arrow.svg"</span>
          </li>
          <li class="c-list__item">
            Convert SVGs to webfonts
            <span class="u-note">Options: webfont name, format</span>
          </li>
          <li class="c-list__item">
            Build HTML & CSS
            <span class="u-note">Options: sample text, font size</span>
          </li>
          <li class="c-list__item">Downdload Sample Zip</li>
        </ol>
      </yield>
    </s2w-modal>
  </div>

  <script>
    this.onClickHelp = (e) => {
      sampleAction.openModal();
    }
  </script>
</s2w-main>
