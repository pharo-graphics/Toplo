Class {
	#name : #ToListSelectionElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'previousSelectionElements'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> addNewSelectionElement: aSelElement withAnimationFrom: aTarget [

	| targetBounds fromBounds anim prevSelectionElement |
	prevSelectionElement := previousSelectionElements first.
	fromBounds := prevSelectionElement boundsFromNodes.
	targetBounds := aSelElement boundsFromNodes.
	aSelElement position: prevSelectionElement position.
	aSelElement size: prevSelectionElement size.
	self addSelectionElement: aSelElement from: aTarget.
	anim := ToBoundsTransition new
		        from: fromBounds;
		        to: targetBounds;
		        duration: aSelElement option animationDuration;
		        onStepDo: [ :anArray :target |
			        aSelElement position: anArray origin.
			        aSelElement size: anArray extent ].
	anim onFinishedDo: [
		aSelElement position: targetBounds position.
		aSelElement size: targetBounds extent ].
	aSelElement addAnimation: anim
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
		self addNewSelectionElements: newSelElements from: target ]
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
	- the previous and the new selection element should cover different nodes
	- the animate option must be on  "

	| prevSelectionElement newSelectionElement |
	previousSelectionElements ifNil: [ ^ false ].
	previousSelectionElements size = 1 ifFalse: [ ^ false ].
	prevSelectionElement := previousSelectionElements first.
	prevSelectionElement option animate ifFalse: [ ^ false ].
	(prevSelectionElement nodes anySatisfy: [ :node |
		 node isAttachedToSceneGraph not ]) ifTrue: [ ^ false ].

	aSelectionElementArray size = 1 ifFalse: [ ^ false ].
	newSelectionElement := aSelectionElementArray first.
	newSelectionElement option animate ifFalse: [ ^ false ].
	(newSelectionElement nodes anySatisfy: [ :node |
		 prevSelectionElement nodes includes: node ]) ifTrue: [ ^ false ].

	^ true
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> differUpdateSelectionFrom: target [

	self subclassResponsibility 
]

{ #category : #'element handlers' }
ToListSelectionElementEventHandler >> elementExtentChangedEvent: anEvent [

	previousSelectionElements := nil.
	self updateSelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListSelectionElementEventHandler >> elementScrolledEvent: anEvent [

	previousSelectionElements := nil.
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
	
	previousSelectionElements := self previousSelectionElementsFrom: target.
	previousSelectionElements do: [ :s | s removeFromParent ]
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
