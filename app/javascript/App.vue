<template lang="html">
  <div id="app">
    <admin-topbar/>
    <router-view></router-view>
    <snackbarComp
      wrapClass="is-active"/>
  </div>
</template>

<script lang="js">
import adminTopbar from './components/partials/admin/adminTopbar';

import snackbarComp from './components/partials/admin/snackbar';
import stringComputedProperties from 'mixins/computed_properties/string.js';
import commonMethods from 'mixins/methods/commonMethods.js';
import tableProperties from 'mixins/computed_properties/table.js';
import queryParams from 'mixins/queryParams.js';
import stringFilters from 'mixins/filters/string.js';

export default {
  name: 'App',
  data () {
    return {
      sidebarIsVisible: true,
      sidebarWidth: '250px',
      window: {
        width: 0,
        height: 0
      }
    }
  },
  components: {
    adminTopbar,
    snackbarComp
  },
  mixins: [
    stringComputedProperties,
    commonMethods,
    tableProperties,
    queryParams,
    stringFilters
  ],
  created() {
    window.addEventListener('resize', this.handleResize);
    this.handleResize();
  },
  destroyed() {
    window.removeEventListener('resize', this.handleResize);
  },
  methods: {
    handleResize() {
      this.window.width = window.innerWidth;
      this.window.height = window.innerHeight;
    },
    sidebarToggle(bool) {
      this.sidebarIsVisible = bool
    }
  }
}
</script>

<style scoped lang="scss">
#viewport {
  min-height: 100vh;
  padding-top: 70px !important;
  padding-left: 0;
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  transition: all 250ms;
  &.is-offset {
    padding-left: 250px;
  }  
}
</style>
