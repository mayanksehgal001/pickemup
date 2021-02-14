"use strict";

import Vue from "vue";

export default Vue.mixin ({
    data(){
        return {
          selectedRows: [],
          selectAll: false
        };
    },
  computed: {
    allSeletedIntermediate() {
        return (
          !this.selectAll &&
          this.selectedRows.length > 0 &&
          this.selectedRows.length < this.items.length
        );
    },
  },
  methods:{
    dynamicFieldSlot(field){
        return `cell(${field})`
     },
     toggleSelectedRows() {
        let arr = [];
        if (this.selectAll) {
          arr = this.items.map((item) => item.id); 
        }
         this.selectedRows = arr;
     },
  },
  watch: {
    selectedRows() {
       if (this.selectedRows.length < this.items.length) {
        this.selectAll = false;
       } else if (this.selectedRows.length == this.items.length) {
        this.selectAll = true;
       }
    }
  }
});
