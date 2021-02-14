import Vue from 'vue';
import VueLodash from "vue-lodash";
import lodash from "lodash";
import getSymbolFromCurrency from 'currency-symbol-map'
import pluralize from 'pluralize';

export default Vue.mixin({
  filters: {
    pluralize(value, count=0) {
      return pluralize(value, count)
    },

    capitalize(value) {
      if (!value) return "";
      return lodash.capitalize(value);
    },

    startCase(value) {
      if (!value) return "";
      return lodash.startCase(value);
    },

    round(value, precision) {
      if (!value) return "";
      return lodash.round(value, precision);
    },

    convertToDecimal(value){
      return parseFloat(value).toFixed(2)
    },

    truncate(value){
      if(value != undefined){
        return value.length > 15 ? value.substring(0,15)+'...' : value
      }
    },
  } 
});
