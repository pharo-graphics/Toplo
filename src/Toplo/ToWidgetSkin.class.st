Class {
	#name : #ToWidgetSkin,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'styleSheet',
		'look',
		'installStep',
		'childSkinsIndex'
	],
	#category : #'Toplo-Core-Theme-skins'
}

{ #category : #adding }
ToWidgetSkin >> addLook: aLook [

	aLook isNull ifTrue: [ ^ self ].
	aLook next: look.
	self privateLook: aLook
]

{ #category : #'api - accessing' }
ToWidgetSkin >> childSkinForSlotNamed: aSymbol [

	^ childSkinsIndex at: aSymbol ifAbsent: [  ]
]

{ #category : #'event handling' }
ToWidgetSkin >> childSkinsDirtyEvent: anEvent [
	""

	self childSkinsIndex keysAndValuesDo: [ :k :subSkin |
		subSkin updateIn: anEvent target ]
]

{ #category : #'api - accessing' }
ToWidgetSkin >> childSkinsIndex [

	" built in #initializePropertiesIndex "
	^ childSkinsIndex 
]

{ #category : #'api - accessing' }
ToWidgetSkin >> childSkinsToHandle [

	" to be redefined by subclasses to declare how to manage the element properties skins "
	" each element is ToSubSkin "
	^ { }
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> defaultCursorLookIn: anElement [

	^ ToMouseCursorLook new
]

{ #category : #accessing }
ToWidgetSkin >> dispatchChangedEventIn: anElement [

	"DefaultType, PrimaryType, LinkType or TextType "
	self markAsNotInstalled.
	anElement dispatchChildSkinsDirtyEvent
]

{ #category : #'event handling' }
ToWidgetSkin >> elementLookEvent: anEvent [

	anEvent sendTo: self look
]

{ #category : #'api - accessing' }
ToWidgetSkin >> eventsToHandle [

	^ {
		  ToThemeChangedEvent.
		  ToChildSkinsDirtyEvent.
		  ToSkinnablePropertyChangedEvent.
		  ToElementLookEvent.
		  ToLayoutOrientationChangedEvent.
		  ToLayoutDirectionChangedEvent }
]

{ #category : #initialization }
ToWidgetSkin >> initialize [

	super initialize.
	self markAsNotInstalled.
	self privateLook: ToNullElementLook new.
	self initializeChildSkinsIndex 
	
]

{ #category : #initialization }
ToWidgetSkin >> initializeChildSkinsIndex [

	childSkinsIndex := IdentityDictionary new.
	self childSkinsToHandle do: [ :childSkin |
		self registerChildSkin: childSkin ]
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

{ #category : #'event handling' }
ToWidgetSkin >> layoutDirectionChangedEvent: anEvent [
]

{ #category : #'event handling' }
ToWidgetSkin >> layoutOrientationChangedEvent: anEvent [
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

	self addLook: (self defaultCursorLookIn: anElement)
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

{ #category : #'api - accessing' }
ToWidgetSkin >> registerChildSkin: aChildSkin [ 

	childSkinsIndex at: aChildSkin slotName put: aChildSkin
]

{ #category : #removing }
ToWidgetSkin >> removeLook: aLook [

	look = aLook 
		ifTrue: [ look := look next ]
		ifFalse: [ look removeLook: aLook previous: nil ]
]

{ #category : #'event handling' }
ToWidgetSkin >> skinnablePropertyChangedEvent: anEvent [

	self
		updateSkinIn: anEvent holder
		slotNamed: anEvent slotName
		value: anEvent current
]

{ #category : #accessing }
ToWidgetSkin >> styleSheet: aStyleSheet [

	styleSheet := aStyleSheet
]

{ #category : #'event handling' }
ToWidgetSkin >> themeChangedEvent: anEvent [

	self launchSkinUninstallationIn: anEvent currentTarget.
	self launchSkinInstallationIn: anEvent currentTarget.	
	self launchSkinInitializationIn:  anEvent currentTarget.
]

{ #category : #'api - accessing' }
ToWidgetSkin >> unregisterChildSkinForSlotNamed: aSymbol [

	childSkinsIndex removeKey: aSymbol ifAbsent: [  ]
]

{ #category : #'event handling' }
ToWidgetSkin >> updateSkinIn: anElement slotNamed: aSlotName value: aSkinable [

	" update the child skin :  
	- anElement is the element which has myself as its current skin.
	- aValuable is the declared builder (see #initializeSubSkinsIndex).
	- aSkinable is the current value (an element) of the property"
	| subSkin |
	aSkinable ifNil: [ ^ self ].
	subSkin := self childSkinForSlotNamed: aSlotName.
	subSkin ifNil: [ ^ self ].
	subSkin updateIn: anElement
]
