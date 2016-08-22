<s2w-checkbox>
  <div class="c-select">
    <label class="p-form__label" for={ opts.item.name }>{ opts.item.label }</label>
    <div class="p-form__inner l-flex">
      <div each={ opts.item.options } class="l-flex__item c-checkbox">
        <input type="checkbox" id={ value } name={ value } class="c-checkbox__item" name={ value } onChange={ onChangeSelect } disabled={ disabled } checked={ selected }>
        <label for={ value } class="c-checkbox__mark"></label>
        <label for={ value } class="c-checkbox__label">{ value }</label>
      </div>
    </div>
  </div>

  <script>
    const requireSvgs = opts.item.requireSvgs || false;
    const optionEls = opts.item.options;
    const formatNumber = opts.item.formatNumber || false;

    function isDisabled() {
      return requireSvgs ? fontStore.getSvgs().length === 0 : false; 
    }
    this.disabled = isDisabled();

    this.onChangeSelect = (e) => {
      let selectedValues = [];
      for(let i = 0; i < optionEls.length; i++) {
        let val = e.currentTarget.name;
        if(formatNumber) {
          val = parseInt(val, 10);
        }
        if(optionEls[i].value === val) {
          optionEls[i].selected = !optionEls[i].selected;
        }
        if(optionEls[i].selected) {
          selectedValues.push(optionEls[i].value);
        }
      }
      sampleAction.change({
        type: opts.item.name,
        value: selectedValues
      });
    }

    fontStore.on('changed', () => {
      this.disabled = isDisabled();
      this.update();
    })
  </script>

</s2w-checkbox>
