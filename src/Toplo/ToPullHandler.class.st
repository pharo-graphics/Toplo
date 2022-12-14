Class {
	#name : #ToPullHandler,
	#superclass : #BlPullHandler,
	#instVars : [
		'draggTask',
		'lastDragEvent',
		'monitor'
	],
	#category : #'Toplo-Core'
}

{ #category : #'dnd handlers' }
ToPullHandler >> dragEvent: anEvent [
	monitor critical: [ 
		draggTask ifNotNil: #terminate.
		draggTask := [ 
		             self launchDragEvent: anEvent.
		             lastDragEvent := anEvent.
		             self taskDone ]
			             forkAt: Processor userInterruptPriority
			             named: 'PullHandler task' ]
]

{ #category : #initialization }
ToPullHandler >> initialize [ 

	super initialize.
	monitor := Monitor new
]

{ #category : #'dnd handlers' }
ToPullHandler >> launchDragEvent: anEvent [
	| aStartPosition aCurrentPosition aPreviousPosition dragDelta aNewPosition newX newY|
		
	dragStartGlobalPosition ifNil: [ dragStartGlobalPosition := anEvent position ].
	
	aCurrentPosition := pullTarget globalPointToParentChildren: anEvent position.
	aStartPosition := pullTarget globalPointToParentChildren: dragStartGlobalPosition.

	dragDelta := aCurrentPosition - aStartPosition.
	
	dragDelta := (self computePullDelta: dragDelta) rounded.
	aNewPosition := ((originalPosition ifNil: [ originalPosition := pullTarget constraints position ]) + dragDelta).
	aPreviousPosition := pullTarget constraints position.
	allowedOutOfBounds ifFalse: [
		| aMaxPosition |

		aMaxPosition := (pullTarget hasParent
			ifTrue: [ pullTarget parent extent - anEvent currentTarget extent ]
			ifFalse: [ 0@0 ]).
		aNewPosition := aNewPosition min: aMaxPosition max: 0@0.
		 ].

	newX := relocateX ifTrue: [ aNewPosition x ] ifFalse: [ pullTarget constraints position x ].
	newY := relocateY ifTrue: [ aNewPosition y ] ifFalse: [ pullTarget constraints position y ].
	pullTarget relocate: newX @ newY.
	anEvent consumed: true.
	self
		onPulled: pullTarget
		from: aPreviousPosition
		to: aNewPosition
		by: dragDelta
		starting: originalPosition

]

{ #category : #'dnd handlers' }
ToPullHandler >> taskDone [

	draggTask ifNotNil: #terminate.
	draggTask := nil
]
