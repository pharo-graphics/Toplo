Class {
	#name : #ToWidgetSkin,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'look',
		'installStep'
	],
	#category : #'Toplo-Core-Theme'
}

{ #category : #adding }
ToWidgetSkin >> addLook: aLook [

	aLook isNull ifTrue: [ ^ self ].
	aLook next: look.
	self privateLook: aLook
]

{ #category : #'event handling' }
ToWidgetSkin >> elementAddedToSceneGraphEvent: anEvent [

	self whenAddedToSpace: anEvent in: anEvent currentTarget
]

{ #category : #'event handling' }
ToWidgetSkin >> elementLookEvent: anEvent [

	anEvent sendTo: self look
]

{ #category : #'event handling' }
ToWidgetSkin >> elementRemovedFromSceneGraphEvent: anEvent [

	self whenRemovedFromSpace: anEvent in: anEvent currentTarget
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> elementSkinChangedEvent: anEvent [

	self launchSkinUninstallationIn: anEvent target
]

{ #category : #'api - accessing' }
ToWidgetSkin >> eventsToHandle [

	^ { ToThemeChangedEvent. ToElementSkinChangedEvent. BlElementAddedToSceneGraphEvent. BlElementRemovedFromSceneGraphEvent . ToElementLookEvent }
]

{ #category : #initialization }
ToWidgetSkin >> initialize [

	super initialize.
	self markAsNotInstalled.
	self privateLook: ToNullElementLook new.
	
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

	| state |
	self isInitialized ifTrue: [ ^ self ].
	self markAsInitialized.
	state := anElement currentSkinState ifNil: [ ToInitialState new ].
	anElement switchToSkinState: state.

]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> launchSkinInstallationIn: anElement [

	self isInitialized ifTrue: [ ^ self ].
	self isInstalled ifTrue: [ ^ self launchSkinInitializationIn: anElement ].
	self markAsInstalled.
	self privateLook: ToNullElementLook new.
	self onSkinInstalledIn: anElement.
	anElement dispatchLookEvent: ToInstallLookEvent new
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> launchSkinUninstallationIn: anElement [

	self isInstalled ifFalse: [ ^ self ].
	anElement dispatchLookEvent: ToUninstallLookEvent new.
	self onSkinUninstalledIn: anElement.
	self privateLook: ToNullElementLook new.
	self markAsNotInstalled 
]

{ #category : #accessing }
ToWidgetSkin >> look [

	^ look
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

{ #category : #initialization }
ToWidgetSkin >> notInstalledMark [

	^ #notInstalled
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> onInstalledIn: anElement [

	super onInstalledIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> onSkinInstalledIn: anElement [



]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> onSkinUninstalledIn: anElement [


]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	look := nil
]

{ #category : #'private - accessing' }
ToWidgetSkin >> privateLook: aLook [

	look := aLook
]

{ #category : #removing }
ToWidgetSkin >> removeLook: aLook [

	look = aLook 
		ifTrue: [ look := look next ]
		ifFalse: [ look removeLook: aLook previous: nil ]
]

{ #category : #'event handling' }
ToWidgetSkin >> themeChangedEvent: anEvent [

	self launchSkinUninstallationIn: anEvent currentTarget
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> whenAddedToSpace: anEvent in: anElement [

	"self launchSkinInstallationIn: anElement"

]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> whenRemovedFromSpace: anEvent in: anElement [

	"self launchSkinUninstallationIn: anElement.
	installed := false.
	initialized := false"

]
