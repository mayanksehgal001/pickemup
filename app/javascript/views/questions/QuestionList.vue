<template lang="html">
  <b-container id="AdminIndex" fluid="xl" class="m-3 mx-auto">
    <h3> Answer Questions</h3>
   <div class="row">
      <div class="col-4 my-3" v-for="(question, index) in questions"  v-bind:key="index">
        <b-card >
            <b-card-text>
              {{ question.description}} ?
            </b-card-text>

            <div>
             <b-button  @click='submitAnswer(question.id, 1, index)' class="mr-2">{{ question.choice1}}</b-button>
            <b-button  @click='submitAnswer(question.id, 2, index)'>{{ question.choice2}}</b-button>
           </div>
        </b-card>
      </div>
   </div>
   <div v-if="pageInfo != undefined" class="d-flex justify-content-center mb-3">
      <b-button-group>
        <b-button 
          :class="{ 
            'btn btn-light border': true,
            disabled: noBack }"
            :disabled="noBack"
          @click="handlePageChange('previous')">
          <unicon  name="angle-left"></unicon> 
        </b-button>
        <b-button 
          :class="{ 
            'btn btn-light border': true,
            disabled: noNext 
          }"
          :disabled="noNext"
          @click="handlePageChange('next')">
          <unicon name="angle-right"></unicon> 
        </b-button>
      </b-button-group>

    </div>
  </b-container>
</template>

<script lang="js">
import $question from '@/services/admin/question';

export default {
  name: 'QuestionList',
  components: {  },
  data: function() {
    return {
      questions: [],
      pageInfo: {}
    }
  },
  mounted() {
    this.getQuestions()
  },
  methods: {
    getQuestions(){
      let query = this.query;
      query['per_page'] = 9
      $question.getQuestions(query).then((res) => {
        this.questions = res.data;
        this.pageInfo = res.meta.pagination;
      });
    },
    handlePageChange(direction){
      let pageToggle = this.pageInfo;
      var query = this.query;
      switch (direction) {
        case "next":
          if (pageToggle.current_page < pageToggle.total_pages) {
            query["page"] = pageToggle.next_page;
          }
        break;
        case "previous":
          if (pageToggle.current_page > 1) {
            query["page"] = pageToggle.prev_page;
          }
        break;
      }
      this.$router.push({ path: this.newUrl(query) });
      this.getQuestions()
    },
    submitAnswer(qId, val, index) {
      let payload = {
        user_id: this.current_user.id,
        question_id: qId,
        selected_choice: val
      }
      $question.answerQuestion({ answer: payload }).then((res) => {
        this.questions.splice(index, 1)
      });
    }
  },
  computed: {
    noNext() {
      if (this.pageInfo.current_page == this.pageInfo.total_pages) {
        return true;
      } else {
        return false;
      }
    },
    noBack() {
      if (this.pageInfo.current_page <= 1) {
        return true;
      } else {
        return false;
      }
    },
    currentPage() {
      return this.query.page;
    },
    isActive() {
      return (name) => {
        return name == this.activeTabName
      }
    }
  }
}
</script>

<style scoped lang="scss">

</style>
