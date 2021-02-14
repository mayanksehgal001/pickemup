<template>
  <div>
    <b-navbar toggleable="lg" type="dark" variant="info">
     
      <div>
        <div v-b-toggle.sidebar-no-header>
          <unicon name="bars" class='mr-2'/></unicon>
        </div>
        <b-sidebar id="sidebar-no-header" aria-labelledby="sidebar-no-header-title" shadow>
          <b-nav vertical>
             <b-nav-item :to="{ name: 'adminDashboard'}">PickemUp Dashboard</b-nav-item>
             <b-nav-item :to="{ name: 'questionsList'}"> Question list</b-nav-item>
          </b-nav>
          <b-nav vertical>
          </b-nav>
        </b-sidebar>
      </div>

      <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

      <b-collapse id="nav-collapse" is-nav>
        <b-navbar-nav>
           <b-nav-item :to="{ name: 'questionsList'}"> Question list</b-nav-item>
          <b-nav-item :to="{ name: 'questionsList'}"> Progress</b-nav-item>
        </b-navbar-nav>

        <!-- Right aligned nav items -->
        <b-navbar-nav class="ml-auto">

          <b-nav-item-dropdown  
            no-caret
            text="right align"
            right
            toggle-class="d-flex"
          >
            <template v-slot:button-content>
              <b-avatar
              variant="dark"
              v-bind:text="initials(fullName)"
              class="avtar_logo mr-2"
              size="2rem">
              </b-avatar>
              <span 
                class="text-dark text-truncate d-none d-md-block" 
                style="max-width: 125px;">
                {{ fullName | startCase }}
              </span>
            </template>    

            <b-dropdown-item href='/users/sign_out' data-method='delete'>
              <unicon name="signout" class='mr-2'/></unicon>Log out
            </b-dropdown-item>

          </b-nav-item-dropdown>

        </b-navbar-nav>
      </b-collapse>
    </b-navbar>
  </div>
</template>

<script>


export default {
  name: 'adminTopbar',
  components: {
  },
  data: function() {
    return {}
  },
  computed: {
    fullName() {
      return `${this.current_user.first_name} ${this.current_user.last_name}`;
    }
  }
};
</script>

<style lang='scss'>

</style>
