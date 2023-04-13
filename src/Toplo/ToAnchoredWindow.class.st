Class {
	#name : #ToAnchoredWindow,
	#superclass : #ToBasicWindowElement,
	#instVars : [
		'anchor',
		'hook'
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
		self position: (self hook value: self value: event) ].
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
ToAnchoredWindow >> defaultHook [

	^ [ :w :event | w anchor bounds inSpace bounds topLeft ]
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

{ #category : #accessing }
ToAnchoredWindow >> hook [

	^ hook
]

{ #category : #accessing }
ToAnchoredWindow >> hook: aValuable [
	" takes the window as argument. Computes the window position according to the given window anchor element "
	
	hook := aValuable
]

{ #category : #initialization }
ToAnchoredWindow >> initialize [

	super initialize.
	self fitContent.
	hook := self defaultHook.
	self initializeDresser 
]

{ #category : #start }
ToAnchoredWindow >> isAttached [

	^ self anchor notNil
]
