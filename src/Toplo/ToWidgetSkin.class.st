Class {
	#name : #ToWidgetSkin,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'look',
		'installed',
		'initialized'
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
	installed := false.
	initialized := false.
	self privateLook: ToNullElementLook new.
	
]

{ #category : #accessing }
ToWidgetSkin >> initialized [

	^ initialized 
]

{ #category : #accessing }
ToWidgetSkin >> installed [

	^ installed
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> launchSkinInitializationIn: anElement [

	| state |
	initialized ifTrue: [ ^ self ].
	state := anElement currentSkinState ifNil: [ ToInitialState new ].
	anElement switchToSkinState: state.
	initialized := true.

]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> launchSkinInstallationIn: anElement [

	installed ifTrue: [ ^ self launchSkinInitializationIn: anElement ].
	installed := true.
	self privateLook: ToNullElementLook new.
	self onSkinInstalledIn: anElement.
	anElement dispatchLookEvent: ToInstallLookEvent new
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> launchSkinUninstallationIn: anElement [
	installed ifFalse: [ ^ self ].
	anElement dispatchLookEvent: ToUninstallLookEvent new.
	self onSkinUninstalledIn: anElement.
	self privateLook: ToNullElementLook new.
	installed := false.
	initialized := false

]

{ #category : #accessing }
ToWidgetSkin >> look [

	^ look
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
