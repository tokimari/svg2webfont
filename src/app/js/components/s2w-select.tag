<s2w-select>
  <div class="c-select">
    <label class="p-form__label" for={ opts.item.name }>{ opts.item.label }</label>
    <div class="p-form__inner c-select__inner">
      <select class="c-select__select" name={ opts.item.name } size=6 multiple onChange={ onChangeSelect } disabled={ disabled }>
        <option each={ opts.item.options } class="c-select__option" value="{ value }" selected={ selected }>{ value }</option>
      </select>
    </div>
  </div>

  <script>
    const requireSvgs = opts.item.requireSvgs || false;

    function isDisabled() {
      return requireSvgs ? fontStore.getSvgs().length === 0 : false; 
    }
    this.disabled = isDisabled();

    this.onChangeSelect = (e) => {
      const optionEls = e.currentTarget.options;
      const formatNumber = e.item.formatNumber || false;
      let selectedValues = [];
      for(let i = 0; i < optionEls.length; i++) {
        if(optionEls[i].selected) {
          let val = optionEls[i].value;
          if(formatNumber) {
            val = parseInt(val, 10);
          }
          selectedValues.push(val);
        }
      }
      sampleAction.change({
        type: e.currentTarget.name,
        value: selectedValues
      });
    }

    fontStore.on('changed', () => {
      this.disabled = isDisabled();
      this.update();
    })
  </script>

</s2w-select>
