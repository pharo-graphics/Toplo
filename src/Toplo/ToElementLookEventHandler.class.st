Class {
	#name : #ToElementLookEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'look',
		'lastEvent'
	],
	#category : #'Toplo-Core-Theme-Skins'
}

{ #category : #accessing }
ToElementLookEventHandler >> addLook: aLook [

	aLook isNull ifTrue: [ ^ self ].
	aLook next: look.
	self privateLook: aLook.
	look updateFirstWith: look.
]

{ #category : #'event handling' }
ToElementLookEventHandler >> elementAddedToSceneGraphEvent: anEvent [

	anEvent target dispatchEvent: (ToInstallLookEvent new copyFrom: anEvent).
	anEvent target dispatchEvent: (ToInitialLookEvent new copyFrom: anEvent)
]

{ #category : #'event handling' }
ToElementLookEventHandler >> elementRemovedFromSceneGraphEvent: anEvent [

	anEvent currentTarget dispatchEvent: (ToUninstallLookEvent new copyFrom: anEvent)
]

{ #category : #'api - accessing' }
ToElementLookEventHandler >> eventsToHandle [

	^ { BlElementAddedToSceneGraphEvent. BlElementRemovedFromSceneGraphEvent. ToElementLookEvent }
]

{ #category : #'api - event managing' }
ToElementLookEventHandler >> handleEvent: anEvent [

	lastEvent class = anEvent class ifTrue: [ ^ self ].
	lastEvent := anEvent.
	(anEvent isKindOf: ToElementLookEvent) ifTrue: [
		^ anEvent sendTo: look ].
	super handleEvent: anEvent
]

{ #category : #initialization }
ToElementLookEventHandler >> initialize [

	super initialize.
	self privateLook: ToNullElementLook new
]

{ #category : #accessing }
ToElementLookEventHandler >> look [

	^ look
]

{ #category : #'api - install/uninstall  hook' }
ToElementLookEventHandler >> onInstalledIn: anElement [

	self flag: 'For first version compatibility for now '.
	super onInstalledIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToElementLookEventHandler >> onUninstalledIn: anElement [

	look := nil.
	super onUninstalledIn: anElement
	
]

{ #category : #'private - accessing' }
ToElementLookEventHandler >> privateLook: aLook [

	look := aLook
]

{ #category : #accessing }
ToElementLookEventHandler >> removeLook: aLook [

	look = aLook 
		ifTrue: [ look := look next ]
		ifFalse: [ look removeLook: aLook previous: nil ].
	look updateFirstWith: look.
]
