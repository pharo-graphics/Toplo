Class {
	#name : #ToAnchoredWindow,
	#superclass : #ToBasicWindowElement,
	#instVars : [
		'anchor'
	],
	#category : #'Toplo-Widget-Window'
}

{ #category : #accessing }
ToAnchoredWindow >> anchor [

	^ anchor 

]

{ #category : #accessing }
ToAnchoredWindow >> anchor: aWidget [

	anchor := aWidget.
	anchor ifNil: [ ^ self ].
	self anchor
		when: BlElementPositionInSpaceChangedEvent
		do: [ :event |
		self position: self anchor bounds inSpace bounds topLeft ].
	self anchor when: BlElementRemovedFromParentEvent do: [ self close ].
	self anchor
		when: BlElementRemovedFromSceneGraphEvent
		do: [ self close ]
]

{ #category : #start }
ToAnchoredWindow >> attachTo: anElement [

	self anchor: anElement
]

{ #category : #'t - initialization dresser' }
ToAnchoredWindow >> defaultDresser [ 

	^ ToAnchoredWindowDresser new
]

{ #category : #initialization }
ToAnchoredWindow >> defaultLayout [

	^ BlFrameLayout new 
]

{ #category : #initialization }
ToAnchoredWindow >> defaultPlacementStrategy [

	^ ToAnchoredPlacementStrategy new
]

{ #category : #start }
ToAnchoredWindow >> detach [

	self close.
	self anchor: nil
]

{ #category : #initialization }
ToAnchoredWindow >> initialize [

	super initialize.
	self fitContent.
	self initializeDresser 
]

{ #category : #start }
ToAnchoredWindow >> isAttached [

	^ self anchor notNil
]
