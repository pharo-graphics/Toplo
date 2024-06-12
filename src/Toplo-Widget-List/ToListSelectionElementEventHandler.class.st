Class {
	#name : #ToListSelectionElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'previousSelectionBounds'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> addNewSelectionElement: aSelElement withAnimationFrom: aTarget [

	| targetBounds anim |
	targetBounds := aSelElement boundsFromNodes.
	aSelElement position: previousSelectionBounds origin.
	aSelElement size: previousSelectionBounds extent.
	anim := ToBoundsTransition new
		        from: previousSelectionBounds;
		        to: targetBounds;
		        duration: aSelElement option animationDuration;
		        onStepDo: [ :anArray :target |
			        aSelElement position: anArray origin.
			        aSelElement size: anArray extent ].
	anim onFinishedDo: [
		aSelElement position: targetBounds position.
		aSelElement size: targetBounds extent ].
	aSelElement addAnimation: anim.
	self addSelectionElement: aSelElement from: aTarget
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> addNewSelectionElements: aSelectionElementArray from: target [

	aSelectionElementArray do: [ :e |
		self addSelectionElement: e from: target ]
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> addNewSelectionElementsFrom: target [

	| newSelElements |
	newSelElements := self newSelectionElementsFrom: target.
	(self canAnimateNewSelectionWith: newSelElements)
		ifTrue: [
			self
				addNewSelectionElement: newSelElements first
				withAnimationFrom: target ]
		ifFalse: [
		self addNewSelectionElements: newSelElements from: target ].

	newSelElements ifEmpty: [
		previousSelectionBounds := nil.
		^ self ].
	previousSelectionBounds := newSelElements first boundsFromNodes
		                           merge:
		                           newSelElements last boundsFromNodes
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> addSelectionElement: aSelectionElement from: target [

	aSelectionElement beneath
		ifTrue: [ target addBeneathSelectionElement: aSelectionElement ]
		ifFalse: [ target addOverSelectionElement: aSelectionElement ]
]

{ #category : #testing }
ToListSelectionElementEventHandler >> canAnimateNewSelectionWith: aSelectionElementArray [
	" a selection transition animation can occur only from one node to one another node.
	- the animation is not possible in case of several selected nodes
	- the animate option must be on  "

	| newSelectionElement |
	previousSelectionBounds ifNil: [ ^ false ].
	aSelectionElementArray ifEmpty: [ ^ false ].
	newSelectionElement := aSelectionElementArray first.
	newSelectionElement option animate ifFalse: [ ^ false ].
	aSelectionElementArray size = 1 ifFalse: [ ^ false ].

	^ true
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> differUpdateSelectionFrom: target [

	self subclassResponsibility 
]

{ #category : #'element handlers' }
ToListSelectionElementEventHandler >> elementExtentChangedEvent: anEvent [

	previousSelectionBounds := nil.
	self updateSelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListSelectionElementEventHandler >> elementScrolledEvent: anEvent [

	anEvent delta isZero ifTrue: [ ^ self ].
	previousSelectionBounds := nil.
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
	previous := self previousSelectionElementsFrom:
		                             target.
	previous do: [ :s | s removeFromParent ]
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
