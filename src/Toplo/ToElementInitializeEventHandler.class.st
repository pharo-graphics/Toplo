Class {
	#name : #ToElementInitializeEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'addedToSceneGraph'
	],
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
	addedToSceneGraph ifTrue: [ ^ self ].
	addedToSceneGraph := true.
	target := anEvent currentTarget.
	target requestNewConfiguration.
	target spaceDo: [ :sp |
		sp checkToploPhases.
		sp needInnerConfigurationPass: true ].
	target ensuredSkinManager requestInstallSkinIn: target
]

{ #category : #'event handling' }
ToElementInitializeEventHandler >> elementRemovedFromSceneGraphEvent: anEvent [

	addedToSceneGraph := false
]

{ #category : #'api - accessing' }
ToElementInitializeEventHandler >> eventsToHandle [

	^ {
		  BlElementAddedToSceneGraphEvent.
		  BlElementRemovedFromSceneGraphEvent.
		  BlElementAddedToParentEvent }
]

{ #category : #'api - hooks' }
ToElementInitializeEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	addedToSceneGraph := false
]
