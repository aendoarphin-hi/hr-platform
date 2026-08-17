<template>
  <aside id="sidebar" :class="{ collapsed: !sidebarOpen }">
    <router-link id="sidebar-header" to="/dashboard" class="d-flex align-items-center text-decoration-none mx-auto">
      <img src="@/assets/img/hayden-blue.svg" alt="Hayden Logo" class="me-2" />
      <span class="fs-4 text-dark text-nowrap"><strong>HAYDEN</strong> {{ this.$appname }}</span>
    </router-link>
    <hr />
    <ul class="nav nav-pills flex-column mb-auto gap-1">
      <li v-for="route in routes" :key="route.name" class="nav-item">
        <router-link :to="{ name: route.name }" class="nav-link text-capitalize d-flex flex-row align-items-center"
          active-class="active">
          <span>
            <component :is="route.icon" />
          </span>&nbsp;&nbsp;<span>{{ route.name }}</span>
        </router-link>
      </li>
      <li class="nav-item">
        <a href="http://10.10.8.156" class="nav-link text-capitalize d-flex flex-row align-items-center">
          <span>
            <Logout />
          </span>&nbsp;&nbsp;<span>Exit</span>
        </a>
      </li>
    </ul>

    <hr />

    <div id="sidebar-footer">
      <router-link to="/profile" class="text-decoration-none">
        <AccountCircle />&nbsp;&nbsp;<span>{{ this.user.name }}</span>
      </router-link>
    </div>
  </aside>
  <div @click="sidebarOpen = !sidebarOpen" class="cursor-pointer"
    style="height: 100dvh; align-items: center; display: flex; border-right: 1px solid var(--bs-border-color); position: sticky; top: 0;">
    <ChevronLeft v-if="sidebarOpen" />
    <ChevronRight v-if="!sidebarOpen" />
  </div>
</template>

<script>
import AccountCircle from "vue-material-design-icons/AccountCircle.vue";
import ChevronRight from "vue-material-design-icons/ChevronRight.vue";
import ChevronLeft from "vue-material-design-icons/ChevronLeft.vue";
import Logout from "vue-material-design-icons/Logout.vue";

export default {
  name: "Sidebar",
  components: {
    AccountCircle,
    ChevronRight,
    ChevronLeft,
    Logout
  },
  data() {
    return {
      name: "SidebarComponent",
      sidebarOpen: true,
      routes: [],
      user: {}
    };
  },

  async mounted() {
    this.routes = this.$router.options.routes.filter(
      (route) => route.name && route.active
    );

    try {
      const res = await this.$axios.get(this.$api + 'employees?auth');
      this.user = res.data;
    } catch (error) {
      console.log(error + " at " + this.name);
    }
  },
};
</script>

<style scoped>
#sidebar {
  height: 100%;
  min-height: 100dvh;
  padding: 1rem .5rem;
  display: flex;
  flex-direction: column;
  position: sticky;
  top: 0;
  bottom: 0;
  border-right: 1px solid var(--bs-border-color);
  width: 260px;
  min-width: 260px;
  opacity: 1;
  overflow: hidden;
  transition: width 250ms ease, min-width 250ms ease, opacity 100ms ease, padding 250ms ease;
}

#sidebar.collapsed {
  width: 0;
  min-width: 0;
  padding-left: 0;
  padding-right: 0;
  opacity: 0;
}

#sidebar-footer {
  display: flex;
  flex-direction: row;
  gap: 0.5rem;
  align-items: center;
  justify-content: space-between;
}

.nav-link:not(.active):hover {
  background: #6f6f6f1e;
  transition: filter 0.05s ease-in;
}
</style>
