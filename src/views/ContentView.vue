<template>
  <div id="content-view" class="w-100 p-3 overflow-x-hidden overflow-y-auto" style="min-height: 100%">
    <!-- ===== header + toolbar ===== -->
    <div class="hstack align-items-center flex-wrap">
      <!-- header -->
      <div class="fs-5 fw-semibold text-capitalize">
        {{ $route.name }}
      </div>
      <!-- toolbar -->
      <div class="hstack ms-auto fw-semibold gap-2 flex-wrap">
        <button class="btn btn-sm btn-success" @click="showUploadModal = true">
          <UploadBox :size="16" class="me-1" />
          Upload Content
        </button>
      </div>
    </div>

    <!-- ===== statistics cards row ===== -->
    <div class="d-flex flex-row flex-wrap gap-3 mt-3">
      <!-- total files -->
      <div class="card flex-grow-1 p-3">
        <div class="d-flex flex-row justify-content-between align-items-center fs-5">
          <span class="fw-semibold">Total Files</span>
          <FileDocumentMultiple />
        </div>
        <div class="mt-2 fs-3 fw-semibold">{{ stats.totalFiles }}</div>
      </div>
      <!-- images -->
      <div class="card flex-grow-1 p-3">
        <div class="d-flex flex-row justify-content-between align-items-center fs-5">
          <span class="fw-semibold">Images</span>
          <Image />
        </div>
        <div class="mt-2 fs-3 fw-semibold">{{ stats.images }}</div>
      </div>
      <!-- documents -->
      <div class="card flex-grow-1 p-3">
        <div class="d-flex flex-row justify-content-between align-items-center fs-5">
          <span class="fw-semibold">Documents</span>
          <FilePdfBox />
        </div>
        <div class="mt-2 fs-3 fw-semibold">{{ stats.documents }}</div>
      </div>
      <!-- slides -->
      <div class="card flex-grow-1 p-3">
        <div class="d-flex flex-row justify-content-between align-items-center fs-5">
          <span class="fw-semibold">Slides</span>
          <FileDocumentOutline />
        </div>
        <div class="mt-2 fs-3 fw-semibold">{{ stats.slides }}</div>
      </div>
    </div>

    <!-- ===== search + filter toolbar ===== -->
    <div class="d-flex flex-row align-items-center justify-content-start mt-3 mb-3 flex-wrap gap-2">
      <!-- sorter -->
      <div class="btn-group text-nowrap" role="group">
        <button v-for="s in sortOptions" :key="s.value" class="btn btn-sm"
          :class="sortBy === s.value ? 'btn-secondary' : 'btn-outline-secondary'" @click="
            sortBy = s.value;
          filterContent();
          ">
          {{ s.label }}
        </button>
      </div>

      <!-- ===== category tabs / chips ===== -->
      <div class="d-flex flex-wrap gap-2">
        <button v-for="cat in categories" :key="cat.key" class="btn btn-sm rounded px-3"
          :class="activeCategory === cat.key ? 'btn-primary' : 'btn-outline-secondary'" @click="
            activeCategory = cat.key;
          filterContent();
          ">
          <component :is="cat.icon" :size="14" class="me-1" />
          {{ cat.label }}
          <span class="badge ms-1" :class="activeCategory === cat.key ? 'text-bg-light' : 'text-bg-secondary'">
            {{ cat.count }}
          </span>
        </button>
      </div>

      <div class="btn-group ms-auto" role="group">
        <button type="button" class="btn btn-sm d-flex align-items-center"
          :class="viewMode === 'list' ? 'btn-secondary' : 'btn-outline-secondary'" title="List view"
          @click="viewMode = 'list'">
          <ViewList class="mb-1" />
        </button>
        <button type="button" class="btn btn-sm d-flex align-items-center"
          :class="viewMode === 'grid' ? 'btn-secondary' : 'btn-outline-secondary'" title="Grid view"
          @click="viewMode = 'grid'">
          <ViewGrid class="mb-1" />
        </button>
      </div>

      <!-- search bar -->
      <div class="input-group input-group-sm w-100">
        <span class="input-group-text bg-white border-end-0">
          <Magnify :size="14" class="text-muted" />
        </span>
        <input v-model="searchQuery" type="search" class="form-control border-start-0 ps-0"
          placeholder="Search files by name..." @input="onSearchInput" />
      </div>
    </div>

    <LoadingComponent v-if="loading" message="Loading content library..." />

    <!-- ===== content display: grid view ===== -->
    <div v-else-if="viewMode === 'grid' && filteredContent.length"
      class="d-flex flex-row flex-wrap gap-3 overflow-hidden overflow-y-auto border-bottom border-top py-3"
      style="max-height: 500px">
      <div v-for="(item, index) in filteredContent" :key="item.id"
        class="card p-0 content-card cursor-pointer overflow-hidden" style="width: 200px"
        :style="{ animationDelay: `${index * 0.05}s` }" @click="previewItem(item)">
        <!-- thumbnail / preview area -->
        <div class="content-thumb-wrap position-relative overflow-hidden">
          <!-- image thumbnail (color + icon, no real image) -->
          <div class="content-thumb d-flex align-items-center justify-content-center" :class="thumbBgClass(item.type)">
            <component :is="thumbIcon(item.type)" :size="48" class="text-white opacity-75" />
          </div>

          <!-- file type badge -->
          <span class="position-absolute top-0 start-0 badge m-2" :class="typeBadgeClass(item.type)">
            {{ typeLabel(item.type) }}
          </span>

          <!-- hover overlay with quick actions -->
          <div class="content-hover-overlay d-flex align-items-center justify-content-center gap-2">
            <span class="rounded-circle bg-white bg-opacity-25 p-2 d-flex" title="Preview"
              @click.stop="previewItem(item)">
              <EyeOutline :size="18" class="text-white" />
            </span>
            <span class="rounded-circle bg-white bg-opacity-25 p-2 d-flex" title="Download"
              @click.stop="downloadItem(item)">
              <Download :size="18" class="text-white" />
            </span>
            <span class="rounded-circle bg-white bg-opacity-25 p-2 d-flex" title="Delete"
              @click.stop="confirmDelete(item)">
              <DeleteOutline :size="18" class="text-white" />
            </span>
          </div>
        </div>

        <!-- card body with file info -->
        <div class="card-body p-2">
          <div class="fw-semibold small text-truncate" :title="item.name">{{ item.name }}</div>
          <div class="text-muted small d-flex justify-content-between mt-1">
            <span>{{ item.fileSize }}</span>
            <span>{{ formatDateRelative(item.uploadedAt) }}</span>
          </div>
        </div>
      </div>
    </div>

    <!-- ===== content display: list view ===== -->
    <div v-else-if="viewMode === 'list' && filteredContent.length" class="mt-3">
      <table class="card overflow-hidden table table-hover align-middle mb-0 table-scroll">
        <thead class="card-header">
          <tr>
            <th scope="col">Name</th>
            <th scope="col" class="d-none d-md-table-cell">Type</th>
            <th scope="col" class="d-none d-sm-table-cell ps-0">Size</th>
            <th scope="col" class="d-none d-lg-table-cell ps-0">Uploaded</th>
            <th scope="col" class="ps-3">Actions</th>
          </tr>
        </thead>
        <tbody style="max-height: 500px">
          <tr v-for="item in filteredContent" :key="'list-' + item.id" class="small">
            <!-- name -->
            <td>
              <div class="fw-semibold small text-truncate" :title="item.name">{{ item.name }}</div>
            </td>
            <!-- type -->
            <td class="d-none d-md-table-cell">
              <span class="badge rounded-pill" :class="typeBadgeClass(item.type)">{{ typeLabel(item.type) }}</span>
            </td>
            <!-- size -->
            <td class="d-none d-sm-table-cell text-muted small">{{ item.fileSize }}</td>
            <!-- uploaded -->
            <td class="d-none d-lg-table-cell text-muted small">{{ formatDateRelative(item.uploadedAt) }}</td>
            <!-- actions -->
            <td>
              <div class="overflow-hidden btn-group border">
                <span class="btn btn-sm btn-light text-secondary border-0" title="Preview" @click="previewItem(item)">
                  <EyeOutline :size="16" />
                </span>
                <span class="btn btn-sm btn-light text-secondary border-0" title="Download" @click="downloadItem(item)">
                  <Download :size="16" />
                </span>
                <span class="btn btn-sm btn-light text-danger border-0" title="Delete" @click="confirmDelete(item)">
                  <DeleteOutline :size="16" />
                </span>
              </div>
            </td>
          </tr>
          <tr v-if="filteredContent.length === 0">
            <td colspan="5" class="text-center text-secondary py-4">No files match your search criteria.</td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- ===== empty state ===== -->
    <div v-else class="text-center mt-5 py-5">
      <div class="mb-3">
        <FileDocumentMultiple :size="64" class="text-muted opacity-25" />
      </div>
      <h5 class="text-muted fw-normal" v-if="searchQuery || activeCategory !== 'all'">
        No files match your search criteria
      </h5>
      <h5 class="text-muted fw-normal" v-else>No content uploaded yet</h5>
      <p class="text-muted small">Upload screen content to get started.</p>
      <button class="btn btn-primary btn-sm" @click="showUploadModal = true">
        <UploadBox :size="16" class="me-1" />
        Upload Content
      </button>
    </div>

    <!-- ===== preview modal ===== -->
    <div v-if="showPreviewModal && previewItemData"
      class="modal position-fixed top-0 start-0 end-0 bottom-0 bg-dark bg-opacity-50 d-flex align-items-center justify-content-center"
      @click.self="showPreviewModal = false">
      <div class="card p-3" style="width: 600px; max-width: 90vw">
        <div class="d-flex justify-content-between align-items-center mb-3">
          <span class="fw-semibold fs-5 text-truncate">{{ previewItemData.name }}</span>
        </div>

        <!-- preview content based on type (colored bg + icon) -->
        <div class="d-flex flex-column align-items-center justify-content-center py-5 rounded-3"
          :class="thumbBgClass(previewItemData.type)">
          <component :is="thumbIcon(previewItemData.type)" :size="64" class="text-white opacity-75 mb-3" />
          <span class="badge rounded-pill" :class="typeBadgeClass(previewItemData.type)">
            {{ typeLabel(previewItemData.type) }}
          </span>
        </div>

        <!-- file details -->
        <div class="small text-muted mt-3">
          <div class="row g-2">
            <div class="col-6 col-md-3">
              <span class="text-uppercase">Type</span><br />
              <span class="fw-semibold">{{ typeLabel(previewItemData.type) }}</span>
            </div>
            <div class="col-6 col-md-3">
              <span class="text-uppercase">Size</span><br />
              <span class="fw-semibold">{{ previewItemData.fileSize }}</span>
            </div>
            <div class="col-6 col-md-3">
              <span class="text-uppercase">Uploaded</span><br />
              <span class="fw-semibold">{{ formatDate(previewItemData.uploadedAt) }}</span>
            </div>
            <div class="col-6 col-md-3">
              <span class="text-uppercase">Uploaded By</span><br />
              <span class="fw-semibold">{{ previewItemData.uploadedBy || "—" }}</span>
            </div>
          </div>
        </div>

        <div class="d-flex btn-group border justify-content-between mt-3 overflow-hidden">
          <button class="btn btn-sm btn-light text-secondary" @click="showPreviewModal = false">Close</button>
          <button class="btn btn-sm btn-primary" @click="downloadItem(previewItemData)">
            <Download :size="16" class="me-1" />
            Download
          </button>
        </div>
      </div>
    </div>

    <!-- ===== upload modal ===== -->
    <div v-if="showUploadModal"
      class="modal position-fixed top-0 start-0 end-0 bottom-0 bg-dark bg-opacity-50 d-flex align-items-center justify-content-center"
      @click.self="showUploadModal = false">
      <div class="card bg-light" style="width: 520px; max-width: 90vw">
        <div class="card">
          <div class="card-header fw-semibold hstack">
            <UploadBox :size="20" class="me-1" />
            Upload Content
          </div>
          <div class="card-body">
            <!-- drag & drop zone -->
            <div class="upload-zone border-2 border-dashed rounded-3 p-5 text-center"
              :class="{ 'border-primary bg-primary bg-opacity-10': isDragging }" @dragenter.prevent="isDragging = true"
              @dragover.prevent="isDragging = true" @dragleave.prevent="isDragging = false" @drop.prevent="onDrop">
              <UploadBox :size="48" class="text-muted mb-3" />
              <h6 class="fw-normal text-muted">Drag & drop files here or click to browse</h6>
              <p class="small text-muted mb-3">Supports images, PDFs, PowerPoint, and other document formats</p>
              <input ref="fileInput" type="file" multiple class="d-none"
                accept="image/*,application/pdf,application/vnd.ms-powerpoint,application/vnd.openxmlformats-officedocument.presentationml.presentation"
                @change="onFileSelected" />
              <button class="btn btn-primary btn-sm" @click="$refs.fileInput.click()">
                <UploadBox :size="16" class="me-1" />
                Browse Files
              </button>
            </div>
            <!-- selected files list -->
            <div v-if="uploadFiles.length" class="mt-3">
              <div class="small fw-semibold text-muted mb-2">Selected Files ({{ uploadFiles.length }})</div>
              <div v-for="(file, i) in uploadFiles" :key="i"
                class="d-flex align-items-center gap-2 mb-1 p-2 bg-light rounded-3">
                <component :is="getFileIcon(file.type)" :size="18" class="flex-shrink-0 text-muted" />
                <div class="flex-grow-1 small text-truncate">{{ file.name }}</div>
                <span class="small text-muted flex-shrink-0">{{ formatFileSize(file.size) }}</span>
                <span class="btn btn-sm text-danger border-0 p-0" @click="removeUploadFile(i)">
                  <CloseCircleOutline :size="16" />
                </span>
              </div>
            </div>
          </div>
          <div class="card-footer text-end">
            <div class="text-end hstack justify-content-end gap-1">
              <button class="btn btn-sm btn-danger" @click="resetUpload">Cancel</button>
              <button class="btn btn-sm btn-success" :disabled="!uploadFiles.length || uploading" @click="startUpload">
                <UploadBox v-if="!uploading" :size="16" class="me-1" />
                <span v-if="uploading" class="spinner-border spinner-border-sm me-1"></span>
                {{ uploading ? "Uploading..." : `Upload (${uploadFiles.length})` }}
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- ===== delete confirmation modal ===== -->
    <div v-if="showDeleteModal"
      class="modal position-fixed top-0 start-0 end-0 bottom-0 bg-dark bg-opacity-50 d-flex align-items-center justify-content-center"
      @click.self="showDeleteModal = false">
      <div class="card" style="width: 380px; max-width: 90vw">
        <div class="card-body text-center py-4">
          <DeleteOutline :size="48" class="text-danger mb-2" />
          <h6 class="fw-semibold">Delete File?</h6>
          <p class="small text-muted mb-0">
            Are you sure you want to delete <strong>{{ deleteTarget?.name }}</strong>? This action cannot be undone.
          </p>
        </div>
        <div class="card-footer border-top-0 text-center pt-0">
          <div class="hstack justify-content-center gap-2">
            <button class="btn btn-sm btn-outline-secondary" @click="showDeleteModal = false">Cancel</button>
            <button class="btn btn-sm btn-danger" @click="deleteItem">
              <DeleteOutline :size="16" class="me-1" />
              Delete
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
/* ====================== icons ======================= */
import FileDocumentMultiple from "vue-material-design-icons/FileDocumentMultiple.vue";
import UploadBox from "vue-material-design-icons/UploadBox.vue";
import Magnify from "vue-material-design-icons/Magnify.vue";
import ViewGrid from "vue-material-design-icons/ViewGrid.vue";
import ViewList from "vue-material-design-icons/ViewList.vue";
import Image from "vue-material-design-icons/Image.vue";
import FilePdfBox from "vue-material-design-icons/FilePdfBox.vue";
import FileDocumentOutline from "vue-material-design-icons/FileDocumentOutline.vue";
import EyeOutline from "vue-material-design-icons/EyeOutline.vue";
import Download from "vue-material-design-icons/Download.vue";
import DeleteOutline from "vue-material-design-icons/DeleteOutline.vue";
import CloseCircleOutline from "vue-material-design-icons/CloseCircleOutline.vue";
import Close from "vue-material-design-icons/Close.vue";
import FilePowerpoint from "vue-material-design-icons/FilePowerpoint.vue";
/* ==================== components ======================= */
import LoadingComponent from "@/components/LoadingComponent.vue";

