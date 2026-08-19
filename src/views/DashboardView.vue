<template>
  <div v-if="!loading" :id="`${$route.name}-view`" class="w-100 p-3">
    <!-- help modal -->
    <HelpModalComponent>
      <h5><strong>HAYDEN</strong> {{ this.$appname }}</h5>
      <p>
        In the dashboard, you can view a summary of recent changes to events and track the status of displays. Each
        section also contains direct links to
        a destination.
        Use the toolbar on the top right to create new announcements, upload content, or issue an emergency alert.
      </p>
    </HelpModalComponent>

    <!--  header + toolbar  -->
    <div class="hstack align-items-center flex-wrap mb-4">
      <!-- header -->
      <div class="fs-5 fw-semibold text-capitalize d-flex align-items-center gap-2">
        <span>{{ $route.name }}</span>
        <span>
          <HelpCircleOutline data-bs-toggle="modal" data-bs-target="#help-modal" title="Help" class="cursor-pointer" />
        </span>
      </div>
      <!-- toolbar -->
      <div class="hstack ms-auto fw-semibold gap-2 text-nowrap flex-wrap">
        <div class="btn btn-sm btn-success">+ Create Announcement</div>
        <div class="btn btn-sm btn-primary">Upload Content</div>
        <div class="btn btn-sm btn-danger">Issue Emergency Alert</div>
      </div>
    </div>

    <!--  KPI stat cards  -->
    <div class="row g-3 mb-4">
      <div v-for="s in quickStats" :key="s.title" class="col-6 col-xl-3">
        <RouterLink :to="{ name: 'Displays', query: { tab: s.title } }" class="text-decoration-none">
          <div class="card shadow-sm border border-0 hstack h-100">
            <div class="card-body hstack align-items-end">
              <div class="col cursor-pointer">
                <div class="text-muted small text-uppercase fs-5">
                  <component :is="s.icon" />&nbsp;&nbsp;{{ s.title }}
                </div>
                <div class="fs-1 fw-semibold lh-1">{{
                  s.title === 'displays'
                    ? displays.length
                    : s.title === 'content'
                      ? content.length
                      : s.title === 'playlists'
                        ? playlists.length
                        : s.title === 'approvals'
                          ? approvals.length
                          : 0
                }}</div>
              </div>
              <div class="text-muted gap-1 small align-self-start d-flex flex-column my-auto cursor-pointer">
                <div v-for="d in subStats(s.title)" :key="'stat-' + d.label"
                  class="badge badge-pill align-items-center justify-content-end rounded d-flex text-uppercase fw-semibold small"
                  :class="`text-${d.color} bg-${d.bgColor} ${d.value === 0 ? 'd-none' : ''}`"><span class="me-auto">{{
                    d.label }}</span>&nbsp;&nbsp;&nbsp;{{ d.value }}</div>
              </div>
            </div>
          </div>
        </RouterLink>
      </div>
    </div>

    <!--  main content + sidebar  -->
    <div class="row g-4">

      <!--  main content column  -->
      <div class="col-12 col-lg-8">

        <!--  announcements  -->
        <div class="card shadow-sm border-0 mb-4">
          <div class="card-header bg-white d-flex justify-content-between align-items-center">
            <h6 class="mb-0 d-flex align-items-center gap-2 fw-semibold text-secondary">
              <span class="mb-1">
                <Bullhorn class="fs-5" />
              </span>
              Upcoming Announcements
            </h6>
            <router-link to="/calendar?filter=announcements" class="small link-primary text-decoration-none">Manage Announcements
              &nbsp;▸</router-link>
          </div>
          <ul class="list-group list-group-flush">
            <li v-for="(a, i) in upcomingAnnouncements.slice(0, 5)" :key="i"
              class="list-group-item d-flex align-items-center gap-3">
              <div class="flex-grow-1 min-w-0">
                <div class="fw-semibold text-truncate">{{ a.title }}</div>
                <div class="text-muted small">
                  <span v-if="a.location" class="text-capitalize me-2">
                    <MapMarker /> {{ a.location }}
                  </span>
                  <span v-if="a.start">
                    <Calendar /> {{ new Date(a.start).toDateString() }}
                  </span>
                </div>
              </div>
              <span class="badge rounded-pill text-capitalize" :class="announcementBadgeClass(a.subtype)">{{ a.subtype
                }}</span>
            </li>
          </ul>
        </div>

        <!--  Recent uploads (media posts)  -->
        <div class="card shadow-sm border-0">
          <div class="card-header bg-white d-flex justify-content-between align-items-center">
            <h6 class="mb-0 d-flex align-items-center gap-2 fw-semibold text-secondary">
              <span class="mb-1">
                <UploadBox class="fs-5" />
              </span>
              Recent Uploads
            </h6>
            <router-link :to="{ name: 'Displays', query: { tab: 'content' } }"
              class="small link-primary text-decoration-none">View Library
              &nbsp;▸</router-link>
          </div>
          <div class="card-body">
            <div class="row g-3">
              <template v-if="recentUploads.length > 0">
                <div v-for="(u, i) in recentUploads" :key="i" class="col-12 col-sm-6">
                  <div class="d-flex align-items-center gap-3">
                    <div class="upload-icon rounded-3 flex-shrink-0 d-flex align-items-center justify-content-center">
                      📄
                    </div>
                    <div class="min-w-0">
                      <div class="fw-semibold text-truncate">{{ u.title }}</div>
                      <div class="text-muted small">{{ u.filename }} &middot; {{ new Date(u.created_at).toDateString()
                        }}</div>
                    </div>
                  </div>
                </div>
              </template>
              <template v-else>
                <div class="timeline-item">
                  <div class="timeline-content p-3">
                    <div class="text-center">
                      <span class="fw-semibold text-muted">No recent uploads</span>
                    </div>
                  </div>
                </div>
              </template>
            </div>
          </div>
        </div>

      </div>

      <!--  sidebar column  -->
      <div class="col-12 col-lg-4">

        <!--  people (events)  -->
        <div class="card shadow-sm mb-4 border-0">
          <div class="card-header bg-white d-flex justify-content-between align-items-center">
            <h6 class="text-secondary card-title mb-0 d-flex align-items-center gap-2">
              <span class="mb-1">
                <CalendarStar class="fs-5" />
              </span>
              People
            </h6>
            <router-link to="/calendar" class="small link-primary text-decoration-none">View Calendar
              &nbsp;▸</router-link>
          </div>
          <ul class="list-group list-group-flush" style="max-height: 400px; overflow-y: auto">
            <li v-for="(e, i) in employeeEvents" :key="i" class="list-group-item small d-flex align-items-center gap-2">
              <div class="fs-5">
                <span v-if="e.subtype === 'birthday'">🎂</span>
                <span v-else-if="e.subtype === 'anniversary'">🎉</span>
                <span v-else-if="e.subtype === 'promotion'">📈</span>
                <span v-else-if="e.subtype === 'new hire'">💼</span>
              </div>&nbsp;
              <div class="d-flex flex-column text-capitalize">
                <div class="fw-semibold">{{ e.title }}</div>
                <div class="text-muted text-nowrap me-1 small">
                  {{ new Date(e.start).toDateString() }}
                </div>
              </div>
            </li>
          </ul>
        </div>

        <!--  recent activity  -->
        <div class="card shadow-sm mb-4 border-0">
          <div class="card-header bg-white d-flex align-items-center">
            <h6 class="mb-0 d-flex align-items-center gap-2 fw-semibold text-secondary">
              <span class="mb-1">
                <AccountClock class="fs-5" />
              </span>
              Recent Activity
            </h6>
          </div>
          <div class="timeline">
            <template v-if="activity.length > 0">
              <div v-for="a in activity" :key="a.id" class="timeline-item">
                <div class="timeline-content p-3">
                  <div class="d-flex align-items-center gap-2">
                    <span
                      class="activity-avatar rounded-circle d-flex align-items-center justify-content-center flex-shrink-0">
                      👤
                    </span>
                    <div class="flex-grow-1 min-w-0">
                      <span class="fw-semibold">{{ a.user }}</span> — {{ a.details }}
                    </div>
                    <div class="text-muted small text-nowrap">{{ formatTimeAgo(a.timestamp) }}</div>
                  </div>
                </div>
              </div>
            </template>
            <template v-else>
              <div class="timeline-item">
                <div class="timeline-content p-3">
                  <div class="text-center">
                    <span class="fw-semibold text-muted">No recent activity</span>
                  </div>
                </div>
              </div>
            </template>
          </div>
        </div>

        <!--  needs attention  -->
        <div v-if="needsAttention.length > 0" class="card shadow-sm overflow-hidden">
          <div class="card-header bg-warning-subtle text-warning-emphasis d-flex align-items-center gap-2">
            <Alert :size="16" />
            <h6 class="card-title mb-0">Needs Attention</h6>
          </div>
          <ul class="list-group rounded-0 scrollable-list flex-fill">
            <li v-for="(n, i) in needsAttention" :key="i" class="list-group-item d-flex align-items-center gap-2">
              <span class="attention-dot rounded-circle flex-shrink-0"></span>
              <div class="flex-grow-1">{{ n }}</div>
            </li>
          </ul>
        </div>

      </div>
    </div>
  </div>
  <div v-else class="d-flex justify-content-center align-items-center">
    <LoadingComponent message="Loading dashboard..." />
  </div>
