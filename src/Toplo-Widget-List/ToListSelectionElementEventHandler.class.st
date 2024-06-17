Class {
	#name : #ToListSelectionElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> animateSelectionUpdate: aSelElement [

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
	aSelElement updateListElement
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> differUpdateSelectionFrom: target [

	self subclassResponsibility 
]

{ #category : #'element handlers' }
ToListSelectionElementEventHandler >> elementExtentChangedEvent: anEvent [

	self refreshSelectionFromEvent: anEvent
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
ToListSelectionElementEventHandler >> refreshSelectionFromEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	(self selectionModeFrom: target)
		forgetPreviousSelectionState;
		updateSelectionFrom: target
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> selectionModeFrom: aTarget [

	^ self subclassResponsibility
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> updateSelectionElementFrom: aTarget [

	| selElements selectionMode |
	selectionMode := self selectionModeFrom: aTarget.
	selElements := selectionMode selectionElementsFrom: aTarget.
	(self canAnimateSelectionUpdateWith: selElements)
		ifTrue: [
			self animateSelectionUpdate: selElements first ]
		ifFalse: [ selElements do: [ :sel | sel updateListElement ] ].

	selElements ifEmpty: [
		previousSelectionBounds := nil.
		^ self ].
	previousSelectionBounds := selElements first boundsFromNodes merge:
		                           selElements last boundsFromNodes
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> updateSelectionFromEvent: anEvent [

	|  target  |
	target := anEvent currentTarget.
	target isAttachedToSceneGraph ifFalse: [
		self differUpdateSelectionFrom: target.
		^ self ].
	(self selectionModeFrom: target) updateSelectionFrom: target.
]
