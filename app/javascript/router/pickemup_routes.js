import App from '../App.vue'
import views from './../views'

export default [
  { path: '/',
    redirect: 'admin/dashboard',
    component: App,
    children:[
      {
        path: 'admin',
        redirect: 'admin/dashboard'
      },
      {
        path: 'admin/dashboard',
        name: 'adminDashboard',
        component: views.AdminDashboard
      },
      {
        path: 'admin/questions',
        name: 'questionsList',
        component: views.questions.QuestionList
      }
      
    ]
  }
]
