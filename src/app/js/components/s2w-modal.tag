<s2w-modal>
  <div if="{ isDisplay }" class="c-modal-outer" onclick="{ onClickOuter }">
    <div class="c-modal" onclick="{ onClickInner }">
      <button class="c-modal__close c-button icon icon--close" onclick="{ onClose }"></button>
      <div class="c-modal__inner">
        <h2 class="c-modal__heading"><yield from="heading"></yield></h2>
        <div class="c-modal__body">
          <yield from="body"></yield> 
        </div>
      </div>
    </div>
  </div>

  <script>
    sampleStore.on('openModal', () => {
      this.isDisplay = true;
      this.update();
    })
    _close = (e) => {
      e.preventDefault();
      e.stopPropagation();
      this.isDisplay = false;
    }
    this.onClickInner = (e) => {
      e.preventDefault();
      e.stopPropagation();
    }

    this.onClose = (e) => {
      _close(e);
    }

    this.onClickOuter = (e) => {
      _close(e);
    }
  </script>
</s2w-modal>
