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
	target applyConfiguration.
	target ensuredSkinManager requestUninstallSkinIn: target.
	target ensuredSkinManager requestInstallSkinIn: target.
	target space checkToploPhases.
	target dispatchEvent: ToAddedToSpaceEvent new
]

{ #category : #'event handling' }
ToElementInitializeEventHandler >> elementRemovedFromSceneGraphEvent: anEvent [

	addedToSceneGraph := false.
	anEvent currentTarget dispatchEvent: ToRemovedFromSpaceEvent new.
	" Just set a skin uninstaller when I'm removed from space. 
	The skin will be actually uninstalled if I'm added back to a space "
	anEvent currentTarget skinManagerDo: [ :sm |
			sm resetSkinRequestCount.
			"sm requestUninstallSkinIn: self" ]
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
