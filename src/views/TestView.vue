<template>
  <div>
    {{ typeof store.authenticated.number }}
  </div>
</template>
<script>
import { store } from '@/common/store'
export default {
  data() {
    return {
      store
    }
  },
}
</script>
<style>
  
</style>