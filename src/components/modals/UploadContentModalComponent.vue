<template>
  <form @submit.prevent="uploadContent">
    <div class="modal fade" id="upload-content-modal" ref="uploadContentModal" tabindex="-1">
      <div class="modal-dialog modal-dialog-centered" style="max-width: 500px;">
        <div class="modal-content shadow">
          <div class="modal-header">
            <div class="d-flex align-items-center w-100">
              <strong class="text-nowrap overflow-hidden me-4" style="text-overflow: ellipsis">
                Submit Content
              </strong>
            </div>
          </div>
          <div class="modal-body">
            <!-- help description -->
            <small>Submit (jpg, jpeg, png, pdf) files so they can be added to a playlist and assigned to
              screens.</small>
            <span style="font-size: 8pt; line-height: 5px;" class="text-muted fst-italic">NOTE: If submitted by a user in the 'Supervisors' group, HR will need to approve the files before it becomes available</span>
            <transition enter-active-class="animate__animated animate__fadeIn animate__faster">
              <!-- error message -->
              <div v-if="error" class="mb-2 p-2 small rounded bg-danger-subtle text-danger-emphasis">
                {{ error }}
              </div>
            </transition>

            <!-- file upload -->
            <BFormFile accept=".jpg,.jpeg,.png,.pdf" class="form small mb-2" id="upload-content-file" multiple
              v-model="files" />
            <div class="d-flex flex-wrap mb-2 gap-1">
              <span v-for="s in submittedFiles" :key="s" class="badge rounded-pill bg-primary-subtle text-primary-emphasis me-1">{{ s }}</span>
            </div>
          </div>
          <div class="modal-footer p-2">
            <button type="reset" class="btn btn-sm btn-danger me-2" data-bs-dismiss="modal" @click="clearChanges"
              title="Cancel">
              Cancel
            </button>

            <button type="submit" class="btn btn-sm btn-success" title="Upload Content"> <!-- continue here and finish the upload process -->
              + Upload
            </button>
          </div>
        </div>
      </div>
    </div>
  </form>
</template>

<script>
import { clearModalFocus } from '@/common/helpers';
import { BFormFile } from 'bootstrap-vue-next';

export default {
  components: {
    BFormFile
  },
  mounted() {
    clearModalFocus(this.$refs.uploadContentModal);
  },
  data() {
    return {
      error: null,
      files: []
    }
  },
  computed: {
    submittedFiles() {
      return this.files?.map(file => file.name) || 'No files selected';
    }
  },
  methods: {
    upload() {
      // console log the files the user has uploaded
      const files = document.getElementById('upload-content-file').files;
      console.log(files);
    },
  }
}
</script>