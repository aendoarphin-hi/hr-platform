<template>
  <div>
    {{ store.authenticated.number }}
  </div>
</template>
<script>
export default {
  inject: ['store'],
  data() {
    return {
      store: this.store
    }
  },
}
</script>
<style>
  
</style>