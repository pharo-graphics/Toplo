Class {
	#name : #ToElementSkin,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'look',
		'lastEvent',
		'recursive'
	],
	#category : #'Toplo-Theme-Skins'
}

{ #category : #accessing }
ToElementSkin >> addAllLooks: aCollection [

	aCollection do: [ :l | self addLook: l ]
]

{ #category : #accessing }
ToElementSkin >> addLook: aLook [

	aLook next: look.
	self privateLook: aLook	
]

{ #category : #dispatching }
ToElementSkin >> dispatchToChildren: anEvent [

	self recursive ifFalse: [ ^ self ].
	anEvent target childrenDo: [ :child | child dispatchEvent: anEvent ]
]

{ #category : #'event handling' }
ToElementSkin >> elementAddedToSceneGraphEvent: anEvent [

	anEvent target dispatchEvent: (ToInstallLookEvent new copyFrom: anEvent)
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
		self dispatchToChildren: anEvent clone.
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
	self privateLook: ToNullElementLook new.
	Toplo useLookAndFeel ifFalse: [ self addLook: anElement defaultLook ].
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
ToElementSkin >> recursive [

	^ recursive ifNil: [ recursive := false ]
]

{ #category : #accessing }
ToElementSkin >> recursive: anObject [

	recursive := anObject
]
