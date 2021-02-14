<template lang="html">
  <b-container id="AdminIndex" fluid="xl" class="m-3 mx-auto">
    <h3> Statistics </h3>
    <div class="row">
      <div class="col-4 my-3" v-for="(key in statKeys"  v-bind:key="key">
        <b-card >
            <b-card-text>
              {{  key | startCase }}
            </b-card-text>

            <b-card-text>
              {{ statistics[key] }}
            </b-card-text>

        </b-card>
      </div>
   </div>
  </b-container>
</template>

<script lang="js">
import $statistics from '@/services/admin/statistics';

export default {
  name: 'AdminDashboard',
  components: {  },
  data: function() {
    return {
      statistics: {}
    }
  },
  mounted() {
    this.getStatistics()
  },
  methods: {
    getStatistics(){
      $statistics.getStatistics().then((res) => {
        debugger
        this.statistics = res.data;
      });
    }
  },
  computed: {
    statKeys(){
      return Object.keys(this.statistics)
    }
  }
}
</script>

<style scoped lang="scss">

</style>
