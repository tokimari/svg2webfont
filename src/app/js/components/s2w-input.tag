<s2w-input>
  <div class="c-input">
    <label for={ opts.item.name } class="p-form__label">{ opts.item.label }</label>
    <div class="p-form__inner c-input__inner">
      <input name={ opts.item.name } type="text" value={ opts.item.value } placeholder={ opts.item.placeholder } onChange={ onChange } maxlength="50" class="c-input__input" disabled={ disabled }>
    </div>
  </div>

  <script>
    const requireSvgs = opts.item.requireSvgs || false;

    function isDisabled() {
      return requireSvgs ? fontStore.getSvgs().length === 0 : false; 
    }
    this.disabled = isDisabled()

    this.onChange = (e) => {
      sampleAction.change({
        type: e.currentTarget.name,
        value: e.currentTarget.value
      });
    }

    fontStore.on('changed', () => {
      this.disabled = isDisabled();
      this.update();
    })
  </script>
</s2w-input>

