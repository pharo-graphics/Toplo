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

	anEvent target childrenDo: [ :child | child dispatchEvent: anEvent ]
]

{ #category : #'event handling' }
ToElementSkin >> elementAddedToSceneGraphEvent: anEvent [

	look elementAddedToSceneGraphEvent: anEvent
]

{ #category : #'event handling' }
ToElementSkin >> elementRemovedFromSceneGraphEvent: anEvent [

	look elementRemovedFromSceneGraphEvent: anEvent
]

{ #category : #'api - accessing' }
ToElementSkin >> eventsToHandle [

	^ { BlElementAddedToSceneGraphEvent. BlElementRemovedFromSceneGraphEvent. ToElementStateEvent }
]

{ #category : #'api - event managing' }
ToElementSkin >> handleEvent: anEvent [

	lastEvent := anEvent.
	(anEvent isKindOf: ToElementStateEvent) ifTrue: [
		self dispatchToChildren: anEvent clone.
		^ anEvent sendTo: look ].
	super handleEvent: anEvent
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
