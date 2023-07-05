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
	look := aLook
]

{ #category : #dispatching }
ToElementSkin >> dispatchToChildren: anEvent [

	self recursive ifFalse: [ ^ self ].
	anEvent target childrenDo: [ :child | child dispatchEvent: anEvent ]
]

{ #category : #'event handling' }
ToElementSkin >> elementAddedToSceneGraphEvent: anEvent [

	anEvent target dispatchEvent: (ToInstallStateEvent new copyFrom: anEvent)
]

{ #category : #'event handling' }
ToElementSkin >> elementRemovedFromSceneGraphEvent: anEvent [

	anEvent currentTarget dispatchEvent: (ToUninstallStateEvent new copyFrom: anEvent)
]

{ #category : #'api - accessing' }
ToElementSkin >> eventsToHandle [

	^ { BlElementAddedToSceneGraphEvent. BlElementRemovedFromSceneGraphEvent. ToElementStateEvent }
]

{ #category : #'api - event managing' }
ToElementSkin >> handleEvent: anEvent [

	lastEvent class = anEvent class ifTrue: [ ^ self ].
	lastEvent := anEvent.
	(anEvent isKindOf: ToElementStateEvent) ifTrue: [
		self dispatchToChildren: anEvent clone.
		^ anEvent sendTo: look ].
	super handleEvent: anEvent
]

{ #category : #testing }
ToElementSkin >> hasBackground [

	^ look hasBackground
]

{ #category : #accessing }
ToElementSkin >> look [

	^ look
]

{ #category : #'api - install/uninstall  hook' }
ToElementSkin >> onInstalledIn: anElement [

	self flag: 'For first version compatibility for now '.
	look := ToNullElementLook new.
	Toplo useLookAndFeel ifFalse: [ look := anElement defaultLook ].
	super onInstalledIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToElementSkin >> onUninstalledIn: anElement [

	look := nil.
	super onUninstalledIn: anElement
	
]

{ #category : #accessing }
ToElementSkin >> recursive [

	^ recursive ifNil: [ recursive := false ]
]

{ #category : #accessing }
ToElementSkin >> recursive: anObject [

	recursive := anObject
]

{ #category : #accessing }
ToElementSkin >> setLook: aLook [

	look := aLook
]
