Class {
	#name : #ToElementInitializeEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Core'
}

{ #category : #'event handling' }
ToElementInitializeEventHandler >> elementAddedToParentEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target parent isDisabled ifTrue: [ target enabled: false ]
]

{ #category : #'event handling' }
ToElementInitializeEventHandler >> elementAddedToSceneGraphEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target requestInstallSkin.
	(target eventDispatcher hasEventHandlerSuchThat: [ :eh |
		 eh isKindOf: ToSkinStateGenerator ]) ifFalse: [
		target addEventHandler: ToSkinStateGenerator new ]
]

{ #category : #'api - accessing' }
ToElementInitializeEventHandler >> eventsToHandle [

	^ { BlElementAddedToSceneGraphEvent. BlElementAddedToParentEvent }
]
