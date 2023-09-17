Class {
	#name : #ToSkin,
	#superclass : #BlCustomEventHandler,
	#traits : 'TToLookEventSubscriptionsHolder',
	#classTraits : 'TToLookEventSubscriptionsHolder classTrait',
	#instVars : [
		'installStep',
		'subscriptions'
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

	self subscriptions do: [ :s | s receiveEvent: anEvent  ]
]

{ #category : #'api - accessing' }
ToSkin >> eventsToHandle [

	^ {
		  ToThemeChangedEvent.
		  ToSkinChangedEvent.
		  ToPropertyChangedEvent.
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
	subscriptions := #(  )
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
	anElement switchToSkinState: ToInitialState new
]

{ #category : #'private - installation' }
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

{ #category : #'event handling' }
ToSkin >> propertyChangedEvent: anEvent [

]

{ #category : #'t - look event subscription holder - accessing' }
ToSkin >> rawSubscriptions [

	^ subscriptions
]

{ #category : #'t - look event subscription holder - accessing' }
ToSkin >> rawSubscriptions: anArray [

	subscriptions := anArray
]

{ #category : #'event handling' }
ToSkin >> skinChangedEvent: anEvent [

	anEvent target childrenDo: [ :child | child updateSkin ]
]

{ #category : #'event handling' }
ToSkin >> themeChangedEvent: anEvent [

	self launchSkinUninstallationIn: anEvent currentTarget.
	self launchSkinInstallationIn: anEvent currentTarget.	
	self launchSkinInitializationIn:  anEvent currentTarget.
]
