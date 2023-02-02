Class {
	#name : #ToAnchoredWindow,
	#superclass : #ToBasicAnimatedWindow,
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
	self anchor when: BlElementPositionInSpaceChangedEvent do: [ :event | 
		self relocate: self anchor bounds inSpace bounds topLeft ].
	self anchor when: BlElementRemovedFromParentEvent do: [ self close ].
	self anchor when: BlElementRemovedFromSceneGraphEvent do: [ self close ].
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

{ #category : #initialization }
ToAnchoredWindow >> initialize [

	super initialize.
	self fitContent.
	self initializeDresser 
]
