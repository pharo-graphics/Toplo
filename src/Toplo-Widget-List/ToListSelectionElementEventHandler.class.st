Class {
	#name : #ToListSelectionElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> addNewSelectionElements: aSelectionElementArray from: target [

	aSelectionElementArray do: [ :e |
		self addSelectionElement: e from: target ]
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> addNewSelectionElementsFrom: target [

	| newSelElements |
	newSelElements := self newSelectionElementsFrom: target.
	self addNewSelectionElements: newSelElements from: target
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> addSelectionElement: aSelectionElement from: target [

	aSelectionElement beneath
		ifTrue: [ target addBeneathSelectionElement: aSelectionElement ]
		ifFalse: [ target addOverSelectionElement: aSelectionElement ]
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> differUpdateSelectionFrom: target [

	self subclassResponsibility 
]

{ #category : #'element handlers' }
ToListSelectionElementEventHandler >> elementExtentChangedEvent: anEvent [

	self updateSelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListSelectionElementEventHandler >> elementScrolledEvent: anEvent [

	self updateSelectionFromEvent: anEvent
]

{ #category : #'api - accessing' }
ToListSelectionElementEventHandler >> eventsToHandle [

	^ {
		  BlElementExtentChangedEvent.
		  BlElementScrolledEvent }
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> newSelectionElementFrom: aTarget beneath: aBoolean [

	^ (self selectionElementClassFrom: aTarget) beneath: aBoolean 
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> newSelectionElementsFrom: target [
	" return a collection with instances of ToListPrimarySelectionElement "

	| overOption beneathOption overNodeGroups beneathNodeGroups |
	overOption := (self selectionModeFrom: target) overOption.
	beneathOption := (self selectionModeFrom: target) beneathOption.

	overNodeGroups := Array streamContents: [ :stream |
		                  overOption
			                  nextPutNodeGroupsFrom: target
			                  selectionModel: (self selectionModelFrom: target)
			                  in: stream ].
	beneathNodeGroups := Array streamContents: [ :stream |
		                     beneathOption
			                     nextPutNodeGroupsFrom: target
			                     selectionModel: (self selectionModelFrom: target)
			                     in: stream ].

	^ Array streamContents: [ :stream |
		  stream nextPutAll: (overNodeGroups collect: [ :g |
				   (self newSelectionElementFrom: target beneath: false)
					   listElement: target;
					   nodes: g;
					   yourself ]).
		  stream nextPutAll: (beneathNodeGroups collect: [ :g |
				   (self newSelectionElementFrom: target beneath: true)
					   listElement: target;
					   nodes: g;
					   yourself ]) ]
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> previousSelectionElementsFrom: aTarget [

	^ self subclassResponsibility 
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> removePreviousSelectionElementsFrom: target [
	
	| previous |
	previous := self previousSelectionElementsFrom: target.
	previous do: [ :s | s removeFromParent ].

]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> selectionElementClassFrom: aTarget [

	self subclassResponsibility 
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> selectionModeFrom: aTarget [

	^ self subclassResponsibility
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> selectionModelFrom: target [

	^ self subclassResponsibility
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> updateSelectionFromEvent: anEvent [

	|  target  |
	target := anEvent currentTarget.
	target isAttachedToSceneGraph ifFalse: [
		self differUpdateSelectionFrom: target.
		^ self ].
	self removePreviousSelectionElementsFrom: target.
	(self selectionModelFrom: target) ifEmpty: [ ^ self ].
	self addNewSelectionElementsFrom: target.
]
