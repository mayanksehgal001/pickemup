import Vue from "vue";
var qs = require('qs');

export default Vue.mixin({
  computed: {
    query: function(){
      return qs.parse(this.$route.query)
    },
    queryFilters: function() {
      return this.query['filter'] || { }
    },
  },
  methods: {
    queryString: function(query){
      return qs.stringify(query, {arrayFormat: 'brackets'})
    },
    newUrl: function(query){
      return location.pathname+'?'+this.queryString(query)
    }
  }
});
