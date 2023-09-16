Class {
	#name : #ToWidgetSkin,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'installStep',
		'firstLookUpdater'
	],
	#category : #'Toplo-Theme-Skin'
}

{ #category : #adding }
ToWidgetSkin >> addAllLookUpdaters: aCollectionOfLook [

	aCollectionOfLook do: [ :l | self addLookUpdater: l ]
]

{ #category : #adding }
ToWidgetSkin >> addLookUpdater: aLook [

	aLook isNull ifTrue: [ ^ self ].
	aLook next: firstLookUpdater.
	self privateLookUpdater: aLook
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> defaultCursorLookIn: anElement [

	^ ToLookUpdater new 
]

{ #category : #accessing }
ToWidgetSkin >> dispatchChangedEventIn: anElement [

	self markAsNotInstalled.
	anElement dispatchSkinChangedEvent
]

{ #category : #'event handling' }
ToWidgetSkin >> elementLookEvent: anEvent [

	anEvent sendTo: self firstLookUpdater
]

{ #category : #'api - accessing' }
ToWidgetSkin >> eventsToHandle [

	^ {
		  ToThemeChangedEvent.
		  ToSkinChangedEvent.
		  ToPropertyChangedEvent.
		  ToElementLookEvent.
		  ToLayoutOrientationChangedEvent.
		  ToLayoutDirectionChangedEvent }
]

{ #category : #accessing }
ToWidgetSkin >> firstLookUpdater [

	^ firstLookUpdater
]

{ #category : #accessing }
ToWidgetSkin >> forceInstallationIn: anElement [

	self markAsNotInstalled.
	anElement dispatchSkinChangedEvent
]

{ #category : #initialization }
ToWidgetSkin >> initialize [

	super initialize.
	self markAsNotInstalled.
	self privateLookUpdater: ToNullElementLook new
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> initializedLevel [

	^ 2

]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> installedLevel [

	^ 1
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> isInitialized [

	^ installStep >= self initializedLevel 
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> isInstalled [

	^ installStep >= self installedLevel 
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> launchSkinInitializationIn: anElement [

	self isInitialized ifTrue: [ ^ self ].
	self markAsInitialized.
	anElement isDisabled ifTrue: [ ^ anElement switchToSkinState: ToDisabledState new ].
	anElement switchToSkinState: ToInitialState new
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> launchSkinInstallationIn: anElement [

	self isInitialized ifTrue: [ ^ self ].
	self isInstalled ifTrue: [ ^ self launchSkinInitializationIn: anElement ].
	self markAsInstalled.
	self onSkinInstalledIn: anElement.
	anElement switchToSkinState: ToInstallState new.
	self launchSkinInitializationIn: anElement.

]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> launchSkinUninstallationIn: anElement [

	self isInstalled ifFalse: [ ^ self ].
	anElement dispatchLookEvent: ToUninstallLookEvent new.
	self onSkinUninstalledIn: anElement.
	self privateLookUpdater: ToNullElementLook new.
	self markAsNotInstalled 
]

{ #category : #'event handling' }
ToWidgetSkin >> layoutDirectionChangedEvent: anEvent [
]

{ #category : #'event handling' }
ToWidgetSkin >> layoutOrientationChangedEvent: anEvent [
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> markAsInitialized [

	installStep := self initializedLevel

]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> markAsInstalled [

	installStep := self installedLevel 
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> markAsNotInstalled [

	installStep := 0
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> onSkinInstalledIn: anElement [

]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> onSkinUninstalledIn: anElement [

	firstLookUpdater := nil
]

{ #category : #'private - accessing' }
ToWidgetSkin >> privateLookUpdater: aLook [

	firstLookUpdater := aLook
]

{ #category : #'event handling' }
ToWidgetSkin >> propertyChangedEvent: anEvent [

]

{ #category : #removing }
ToWidgetSkin >> removeLookUpdater: aLook [

	firstLookUpdater = aLook 
		ifTrue: [ firstLookUpdater := firstLookUpdater next ]
		ifFalse: [ firstLookUpdater removeLook: aLook previous: nil ]
]

{ #category : #'event handling' }
ToWidgetSkin >> skinChangedEvent: anEvent [

	anEvent target childrenDo: [ :child | child updateSkin ]
]

{ #category : #'event handling' }
ToWidgetSkin >> themeChangedEvent: anEvent [

	self launchSkinUninstallationIn: anEvent currentTarget.
	self launchSkinInstallationIn: anEvent currentTarget.	
	self launchSkinInitializationIn:  anEvent currentTarget.
]