export default {
  name: "ContentView",

  components: {
    FileDocumentMultiple,
    UploadBox,
    Magnify,
    ViewGrid,
    ViewList,
    Image,
    FilePdfBox,
    FileDocumentOutline,
    EyeOutline,
    Download,
    DeleteOutline,
    CloseCircleOutline,
    Close,
    FilePowerpoint,

    LoadingComponent
  },

  data() {
    return {
      // ========== content library data ==========
      contentLibrary: [],
      loading: false,

      // ========== filtering & search ==========
      searchQuery: "",
      sortBy: "newest",
      activeCategory: "all",
      searchTimeout: null,

      // ========== view mode ==========
      viewMode: "grid",

      // ========== upload modal ==========
      showUploadModal: false,
      uploadFiles: [],
      uploading: false,
      isDragging: false,

      // ========== preview modal ==========
      showPreviewModal: false,
      previewItemData: null,

      // ========== delete confirmation ==========
      showDeleteModal: false,
      deleteTarget: null,

      // ========== toolbar options ==========
      sortOptions: [
        { value: "newest", label: "Newest" },
        { value: "oldest", label: "Oldest" },
        { value: "name", label: "A–Z" },
        { value: "size_desc", label: "Size" },
      ],
    };
  },

  computed: {
    /**
     * aggregated statistics derived from the content library.
     */
    stats() {
      const total = this.contentLibrary.length;
      const images = this.contentLibrary.filter((f) => f.type === "image").length;
      const documents = this.contentLibrary.filter((f) => f.type === "document").length;
      const slides = this.contentLibrary.filter((f) => f.type === "slides").length;
      return {
        totalFiles: total,
        images,
        documents,
        slides,
      };
    },

    /**
     * category chip definitions — auto-counts from library data.
     */
    categories() {
      return [
        { key: "all", label: "All", icon: FileDocumentMultiple, count: this.contentLibrary.length },
        {
          key: "image",
          label: "Images",
          icon: Image,
          count: this.contentLibrary.filter((f) => f.type === "image").length,
        },
        {
          key: "document",
          label: "PDFs",
          icon: FilePdfBox,
          count: this.contentLibrary.filter((f) => f.type === "document").length,
        },
        {
          key: "slides",
          label: "Slides",
          icon: FilePowerpoint,
          count: this.contentLibrary.filter((f) => f.type === "slides").length,
        },
      ];
    },

    /**
     * filtered + sorted view of the content library.
     */
    filteredContent() {
      let items = [...this.contentLibrary];

      // apply search filter (by name)
      if (this.searchQuery.trim()) {
        const q = this.searchQuery.trim().toLowerCase();
        items = items.filter((item) => item.name.toLowerCase().includes(q));
      }

      // apply category chip filter
      if (this.activeCategory !== "all") {
        items = items.filter((item) => item.type === this.activeCategory);
      }

      // apply sorting
      switch (this.sortBy) {
        case "newest":
          items.sort((a, b) => new Date(b.uploadedAt) - new Date(a.uploadedAt));
          break;
        case "oldest":
          items.sort((a, b) => new Date(a.uploadedAt) - new Date(b.uploadedAt));
          break;
        case "name":
          items.sort((a, b) => a.name.localeCompare(b.name));
          break;
        case "name_desc":
          items.sort((a, b) => b.name.localeCompare(a.name));
          break;
        case "size":
          items.sort((a, b) => a.rawSize - b.rawSize);
          break;
        case "size_desc":
          items.sort((a, b) => b.rawSize - a.rawSize);
          break;
        default:
          break;
      }

      return items;
    },
  },

  methods: {
    // ====== initialization ======
    loadContent() {
      this.loading = true;
      setTimeout(() => {
        this.contentLibrary = this.generateMockContent(20);
        this.loading = false;
      }, 600);
    },

    /**
     * generates mock content items for a screen/hr system.
     */
    generateMockContent(count) {
      const imageNames = [
        "Company_Logo.png",
        "Welcome_Banner.jpg",
        "Team_Photo_2026.jpg",
        "Office_Map.png",
        "Lunch_Menu_Weekly.png",
        "Hero_Image_Dark.jpg",
        "Weather_Overlay.png",
        "Floor_Plan.png",
        "Org_Chart_2026.png",
        "Safety_Infographic.png",
      ];
      const docNames = [
        "Benefits_Guide_2026.pdf",
        "Employee_Handbook_v3.pdf",
        "Q2_Report.pdf",
        "Brand_Guidelines.pdf",
        "Culture_Code.pdf",
        "Safety_Reminders.pdf",
        "Emergency_Procedures.pdf",
      ];
      const slideNames = [
        "Quarterly_Town_Hall.pptx",
        "Training_Module_1.pptx",
        "Product_Launch.pptx",
        "Leadership_Update.pptx",
        "New_Hire_Orientation.pptx",
      ];

      const typeSets = [
        { names: imageNames, type: "image", ext: ".png" },
        { names: docNames, type: "document", ext: ".pdf" },
        { names: slideNames, type: "slides", ext: ".pptx" },
      ];

      const people = ["Jane D.", "Mike J.", "Emily D.", "John S.", "Sarah L.", "David M."];

      const items = [];
      let id = 1;

      for (const set of typeSets) {
        for (const name of set.names) {
          const rawSize = Math.floor(Math.random() * 15_000_000) + 100_000;
          const daysAgo = Math.floor(Math.random() * 90);
          const uploadedAt = new Date(Date.now() - daysAgo * 24 * 60 * 60 * 1000);

          items.push({
            id: id++,
            name,
            type: set.type,
            rawSize,
            fileSize: this.formatFileSize(rawSize),
            uploadedAt: uploadedAt.toISOString(),
            uploadedBy: people[Math.floor(Math.random() * people.length)],
          });
        }
      }

      return items;
    },

    // ====== search ======
    onSearchInput() {
      clearTimeout(this.searchTimeout);
      this.searchTimeout = setTimeout(() => { }, 300);
    },

    filterContent() { },

    // ====== thumbnail helpers ======
    /**
     * returns a background gradient class based on file type.
     */
    thumbBgClass(type) {
      const classes = {
        image: "bg-image-thumb",
        document: "bg-document-thumb",
        slides: "bg-slides-thumb",
      };
      return classes[type] || "bg-secondary";
    },

    /**
     * returns the appropriate icon component for a file type thumbnail.
     */
    thumbIcon(type) {
      const icons = {
        image: Image,
        document: FilePdfBox,
        slides: FilePowerpoint,
      };
      return icons[type] || FileDocumentOutline;
    },

    // ====== utility formatters ======
    typeLabel(type) {
      const labels = {
        image: "Image",
        document: "PDF",
        slides: "Slides",
      };
      return labels[type] || type;
    },

    typeBadgeClass(type) {
      const classes = {
        image: "text-bg-info",
        document: "text-bg-warning text-dark",
        slides: "text-bg-success",
      };
      return classes[type] || "text-bg-secondary";
    },

    formatFileSize(bytes) {
      if (!bytes) return "0 B";
      const k = 1024;
      const sizes = ["B", "KB", "MB", "GB"];
      const i = Math.floor(Math.log(bytes) / Math.log(k));
      return parseFloat((bytes / Math.pow(k, i)).toFixed(1)) + " " + sizes[i];
    },

    formatDateRelative(dateStr) {
      if (!dateStr) return "";
      const now = new Date();
      const then = new Date(dateStr);
      const diffMins = Math.floor((now - then) / 60000);
      if (diffMins < 1) return "Just now";
      if (diffMins < 60) return `${diffMins}m ago`;
      const diffHours = Math.floor(diffMins / 60);
      if (diffHours < 24) return `${diffHours}h ago`;
      const diffDays = Math.floor(diffHours / 24);
      if (diffDays < 30) return `${diffDays}d ago`;
      return then.toLocaleDateString(undefined, { month: "short", day: "numeric" });
    },

    formatDate(dateStr) {
      if (!dateStr) return "";
      return new Date(dateStr).toLocaleDateString(undefined, {
        year: "numeric",
        month: "short",
        day: "numeric",
      });
    },

    getFileIcon(mimeType) {
      if (mimeType.startsWith("image/")) return Image;
      if (mimeType.includes("presentation") || mimeType.includes("powerpoint")) return FilePowerpoint;
      return FileDocumentOutline;
    },

    // ====== item actions ======
    previewItem(item) {
      this.previewItemData = item;
      this.showPreviewModal = true;
    },

    downloadItem(item) {
      alert(`Downloading "${item.name}" (${item.fileSize}) — simulated download.`);
    },

    confirmDelete(item) {
      this.deleteTarget = item;
      this.showDeleteModal = true;
    },

    deleteItem() {
      if (!this.deleteTarget) return;
      const index = this.contentLibrary.findIndex((f) => f.id === this.deleteTarget.id);
      if (index !== -1) {
        this.contentLibrary.splice(index, 1);
      }
      this.showDeleteModal = false;
      this.deleteTarget = null;
    },

    // ====== file upload handlers ======
    onDrop(event) {
      this.isDragging = false;
      if (event.dataTransfer.files.length) {
        this.addFiles(event.dataTransfer.files);
      }
    },

    onFileSelected(event) {
      if (event.target.files.length) {
        this.addFiles(event.target.files);
      }
    },

    addFiles(fileList) {
      for (const file of fileList) {
        const exists = this.uploadFiles.some((f) => f.name === file.name && f.size === file.size);
        if (!exists) {
          this.uploadFiles.push(file);
        }
      }
    },

    removeUploadFile(index) {
      this.uploadFiles.splice(index, 1);
    },

    resetUpload() {
      this.uploadFiles = [];
      this.uploading = false;
      this.isDragging = false;
      this.showUploadModal = false;
    },

    startUpload() {
      if (!this.uploadFiles.length) return;
      this.uploading = true;

      setTimeout(() => {
        for (const file of this.uploadFiles) {
          const ext = file.name.substring(file.name.lastIndexOf(".")).toLowerCase();
          let type = "document";
          if (file.type.startsWith("image/")) type = "image";
          else if (ext.includes(".ppt")) type = "slides";

          this.contentLibrary.unshift({
            id: Date.now() + Math.floor(Math.random() * 1000),
            name: file.name,
            type,
            rawSize: file.size,
            fileSize: this.formatFileSize(file.size),
            uploadedAt: new Date().toISOString(),
            uploadedBy: "You",
          });
        }

        this.uploading = false;
        this.uploadFiles = [];
        this.showUploadModal = false;
      }, 1500);
    },
  },

  mounted() {
    this.loadContent();
  },
};
</script>

