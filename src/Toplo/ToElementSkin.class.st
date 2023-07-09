Class {
	#name : #ToElementSkin,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'look',
		'lastEvent'
	],
	#category : #'Toplo-Theme-Skins'
}

{ #category : #accessing }
ToElementSkin >> addLook: aLook [

	aLook isNull ifTrue: [ ^ self ].
	aLook addedInSkin: self
]

{ #category : #accessing }
ToElementSkin >> addLookDecorator: aLook [

	aLook next: look.
	self privateLook: aLook
	

]

{ #category : #dispatching }
ToElementSkin >> dispatchToSubSkins: anEvent [

	self subSkins do: [ :skin | | evt |
		evt := anEvent clone.
		(skin target value: evt) dispatchEvent: evt]
]

{ #category : #'event handling' }
ToElementSkin >> elementAddedToSceneGraphEvent: anEvent [

	anEvent target dispatchEvent: (ToInstallLookEvent new copyFrom: anEvent).
	anEvent target dispatchEvent: (ToInitialLookEvent new copyFrom: anEvent)
]

{ #category : #'event handling' }
ToElementSkin >> elementRemovedFromSceneGraphEvent: anEvent [

	anEvent currentTarget dispatchEvent: (ToUninstallLookEvent new copyFrom: anEvent)
]

{ #category : #'api - accessing' }
ToElementSkin >> eventsToHandle [

	^ { BlElementAddedToSceneGraphEvent. BlElementRemovedFromSceneGraphEvent. ToElementLookEvent }
]

{ #category : #'api - event managing' }
ToElementSkin >> handleEvent: anEvent [

	lastEvent class = anEvent class ifTrue: [ ^ self ].
	lastEvent := anEvent.
	(anEvent isKindOf: ToElementLookEvent) ifTrue: [
		^ anEvent sendTo: look ].
	super handleEvent: anEvent
]

{ #category : #initialization }
ToElementSkin >> initialize [

	super initialize.
	self privateLook: ToNullElementLook new
]

{ #category : #accessing }
ToElementSkin >> look [

	^ look
]

{ #category : #'api - install/uninstall  hook' }
ToElementSkin >> onInstalledIn: anElement [

	self flag: 'For first version compatibility for now '.
	self addLook: anElement defaultLook.
	super onInstalledIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToElementSkin >> onUninstalledIn: anElement [

	look := nil.
	super onUninstalledIn: anElement
	
]

{ #category : #'private - accessing' }
ToElementSkin >> privateLook: aLook [

	look := aLook.
	look updateFirstWith: look.
]

{ #category : #accessing }
ToElementSkin >> setMainLook: aLook [

	self look isNull ifTrue: [
		aLook next: self look.
		^ self privateLook: aLook ].
	aLook setAsMainLookIn: self current: self look previous: nil
]
