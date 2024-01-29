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
	target ensuredSkinManager requestInstallSkinIn: target
]

{ #category : #'api - accessing' }
ToElementInitializeEventHandler >> eventsToHandle [

	^ { BlElementAddedToSceneGraphEvent. BlElementAddedToParentEvent }
]
