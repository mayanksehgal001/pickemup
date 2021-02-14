import Vue from 'vue'
import Vuex from "vuex";
import { mapState } from 'vuex'
import axios from 'axios'
import VueLodash from 'vue-lodash'
import lodash from 'lodash'
import createPersistedState from "vuex-persistedstate"; //plugin to persist state in LS
import SecureLS from "secure-ls";

var ls = new SecureLS({ isCompression: false });

Vue.use(Vuex)

const store = new Vuex.Store({

  state: {
    current_user: {},

    csrf: "",
    i18n: null,
    form_errors: [],
    snackBarRef: null
  },
    //To persist following data in local storage which is not found otherwise on page refresh.
  plugins: [createPersistedState({
    paths: ['current_user'],
    storage: {
      getItem: (key) => ls.get(key),
      setItem: (key, value) => ls.set(key, value),
      removeItem: (key) => ls.remove(key),
    },
  })],

  getters: {
    current_user: state => {
      return state.current_user
    },

    csrf: state => {
      return state.csrf
    },

    form_errors: state => {
      return state.form_errors
    },
  },

  mutations: {
    setRefreshData(state, data){
      state.csrf = data.csrf_token
      state.current_user = data.current_user
      delete(state.current_user.encrypted_key)
    },

    setErrors(state, data){
      state.form_errors = data
    },

    setSnackbarRef(state, data){
      state.snackBarRef = data
    },
  },

  actions: {
    refreshData(context){
      var url = '/api/admin/auth/refresh.json'
      axios
      .get(url)
      .then(response => {
        context.commit('setRefreshData', response.data)
      })
      .catch(error => {
        window.location.href="/users/sign_in";
      });
    },
  }
});

Vue.mixin({
  computed: {
    ...mapState([
      'current_user',
      'csrf',
      'form_errors',
      'snackBarRef'
    ])
  }
})
export default store