<style scoped>
/* ===== base container ===== */
#content-view {
  min-height: 100%;
  max-height: 100%;
  overflow-x: hidden;
  overflow-y: auto;
}

/* ===== content card (grid view) ===== */
.content-card {
  transition: transform 0.2s ease, box-shadow 0.2s ease;
  cursor: pointer;
  animation: fadeInUp 0.4s ease both;
}

.content-card:hover {
  transform: translateY(-10px);
  box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1) !important;
}

/* ===== thumbnail container ===== */
.content-thumb-wrap {
  height: 140px;
  position: relative;
}

.content-thumb {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

/* thumbnail background colors */
.bg-image-thumb {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.bg-document-thumb {
  background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
}

.bg-slides-thumb {
  background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
}

/* ===== hover overlay ===== */
.content-hover-overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.5);
  opacity: 0;
  transition: opacity 0.25s ease;
}

.content-card:hover .content-hover-overlay {
  opacity: 1;
}

.content-hover-overlay span {
  transition: transform 0.15s ease, background 0.15s ease;
  cursor: pointer;
}

.content-hover-overlay span:hover {
  transform: scale(1.15);
}

/* ===== list view ===== */
.list-thumb {
  width: 48px;
  height: 48px;
  background: #f0f0f0;
}

/* ===== table scroll ===== */
.table-scroll {
  display: table;
  width: 100%;
}

.table-scroll thead {
  display: table;
  width: 100%;
  table-layout: fixed;
}

.table-scroll thead tr {
  display: table;
  width: 100%;
  table-layout: fixed;
}

.table-scroll tbody {
  display: block;
  max-height: 550px;
  overflow-y: auto;
  overflow-x: hidden;
}

.table-scroll tbody tr {
  display: table;
  width: 100%;
  table-layout: fixed;
}

tbody tr:nth-child(even) td {
  background-color: var(--bs-light) !important;
}

/* ===== upload zone ===== */
.upload-zone {
  border-style: dashed !important;
  transition: border-color 0.2s ease, background 0.2s ease;
  cursor: pointer;
}

.upload-zone:hover {
  border-color: var(--bs-primary) !important;
  background: rgba(var(--bs-primary-rgb), 0.05);
}

/* ===== animations ===== */
@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(16px);
  }

  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* ===== scrollbar styling ===== */
#content-view::-webkit-scrollbar {
  width: 6px;
}

#content-view::-webkit-scrollbar-track {
  background: transparent;
}

#content-view::-webkit-scrollbar-thumb {
  background: rgba(0, 0, 0, 0.15);
  border-radius: var(--bs-border-radius);
}
</style>