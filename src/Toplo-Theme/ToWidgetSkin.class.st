Class {
	#name : #ToWidgetSkin,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'installStep',
		'childSkinsIndex',
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

	^ ToLookUpdater new 
]

{ #category : #accessing }
ToWidgetSkin >> dispatchChangedEventIn: anElement [

	"DefaultType, PrimaryType, LinkType or TextType "
	self markAsNotInstalled.
	anElement dispatchChildSkinsDirtyEvent
]

{ #category : #'event handling' }
ToWidgetSkin >> elementLookEvent: anEvent [

	anEvent sendTo: self firstLookUpdater
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

{ #category : #'api - accessing' }
ToWidgetSkin >> findLookUpdaterForPropertyNamed: aName [

	^ self firstLookUpdater findLookUpdaterForPropertyNamed: aName
]

{ #category : #accessing }
ToWidgetSkin >> firstLookUpdater [

	^ firstLookUpdater
]

{ #category : #initialization }
ToWidgetSkin >> initialize [

	super initialize.
	self markAsNotInstalled.
	self privateLookUpdater: ToNullElementLook new.
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
ToWidgetSkin >> onInstalledIn: anElement [

	super onInstalledIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> onSkinInstalledIn: anElement [

	self addLookUpdater: (self defaultCursorLookIn: anElement)
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> onSkinUninstalledIn: anElement [


]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	firstLookUpdater := nil
]

{ #category : #'private - accessing' }
ToWidgetSkin >> privateLookUpdater: aLook [

	firstLookUpdater := aLook
]

{ #category : #'api - accessing' }
ToWidgetSkin >> registerChildSkin: aChildSkin [ 

	childSkinsIndex at: aChildSkin slotName put: aChildSkin
]

{ #category : #removing }
ToWidgetSkin >> removeLookUpdater: aLook [

	firstLookUpdater = aLook 
		ifTrue: [ firstLookUpdater := firstLookUpdater next ]
		ifFalse: [ firstLookUpdater removeLook: aLook previous: nil ]
]

{ #category : #'event handling' }
ToWidgetSkin >> skinnablePropertyChangedEvent: anEvent [

	self
		updateSkinIn: anEvent holder
		slotNamed: anEvent slotName
		value: anEvent current
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
