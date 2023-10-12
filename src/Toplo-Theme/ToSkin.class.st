Class {
	#name : #ToSkin,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'installStep'
	],
	#category : #'Toplo-Theme-Core'
}

{ #category : #'event handling' }
ToSkin >> checkedLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> clickedLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> closedLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> disabledLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> elementLookEvent: anEvent [


]

{ #category : #'api - accessing' }
ToSkin >> eventsToHandle [

	^ {
		  ToThemeChangedEvent.
		  ToSkinChangedEvent.
		  ToElementLookEvent }
]

{ #category : #'event handling' }
ToSkin >> focusedLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> hoveredLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> indeterminateLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> initialLookEvent: anEvent [


]

{ #category : #initialization }
ToSkin >> initialize [

	super initialize.
	self markAsNotInstalled

]

{ #category : #'private - installation' }
ToSkin >> initializedLevel [

	^ 2

]

{ #category : #'event handling' }
ToSkin >> installLookEvent: anEvent [


]

{ #category : #'private - installation' }
ToSkin >> installedLevel [

	^ 1
]

{ #category : #'private - installation' }
ToSkin >> isInitialized [

	^ installStep >= self initializedLevel 
]

{ #category : #'private - installation' }
ToSkin >> isInstalled [

	^ installStep >= self installedLevel 
]

{ #category : #'private - installation' }
ToSkin >> launchSkinInitializationIn: anElement [

	self isInitialized ifTrue: [ ^ self ].
	self markAsInitialized.
	anElement isDisabled ifTrue: [ ^ anElement switchToSkinState: ToDisabledState new ].
	anElement switchToSkinState: ToInitialState new.


]

{ #category : #'api - install/uninstall  hook' }
ToSkin >> launchSkinInstallationIn: anElement [

	self isInitialized ifTrue: [ ^ self ].
	self isInstalled ifTrue: [ ^ self launchSkinInitializationIn: anElement ].
	self markAsInstalled.
	self onSkinInstalledIn: anElement.
	anElement switchToSkinState: ToInstallState new.
	self launchSkinInitializationIn: anElement.

]

{ #category : #'private - installation' }
ToSkin >> launchSkinUninstallationIn: anElement [

	self isInstalled ifFalse: [ ^ self ].
	anElement dispatchLookEvent: ToUninstallLookEvent new.
	self onSkinUninstalledIn: anElement.
	self markAsNotInstalled 
]

{ #category : #'event handling' }
ToSkin >> leavedLookEvent: anEvent [


]

{ #category : #'private - installation' }
ToSkin >> markAsInitialized [

	installStep := self initializedLevel

]

{ #category : #'private - installation' }
ToSkin >> markAsInstalled [

	installStep := self installedLevel 
]

{ #category : #'private - installation' }
ToSkin >> markAsNotInstalled [

	installStep := 0
]

{ #category : #'api - install/uninstall  hook' }
ToSkin >> onSkinInstalledIn: anElement [

]

{ #category : #'api - install/uninstall  hook' }
ToSkin >> onSkinUninstalledIn: anElement [


]

{ #category : #'event handling' }
ToSkin >> openedLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> pressedLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> releasedLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> selectedLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> skinChangedEvent: anEvent [

	anEvent target switchToSkinState: ToInstallState new.
	anEvent target childrenDo: [ :child | child updateSkin ]
]

{ #category : #'event handling' }
ToSkin >> themeChangedEvent: anEvent [

	self launchSkinUninstallationIn: anEvent currentTarget.
	self launchSkinInstallationIn: anEvent currentTarget.	
	self launchSkinInitializationIn:  anEvent currentTarget.
]

{ #category : #'event handling' }
ToSkin >> uncheckedLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> uninstallLookEvent: anEvent [


]
