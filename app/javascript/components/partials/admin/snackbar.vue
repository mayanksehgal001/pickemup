<template lang='html'>
  <snackbar baseSize="100px" ref="snackbar" :holdTime="3000" position="bottom-center"/>
</template>

<script lang='js'>
export default {
  name: 'snackbarComp',

  mounted: function() {
    this.$store.commit('setSnackbarRef', this.$refs.snackbar)
  },
}
</script>
