import Vue from "vue";
import VueLodash from "vue-lodash";
import lodash, { compact } from "lodash";
import pluralize from 'pluralize';

export default Vue.mixin({
  methods: {
    pluralize(value) {
      return pluralize(value)
    },
    sort_objects: function (collection, sort_order) {
      return lodash.sortBy(collection, sort_order);
    },
    getKeys: function (object) {
      return lodash.keys(object);
    },
    arrayDifference: function (arr1, arr2) {
      return arr1.filter(x => !arr2.includes(x))
    },

    arrayIntersection: function (arr1, arr2) {
      return arr1.filter(x => arr2.includes(x))
    },

    getIds: function(collection){
      return collection.map(v => v.id) || [];
    },

    filteredIds: function (collection, property, value) {
      return collection.filter(x => x[property] == value).map(v => v.id) || [];
    },

    findObject(collection, property, value) {
      return collection.find(ele => ele[property] == value)
    },
    showSaveBar() {
      this.validationObserverFlagChange();
      this.toggleSaveNavBar('', 'forced');
    },
    digitsRoundOff(number, level) {
      return _.round(number, level).toFixed(level);
    },
  },
});
