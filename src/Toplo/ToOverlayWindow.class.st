Class {
	#name : #ToOverlayWindow,
	#superclass : #ToBasicWindowElement,
	#instVars : [
		'overlayed'
	],
	#category : #'Toplo-Widget-Window'
}

{ #category : #'t - initialization dresser' }
ToOverlayWindow >> defaultDresser [ 

	^ ToOverlayWindowDresser new
]

{ #category : #initialization }
ToOverlayWindow >> defaultPlacementStrategy [

	^ ToOverlayedPlacementStrategy new
]

{ #category : #initialization }
ToOverlayWindow >> initialize [

	super initialize.
	self initializeDresser 
]

{ #category : #accessing }
ToOverlayWindow >> overlayed [

	^ overlayed 

]

{ #category : #accessing }
ToOverlayWindow >> overlayed: aWidget [

	overlayed := aWidget.
	self overlayed
		when: BlElementPositionInSpaceChangedEvent
		do: [ :event |
			self position: self overlayed bounds inSpace bounds topLeft ].
	self overlayed
		when: BlElementExtentChangedEvent
		do: [ self size: self overlayed size ].
	self overlayed
		when: BlElementRemovedFromParentEvent
		do: [ self close ].
	self overlayed
		when: BlElementRemovedFromSceneGraphEvent
		do: [ self close ]
]
