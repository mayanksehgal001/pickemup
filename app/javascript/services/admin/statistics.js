import Plugin from "plugin/axios.js";

export default {
  getStatistics(data) {
    return axios.get(`/statistics`)
  },

};
