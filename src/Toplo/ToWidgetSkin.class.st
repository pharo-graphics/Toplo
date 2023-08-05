Class {
	#name : #ToWidgetSkin,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'element',
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
ToWidgetSkin >> elementLookEvent: anEvent [

	anEvent sendTo: self look
]

{ #category : #'event handling' }
ToWidgetSkin >> elementSkinChangedEvent: anEvent [

	"self launchSkinInstallationIn: anEvent currentTarget"
]

{ #category : #'api - accessing' }
ToWidgetSkin >> eventsToHandle [

	^ {
		  ToThemeChangedEvent.
		  ToElementSkinChangedEvent.
		  ToPropertyValueChangedEvent.
		  ToPropertySkinChangedEvent.
		  ToElementLookEvent }
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

{ #category : #'event handling' }
ToWidgetSkin >> propertySkinChangedEvent: anEvent [

	self updateSkinInProperty: anEvent current named: anEvent propertyName
]

{ #category : #'event handling' }
ToWidgetSkin >> propertyValueChangedEvent: anEvent [

	self updateSkinInProperty: anEvent current named: anEvent propertyName
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

{ #category : #'event handling' }
ToWidgetSkin >> updateSkinInProperty: aSkinable named: aString [

	| skinSelector |
	skinSelector := String streamContents: [ :s |
		                s nextPutAll: aString.
		                s nextPutAll: 'Skin' ].
	aSkinable withSkin: (self perform: skinSelector asSymbol)
]
