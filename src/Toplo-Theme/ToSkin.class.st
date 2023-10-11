Class {
	#name : #ToSkin,
	#superclass : #BlCustomEventHandler,
	#traits : 'TToPropertyWriterHolder',
	#classTraits : 'TToPropertyWriterHolder classTrait',
	#instVars : [
		'installStep',
		'writers'
	],
	#category : #'Toplo-Theme-Skin'
}

{ #category : #'event handling' }
ToSkin >> dispatchChangedEventIn: anElement [

	self markAsNotInstalled.
	anElement dispatchSkinChangedEvent
]

{ #category : #'event handling' }
ToSkin >> elementLookEvent: anEvent [

	self writers do: [ :s | s receiveEvent: anEvent  ]
]

{ #category : #'api - accessing' }
ToSkin >> eventsToHandle [

	^ {
		  ToThemeChangedEvent.
		  ToSkinChangedEvent.
		  ToElementLookEvent }
]

{ #category : #'private - installation' }
ToSkin >> forceInstallationIn: anElement [

	self markAsNotInstalled.
	anElement dispatchSkinChangedEvent
]

{ #category : #initialization }
ToSkin >> initialize [

	super initialize.
	self markAsNotInstalled.
	writers := #(  )
]

{ #category : #'private - installation' }
ToSkin >> initializedLevel [

	^ 2

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

{ #category : #'t - property writer holder - accessing' }
ToSkin >> rawWriters [

	^ writers
]

{ #category : #'t - property writer holder - accessing' }
ToSkin >> rawWriters: aPropertyWriterCollection [

	writers := aPropertyWriterCollection asArray
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
