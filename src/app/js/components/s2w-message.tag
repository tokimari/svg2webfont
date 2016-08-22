<s2w-message>
  <div if="{ error.type }" class="p-error">
    <h2 class="p-error__heading">Error Occurred:{ error.type }</h2>
    <h3 class="p-error__name">{ error.name }</h3>
    <p class="p-error__message">{ error.message }</p>
  </div>

  <script>
    this.error = {};

    function onError(err) {
      console.trace();
      if(!err) { return }
      this.error = err;
      this.update();
    }

    /**
     * error発生時
     */
    fontStore.on('error', onError.bind(this));
    sampleStore.on('error', onError.bind(this));
  </script>
</s2w-message>
