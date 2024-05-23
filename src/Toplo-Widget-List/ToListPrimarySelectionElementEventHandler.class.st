Class {
	#name : #ToListPrimarySelectionElementEventHandler,
	#superclass : #ToListSelectionElementEventHandler,
	#instVars : [
		'differedUpdateTask',
		'previousSelection'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'selection managing' }
ToListPrimarySelectionElementEventHandler >> addNewSelectionElement: aSelElement withAnimationFrom: aTarget [

	| targetPosition xAnim yAnim xyAnim |
	targetPosition := aSelElement positionFromNodes.
	aSelElement position: previousSelection position.
	self addSelectionElement: aSelElement from: aTarget.
	xAnim := BlNumberTransition new
		         duration: aSelElement option animationDuration;
		         from: previousSelection position x;
		         to: targetPosition x;
		         onStepDo: [ :number :anElement |
			         aSelElement position: number @ aSelElement position y ].
	yAnim := BlNumberTransition new
		         duration: aSelElement option animationDuration;
		         from: previousSelection position y;
		         to: targetPosition y;
		         onStepDo: [ :number :anElement |
			         aSelElement position: aSelElement position x @ number ].
	xyAnim := BlParallelAnimation withAll: {
			          xAnim.
			          yAnim }.
	xyAnim onFinishedDo: [ aSelElement position: targetPosition ].
	aTarget addAnimation: xyAnim
]

{ #category : #'selection managing' }
ToListPrimarySelectionElementEventHandler >> addNewSelectionElementsFrom: target [

	| selectionModel nodesArray |
	selectionModel := self selectionModelFrom: target.
	previousSelection
		ifNil: [ super addNewSelectionElementsFrom: target ]
		ifNotNil: [
			| newSelElements |
			newSelElements := self newSelectionElementsFrom: target.
			newSelElements size = 1
				ifTrue: [
					self
						addNewSelectionElement: newSelElements first
						withAnimationFrom: target ]
				ifFalse: [
				self addNewSelectionElements: newSelElements from: target ] ].
	" Dispatch the event that is used by the skin state generator to generate the selection state "
	nodesArray := target nodeContainer children asArray.
	nodesArray do: [ :node |
		node dispatchEvent: (ToListNodeSelectedEvent new
				 listElement: target;
				 selected: (selectionModel containsIndex: node holder position)) ]
]

{ #category : #'element handlers' }
ToListPrimarySelectionElementEventHandler >> blurEvent: anEvent [

	" Don't update the selection when the element is removed from the scene 
	This is the case if the event reason is for element removal "
	anEvent isDueToRemoval ifTrue: [ ^ self ].
	self updateSelectionFromEvent: anEvent
]

{ #category : #'selection managing' }
ToListPrimarySelectionElementEventHandler >> differUpdateSelectionFrom: anElement [

	differedUpdateTask ifNotNil: [ ^ self ].
	differedUpdateTask := BlTaskAction new action: [
		                       anElement dispatchEvent:
			                       ToListPrimarySelectionDirtyEvent new.
		                       differedUpdateTask := nil ].
	anElement enqueueTask: differedUpdateTask
]

{ #category : #'api - accessing' }
ToListPrimarySelectionElementEventHandler >> eventsToHandle [

	^ super eventsToHandle, {
		  BlFocusEvent.
		  BlBlurEvent.
		  ToListPrimarySelectionDirtyEvent.
		  ToListPrimarySelectionChangedEvent }
]

{ #category : #'element handlers' }
ToListPrimarySelectionElementEventHandler >> focusEvent: anEvent [

	self updateSelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListPrimarySelectionElementEventHandler >> listPrimarySelectionChangedEvent: anEvent [

	self updateSelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListPrimarySelectionElementEventHandler >> listPrimarySelectionDirtyEvent: anEvent [

	self updateSelectionFromEvent: anEvent
]

{ #category : #'selection managing' }
ToListPrimarySelectionElementEventHandler >> previousSelectionElementsFrom: aTarget [

	| prev |
	prev := aTarget primarySelectionElements.
	previousSelection := (prev size = 1 and: [ prev first option animate ])
		                     ifTrue: [ prev first ]
		                     ifFalse: [ nil ].
	^ prev
]

{ #category : #'selection managing' }
ToListPrimarySelectionElementEventHandler >> removePreviousSelectionElementsFrom: target [

	| selectionModel nodesArray |
	super removePreviousSelectionElementsFrom: target.
	selectionModel := self selectionModelFrom: target.
	" no need to dispatch ToListNodeSelectedEvent here. It should be done in #addNewSelectionElementsFrom: "
	selectionModel ifNotEmpty: [ ^ self ].
	nodesArray := target nodeContainer children asArray.
	nodesArray do: [ :node |
		node dispatchEvent: (ToListNodeSelectedEvent new
				 listElement: target;
				 selected: (selectionModel containsIndex: node holder position)) ]
]

{ #category : #'selection managing' }
ToListPrimarySelectionElementEventHandler >> selectionElementClassFrom: aTarget [

	^ aTarget selectionMode elementClass
]

{ #category : #'selection managing' }
ToListPrimarySelectionElementEventHandler >> selectionModeFrom: aTarget [

	^ aTarget selectionMode
]

{ #category : #'selection managing' }
ToListPrimarySelectionElementEventHandler >> selectionModelFrom: target [

	^ target selectionModel
]
