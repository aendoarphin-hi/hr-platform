// object version
export const config = {
  appName: 'Signage',
  appVersion: '2026.0715.1',
  groups: ['HR Comms System', 'HR Comms HR', 'HR Comms Supervisors'],
  supportEmail: 'hr@haydenindustrial.com',
  api: '/ttprod/v3/hrcomms/',
}
// limits subtypes based on chosen category
export const eventCategorySubtypeMap = {
  company: ['general', 'holiday', 'training', 'meeting'],
  employee: ['birthday', 'anniversary', 'promotion', 'new_hire'],
  announcement: ['general', 'urgent', 'maintenance', 'production', 'weather', 'safety']
}

