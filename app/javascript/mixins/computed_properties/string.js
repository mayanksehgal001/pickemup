"use strict";

import Vue from "vue";

export default Vue.mixin ({
  computed: {
    fullName: (app)=> (firstName, lastName) => {
      return `${ firstName || '' } ${ lastName || '' }`
    },
    totalSpent:(app)=> (value, currency) =>{
      return `${_.round(value||0,2).toFixed(2) }`;
    },
    initials() {
      return (name) => {
        var initials = name.match(/\b\w/g) || [];
        initials = (
          (initials.shift() || '') + (initials.pop() || '')
        ).toUpperCase();
        return initials;
      }
    },
  }
});
