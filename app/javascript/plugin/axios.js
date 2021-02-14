"use strict";

import Vue from "vue";
import store from "store";
import axios from "axios";
import { deserialize } from "deserialize-json-api";
import lodash from 'lodash';
var qs = require('qs');
let snackMsgItem = '';
axios.defaults.headers.common["Accept"] = "application/json";
axios.defaults.headers.common["Content-Type"] = "application/json";
axios.defaults.headers.common["X-Requested-With"] = "XMLHttpRequest";

let config = {
  withCredentials: true,
  baseURL: `http://localhost:3000/api/admin`,
  paramsSerializer: function (params) {
    return qs.stringify(params, {arrayFormat: 'brackets'})
  },
};

const _axios = axios.create(config);


_axios.interceptors.request.use(
  function(config) {
    // IMPORTANT! Add CSRF header
    config.headers["X-CSRF-Token"] = store.getters.csrf;
    store.commit('setErrors', []);
    return config;
  },
  function(error) {
    // Do something with request error
    return Promise.reject(error);
  }
);

_axios.interceptors.response.use(
  res => {
    let retVal
    let snackMsgItem = '';
    switch(res.status){
      case 200 :
        retVal = deserialize(res.data);
        if(res.config.method == 'put'){
          snackMsgItem = 'resource'
          if(snackMsgItem  != undefined){
            store.state.snackBarRef.open(`Successfully updated ${snackMsgItem}`);
          }
        }
      break;
      case 201:
        retVal = deserialize(res.data);
        snackMsgItem = 'resource'
        if(snackMsgItem  != undefined){
          store.state.snackBarRef.open(`Successfully answered Question`);
        }
      break;
    }
    return retVal;
  },
  err => {
    switch(err.response.status){
      case 422:
        let arr = [];
        let res = err.response.data.errors;
        errorList(res, arr);
        store.commit('setErrors', arr);
        store.state.snackBarRef.error(`${err.response.status} - Unable to save`);
      break;
      case 500:
        store.state.snackBarRef.error(`${err.response.status} - Something went wrong`)
      break
    }
    return Promise.reject(err)
  });

let errorList = (errors, arr=[], parentString='') => {
  for (var errKey in errors) {
    if(_.isArray(errors[errKey])){
      arr.push(`${parentString.replace('_', ' ')} ${errKey} ${errors[errKey].join(', ')}`.trim());
    }
    else{
      errorList(errors[errKey], arr, errKey)
    }
  };
  return arr
}

Plugin.install = function(Vue, options) {
  Vue.axios = _axios;
  window.axios = _axios;
  window.deserialize = deserialize;
  window.store = store;
  Object.defineProperties(Vue.prototype, {
    axios: {
      get() {
        return _axios;
      }
    },
    $axios: {
      get() {
        return _axios;
      }
    }
  });
};

Vue.use(Plugin);
export default Plugin;
