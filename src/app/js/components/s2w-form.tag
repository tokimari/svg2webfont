<s2w-form>
  <yield />
  <form class="p-form">
    <section class="p-form__section">
      <s2w-input item={ inputItems[0] } class="p-form__item"></s2w-input>
      <s2w-checkbox item={ selectItems[0] } class="p-form__item"></s2w-checkbox>
    </section>
    <section class="p-form__section">
      <s2w-input item={ inputItems[1] } class="p-form__item"></s2w-input>
      <s2w-checkbox item={ selectItems[1] } class="p-form__item"></s2w-checkbox>
    </section>
  </form>

  <script>
    const fontName = sampleStore.getFontName();
    const text = sampleStore.getText();
    const formats = sampleStore.getAllFormats();
    const fontSizes = sampleStore.getAllFontSizes();

    this.inputItems = [
      { name: 'fontName', label: 'webfont name', value: fontName, placeholder: "icon", requireSvgs: true },
      { name: 'text', label: 'sample text', value: text, placeholder: "サンプルテキスト" }
    ];

    this.selectItems = [
      { name: 'formats', label: 'webfont format', options: formats, requireSvgs: true },
      { name: 'fontSizes', label: 'sample font size (px)', options: fontSizes, formatNumber: true }
    ];
  </script>
</s2w-form>

