Class {
	#name : #ToMaterialDesignAlertIconProvider,
	#superclass : #ToMaterialDesignIconProvider,
	#category : #'Toplo-Imported-Icons-MaterialDesign'
}

{ #category : #'_private - icon type' }
ToMaterialDesignAlertIconProvider class >> _iconType [

	^ #'alert'
]

{ #category : #'_private - loaded and unloadable' }
ToMaterialDesignAlertIconProvider class >> _outlined_loaded [
^ #( #error_outline #add_alert #notification_important #warning_amber #warning #auto_delete #error  )
]

{ #category : #'_private - loaded and unloadable' }
ToMaterialDesignAlertIconProvider class >> _outlined_unloadable [
^ #(  )
]

{ #category : #'_private - loaded and unloadable' }
ToMaterialDesignAlertIconProvider class >> _round_loaded [
^ #( #error_outline #add_alert #notification_important #warning_amber #warning #auto_delete #error  )
]

{ #category : #'_private - loaded and unloadable' }
ToMaterialDesignAlertIconProvider class >> _round_unloadable [
^ #(  )
]

{ #category : #'_private - loaded and unloadable' }
ToMaterialDesignAlertIconProvider class >> _sharp_loaded [
^ #( #error_outline #add_alert #notification_important #warning_amber #warning #auto_delete #error  )
]

{ #category : #'_private - loaded and unloadable' }
ToMaterialDesignAlertIconProvider class >> _sharp_unloadable [
^ #(  )
]

{ #category : #'_private - loaded and unloadable' }
ToMaterialDesignAlertIconProvider class >> _twotone_loaded [
^ #( #error_outline #warning_amber  )
]

{ #category : #'_private - loaded and unloadable' }
ToMaterialDesignAlertIconProvider class >> _twotone_unloadable [
^ #( #add_alert #notification_important #warning #auto_delete #error  )
]

{ #category : #'add_alert' }
ToMaterialDesignAlertIconProvider class >> outlined_add_alert [
^'<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24"><path d="M10.01 21.01c0 1.1.89 1.99 1.99 1.99s1.99-.89 1.99-1.99h-3.98zM12 6c2.76 0 5 2.24 5 5v7H7v-7c0-2.76 2.24-5 5-5zm0-4.5c-.83 0-1.5.67-1.5 1.5v1.17C7.36 4.85 5 7.65 5 11v6l-2 2v1h18v-1l-2-2v-6c0-3.35-2.36-6.15-5.5-6.83V3c0-.83-.67-1.5-1.5-1.5zM13 8h-2v3H8v2h3v3h2v-3h3v-2h-3z"/></svg>'
]

{ #category : #'auto_delete' }
ToMaterialDesignAlertIconProvider class >> outlined_auto_delete [
^'<svg xmlns="http://www.w3.org/2000/svg" enable-background="new 0 0 24 24" height="24" viewBox="0 0 24 24" width="24"><g><rect fill="none" height="24" width="24"/></g><g><g><polygon points="15,2 11.5,2 10.5,1 5.5,1 4.5,2 1,2 1,4 15,4"/><path d="M16,9c-0.7,0-1.37,0.1-2,0.29V5H2v12c0,1.1,0.9,2,2,2h5.68c1.12,2.36,3.53,4,6.32,4c3.87,0,7-3.13,7-7 C23,12.13,19.87,9,16,9z M9,16c0,0.34,0.03,0.67,0.08,1H4V7h8v3.26C10.19,11.53,9,13.62,9,16z M16,21c-2.76,0-5-2.24-5-5 s2.24-5,5-5s5,2.24,5,5S18.76,21,16,21z"/><polygon points="16.5,12 15,12 15,17 18.6,19.1 19.4,17.9 16.5,16.2"/></g></g></svg>'
]

{ #category : #error }
ToMaterialDesignAlertIconProvider class >> outlined_error [
^'<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z"/></svg>'
]

{ #category : #'error_outline' }
ToMaterialDesignAlertIconProvider class >> outlined_error_outline [
^'<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24"><path d="M11 15h2v2h-2v-2zm0-8h2v6h-2V7zm.99-5C6.47 2 2 6.48 2 12s4.47 10 9.99 10C17.52 22 22 17.52 22 12S17.52 2 11.99 2zM12 20c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8z"/></svg>'
]

{ #category : #'notification_important' }
ToMaterialDesignAlertIconProvider class >> outlined_notification_important [
^'<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24"><path d="M10.01 21.01c0 1.1.89 1.99 1.99 1.99s1.99-.89 1.99-1.99h-3.98zM12 6c2.76 0 5 2.24 5 5v7H7v-7c0-2.76 2.24-5 5-5zm0-4.5c-.83 0-1.5.67-1.5 1.5v1.17C7.36 4.85 5 7.65 5 11v6l-2 2v1h18v-1l-2-2v-6c0-3.35-2.36-6.15-5.5-6.83V3c0-.83-.67-1.5-1.5-1.5zM11 8h2v4h-2zm0 6h2v2h-2z"/></svg>'
]

{ #category : #warning }
ToMaterialDesignAlertIconProvider class >> outlined_warning [
^'<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24"><path d="M1 21h22L12 2 1 21zm12-3h-2v-2h2v2zm0-4h-2v-4h2v4z"/></svg>'
]

{ #category : #'warning_amber' }
ToMaterialDesignAlertIconProvider class >> outlined_warning_amber [
^'<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24"><path d="M12 5.99L19.53 19H4.47L12 5.99M12 2L1 21h22L12 2zm1 14h-2v2h2v-2zm0-6h-2v4h2v-4z"/></svg>'
]

{ #category : #'add_alert' }
ToMaterialDesignAlertIconProvider class >> round_add_alert [
^'<svg xmlns="http://www.w3.org/2000/svg" enable-background="new 0 0 24 24" height="24" viewBox="0 0 24 24" width="24"><g><rect fill="none" height="24" width="24"/></g><g><g><g><path d="M12,22c1.1,0,2-0.9,2-2h-4C10,21.1,10.9,22,12,22z"/></g><g><path d="M19,17h-1v-7c0-2.79-1.91-5.14-4.5-5.8V3.5C13.5,2.67,12.83,2,12,2s-1.5,0.67-1.5,1.5v0.7C7.91,4.86,6,7.21,6,10v7H5 c-0.55,0-1,0.45-1,1s0.45,1,1,1h14c0.55,0,1-0.45,1-1S19.55,17,19,17z M14,13h-1v1c0,0.55-0.45,1-1,1s-1-0.45-1-1v-1h-1 c-0.55,0-1-0.45-1-1s0.45-1,1-1h1v-1c0-0.55,0.45-1,1-1s1,0.45,1,1v1h1c0.55,0,1,0.45,1,1S14.55,13,14,13z"/></g></g></g></svg>'
]

{ #category : #'auto_delete' }
ToMaterialDesignAlertIconProvider class >> round_auto_delete [
^'<svg xmlns="http://www.w3.org/2000/svg" enable-background="new 0 0 24 24" height="24" viewBox="0 0 24 24" width="24"><g><rect fill="none" height="24" width="24"/><rect fill="none" height="24" width="24"/></g><g><g><path d="M16,9c-0.7,0-1.37,0.1-2,0.29V7c0-1.1-0.9-2-2-2H4C2.9,5,2,5.9,2,7v10c0,1.1,0.9,2,2,2h5.68c1.12,2.36,3.53,4,6.32,4 c3.87,0,7-3.13,7-7C23,12.13,19.87,9,16,9z M16,21c-2.76,0-5-2.24-5-5s2.24-5,5-5s5,2.24,5,5S18.76,21,16,21z"/><path d="M14,4c0.55,0,1-0.45,1-1c0-0.55-0.45-1-1-1h-2.5l-0.71-0.71C10.61,1.11,10.35,1,10.09,1H5.91C5.65,1,5.39,1.11,5.21,1.29 L4.5,2H2C1.45,2,1,2.45,1,3c0,0.55,0.45,1,1,1H14z"/><path d="M15.75,12L15.75,12C15.34,12,15,12.34,15,12.75v3.68c0,0.36,0.19,0.68,0.5,0.86l2.52,1.47c0.33,0.19,0.75,0.09,0.96-0.22 v0c0.23-0.34,0.12-0.81-0.24-1.02L16.5,16.2v-3.45C16.5,12.34,16.16,12,15.75,12z"/></g></g></svg>'
]

{ #category : #error }
ToMaterialDesignAlertIconProvider class >> round_error [
^'<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 11c-.55 0-1-.45-1-1V8c0-.55.45-1 1-1s1 .45 1 1v4c0 .55-.45 1-1 1zm1 4h-2v-2h2v2z"/></svg>'
]

{ #category : #'error_outline' }
ToMaterialDesignAlertIconProvider class >> round_error_outline [
^'<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24"><path d="M12 7c.55 0 1 .45 1 1v4c0 .55-.45 1-1 1s-1-.45-1-1V8c0-.55.45-1 1-1zm-.01-5C6.47 2 2 6.48 2 12s4.47 10 9.99 10C17.52 22 22 17.52 22 12S17.52 2 11.99 2zM12 20c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8zm1-3h-2v-2h2v2z"/></svg>'
]

{ #category : #'notification_important' }
ToMaterialDesignAlertIconProvider class >> round_notification_important [
^'<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24"><path d="M12 23c1.1 0 1.99-.89 1.99-1.99h-3.98c0 1.1.89 1.99 1.99 1.99zm8.29-4.71L19 17v-6c0-3.35-2.36-6.15-5.5-6.83V3c0-.83-.67-1.5-1.5-1.5s-1.5.67-1.5 1.5v1.17C7.36 4.85 5 7.65 5 11v6l-1.29 1.29c-.63.63-.19 1.71.7 1.71h15.17c.9 0 1.34-1.08.71-1.71zM13 16h-2v-2h2v2zm0-5c0 .55-.45 1-1 1s-1-.45-1-1V9c0-.55.45-1 1-1s1 .45 1 1v2z"/></svg>'
]

{ #category : #warning }
ToMaterialDesignAlertIconProvider class >> round_warning [
^'<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24"><path d="M4.47 21h15.06c1.54 0 2.5-1.67 1.73-3L13.73 4.99c-.77-1.33-2.69-1.33-3.46 0L2.74 18c-.77 1.33.19 3 1.73 3zM12 14c-.55 0-1-.45-1-1v-2c0-.55.45-1 1-1s1 .45 1 1v2c0 .55-.45 1-1 1zm1 4h-2v-2h2v2z"/></svg>'
]

{ #category : #'warning_amber' }
ToMaterialDesignAlertIconProvider class >> round_warning_amber [
^'<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24"><path d="M12 5.99L19.53 19H4.47L12 5.99M2.74 18c-.77 1.33.19 3 1.73 3h15.06c1.54 0 2.5-1.67 1.73-3L13.73 4.99c-.77-1.33-2.69-1.33-3.46 0L2.74 18zM11 11v2c0 .55.45 1 1 1s1-.45 1-1v-2c0-.55-.45-1-1-1s-1 .45-1 1zm0 5h2v2h-2z"/></svg>'
]

{ #category : #'add_alert' }
ToMaterialDesignAlertIconProvider class >> sharp_add_alert [
^'<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24"><path d="M12 23c1.1 0 1.99-.89 1.99-1.99h-3.98c0 1.1.89 1.99 1.99 1.99zm7-6v-6c0-3.35-2.36-6.15-5.5-6.83V1.5h-3v2.67C7.36 4.85 5 7.65 5 11v6l-2 2v1h18v-1l-2-2zm-3-3.99h-3v3h-2v-3H8V11h3V8h2v3h3v2.01z"/></svg>'
]

{ #category : #'auto_delete' }
ToMaterialDesignAlertIconProvider class >> sharp_auto_delete [
^'<svg xmlns="http://www.w3.org/2000/svg" enable-background="new 0 0 24 24" height="24" viewBox="0 0 24 24" width="24"><g><rect fill="none" height="24" width="24"/></g><g><g><polygon points="15,2 11.5,2 10.5,1 5.5,1 4.5,2 1,2 1,4 15,4"/><path d="M16,9c-0.7,0-1.37,0.1-2,0.29V5H2v14h7.68c1.12,2.36,3.53,4,6.32,4c3.87,0,7-3.13,7-7C23,12.13,19.87,9,16,9z M16,21 c-2.76,0-5-2.24-5-5s2.24-5,5-5s5,2.24,5,5S18.76,21,16,21z"/><polygon points="16.5,12 15,12 15,17 18.6,19.1 19.4,17.9 16.5,16.2"/></g></g></svg>'
]

{ #category : #error }
ToMaterialDesignAlertIconProvider class >> sharp_error [
^'<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z"/></svg>'
]

{ #category : #'error_outline' }
ToMaterialDesignAlertIconProvider class >> sharp_error_outline [
^'<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24"><path d="M11 15h2v2h-2v-2zm0-8h2v6h-2V7zm.99-5C6.47 2 2 6.48 2 12s4.47 10 9.99 10C17.52 22 22 17.52 22 12S17.52 2 11.99 2zM12 20c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8z"/></svg>'
]

{ #category : #'notification_important' }
ToMaterialDesignAlertIconProvider class >> sharp_notification_important [
^'<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24"><path d="M12 23c1.1 0 1.99-.89 1.99-1.99h-3.98c0 1.1.89 1.99 1.99 1.99zm7-6v-6c0-3.35-2.36-6.15-5.5-6.83V1.5h-3v2.67C7.36 4.85 5 7.65 5 11v6l-2 2v1h18v-1l-2-2zm-6-1h-2v-2h2v2zm0-4h-2V8h2v4z"/></svg>'
]

{ #category : #warning }
ToMaterialDesignAlertIconProvider class >> sharp_warning [
^'<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24"><path d="M1 21h22L12 2 1 21zm12-3h-2v-2h2v2zm0-4h-2v-4h2v4z"/></svg>'
]

{ #category : #'warning_amber' }
ToMaterialDesignAlertIconProvider class >> sharp_warning_amber [
^'<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24"><path d="M12 5.99L19.53 19H4.47L12 5.99M12 2L1 21h22L12 2zm1 14h-2v2h2v-2zm0-6h-2v4h2v-4z"/></svg>'
]

{ #category : #'error_outline' }
ToMaterialDesignAlertIconProvider class >> twotone_error_outline [
^'<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24"><path d="M11.99 2C6.47 2 2 6.48 2 12s4.47 10 9.99 10C17.52 22 22 17.52 22 12S17.52 2 11.99 2zM12 20c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8zm-1-5h2v2h-2zm0-8h2v6h-2z"/></svg>'
]

{ #category : #'warning_amber' }
ToMaterialDesignAlertIconProvider class >> twotone_warning_amber [
^'<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24"><path d="M1 21h22L12 2 1 21zm3.47-2L12 5.99 19.53 19H4.47zM11 16h2v2h-2zm0-6h2v4h-2z"/></svg>'
]