</template>

<script>
import Television from "vue-material-design-icons/Television.vue";
import AccountCircle from "vue-material-design-icons/AccountCircle.vue";
import PlaylistPlay from "vue-material-design-icons/PlaylistPlay.vue";
import Alert from "vue-material-design-icons/Alert.vue";
import UploadBox from "vue-material-design-icons/UploadBox.vue";
import Bullhorn from "vue-material-design-icons/Bullhorn.vue";
import Magnify from "vue-material-design-icons/Magnify.vue";
import MapMarker from "vue-material-design-icons/MapMarker.vue";
import CalendarMonth from "vue-material-design-icons/CalendarMonth.vue";
import AccountClock from "vue-material-design-icons/AccountClock.vue";
import CalendarStar from "vue-material-design-icons/CalendarStar.vue";
import HelpCircleOutline from "vue-material-design-icons/HelpCircleOutline.vue";
import FileDocument from "vue-material-design-icons/FileDocument.vue";
import Calendar from "vue-material-design-icons/Calendar.vue";

import HelpModalComponent from "@/components/HelpModalComponent.vue";

import { markRaw } from "vue";
import LoadingComponent from "@/components/LoadingComponent.vue";

export default {
  name: "DashboardView",
  components: {
    Magnify,
    MapMarker,
    CalendarMonth,
    Bullhorn,
    UploadBox,
    Alert,
    PlaylistPlay,
    AccountCircle,
    Television,
    AccountClock,
    CalendarStar,
    HelpCircleOutline,
    FileDocument,
    Calendar,

    HelpModalComponent,
    LoadingComponent
  },

  data() {
    return {
      loading: false,
      quickStats: [],
      activity: [],
      events: [],
      displays: [],
      playlists: [],
      approvals: [],
      content: [],
      needsAttention: [],
      // placeholder rows
      recentUploads: []
    };
  },
  methods: {
    handleScroll() {
      const currentScrollY = window.scrollY;
      if (currentScrollY > this.lastScrollY) {
        this.scrollingDown = true;
      } else {
        this.scrollingDown = false;
      }
      this.lastScrollY = currentScrollY;
    },
    announcementBadgeClass(status) {
      return (
        {
          general: "text-primary-emphasis bg-primary-subtle",
          urgent: "text-danger emphasis bg-danger-subtle",
          maintenance: "text-muted bg-body-secondary",
          production: "text-success-emphasis bg-success-subtle",
          weather: "text-warning-emphasis bg-warning-subtle",
          safety: "text-info-emphasis bg-info-subtle",

        }[status] || "visually-hidden"
      );
    },
    formatTimeAgo(timestamp) {
      const now = new Date();
      const then = new Date(timestamp);
      const diffMins = Math.floor((now - then) / 60000);

      if (diffMins < 1) return "Just now";
      if (diffMins < 60) return `${diffMins} minute${diffMins !== 1 ? "s" : ""} ago`;

      const diffHours = Math.floor(diffMins / 60);
      if (diffHours < 24) return `${diffHours} hour${diffHours !== 1 ? "s" : ""} ago`;

      const diffDays = Math.floor(diffHours / 24);
      if (diffDays < 30) return `${diffDays} day${diffDays !== 1 ? "s" : ""} ago`;

      return then.toLocaleDateString(undefined, { month: "short", day: "numeric", year: "numeric" });
    },
    subStats(title) {
      let statSet = [];
      if (title === "displays") {
        statSet = [
          {
            label: 'Online',
            value: this.displays.filter((d) => d.status === 'online').length,
            color: 'success-emphasis',
            bgColor: 'success-subtle'
          },
          {
            label: 'Offline',
            value: this.displays.filter((d) => d.status === 'offline').length,
            color: 'danger-emphasis',
            bgColor: 'danger-subtle'

          },
          {
            label: 'Disabled',
            value: this.displays.filter((d) => d.status === 'disabled').length,
            color: 'muted',
            bgColor: 'body-secondary'

          }
        ];
      } else if (title === "approvals") {
        statSet = [
          {
            label: 'Approved',
            value: this.approvals.filter((a) => a.status === 'approved').length,
            color: 'success-emphasis',
            bgColor: "success-subtle"
          },
          {
            label: 'Pending',
            value: this.approvals.filter((a) => a.status === 'pending').length,
            color: 'warning-emphasis',
            bgColor: "warning-subtle"
          },
          {
            label: 'Rejected',
            value: this.approvals.filter((a) => a.status === 'rejected').length,
            color: 'danger-emphasis',
            bgColor: "danger-subtle"
          }
        ];
      }
      return statSet;
    },
  },
  computed: {
    employeeEvents() {
      return this.events.filter((event) => event.category === "employee");
    },
    upcomingAnnouncements() {
      return this.events
        .filter((event) => event.category === "announcement" && event.subtype !== "weather")
        .sort((a, b) => new Date(a.start) - new Date(b.start));
    },
  },
  async mounted() {
    try {
      this.loading = true;

      this.events = (await this.$axios.get(this.$api + "events?all=1")).data;
      this.displays = (await this.$axios.get(this.$api + "displays?all=1")).data;
      this.playlists = (await this.$axios.get(this.$api + "playlists?all=1")).data;
      this.content = (await this.$axios.get(this.$api + "content?all=1")).data;
      this.approvals = (await this.$axios.get(this.$api + "approvals?all=1")).data;

      // filter content by create date desc
      this.recentUploads = this.content
        .sort((a, b) => new Date(b.created) - new Date(a.created))
        .slice(0, 5);

      this.events = this.events
        .sort((a, b) => new Date(a.start) - new Date(b.start))
        .filter((event) => new Date(event.start) >= new Date());

      this.quickStats = [
        {
          title: "displays",
          icon: markRaw(Television),
          color: "success",
          stat: {},
        },
        {
          title: "content",
          icon: markRaw(FileDocument),
          color: "danger",
          stat: {},
        },
        {
          title: "playlists",
          icon: markRaw(PlaylistPlay),
          color: "secondary",
          stat: {},
        },
        {
          title: "approvals",
          icon: markRaw(AccountClock),
          color: "primary",
          stat: {},
        }]

      this.quickStats.forEach(({ title, stat: { online, offline, disabled, pending, approved, rejected } }) => {
        if (title === "displays") {
          online = this.displays.filter((d) => d.status === "online").length;
          offline = this.displays.filter((d) => d.status === "offline").length;
          disabled = this.displays.filter((d) => d.status === "disabled").length;
        }
        if (title === "approvals") {
          pending = this.approvals.filter((a) => a.status === "pending").length;
          approved = this.approvals.filter((a) => a.status === "approved").length;
          rejected = this.approvals.filter((a) => a.status === "rejected").length;
        }
      })

      this.loading = false;
    } catch {
      console.log("No events found")
    }
  },

  beforeUnmount() {
    window.removeEventListener("scroll", this.handleScroll);
  },
};
</script>

<style scoped>
#dashboard-view {
  min-height: 100%;
  max-height: 100%;
  overflow-x: hidden;
  overflow-y: auto;
}

.scrollable-list {
  max-height: 340px;
  overflow-y: auto;
}

.list-group-item:nth-child(even) {
  background: var(--bs-light);
}

.list-group-item:nth-child(odd) {
  background: white;
}

/* kpi stat icon */
.stat-icon {
  width: 40px;
  height: 40px;
}

/* upload icon */
.upload-icon {
  width: 44px;
  height: 44px;
  font-size: 1.2rem;
  background: var(--bs-light);
}

/* activity bar */
.activity-avatar {
  width: 28px;
  height: 28px;
  font-size: 0.8rem;
  background: var(--bs-secondary-bg-subtle);
}

/* attention dot */
.attention-dot {
  width: 8px;
  height: 8px;
  background: var(--bs-warning);
}

/* timeline styles */
.timeline-item {
  position: relative;
}

.timeline-item:last-child .timeline-content {
  padding-bottom: 0;
}

.timeline-content {
  padding-left: 0.5rem;
  border-bottom: 1px solid var(--bs-border-color, #dee2e6);
}

.timeline-item:last-child .timeline-content {
  border-bottom: none;
}
</style>