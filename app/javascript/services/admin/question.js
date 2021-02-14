import Plugin from "plugin/axios.js";

export default {
  getQuestions(params) {
    return axios.get(`/questions`, { params: params })
  },

  answerQuestion(payload, params) {
    return axios.post(`/answers`, payload,{
      params: params
    });
  },

};
