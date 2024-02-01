Class {
	#name : #ToListRemoveSelection,
	#superclass : #ToListSelectionOperation,
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #dispatching }
ToListRemoveSelection >> applyListIndexesSelection: aSelectionCommand on: anObject [

	aSelectionCommand operationState applyListRemoveIndexesSelection: aSelectionCommand on: anObject
]

{ #category : #dispatching }
ToListRemoveSelection >> applyListIntervalSelection: aSelectionCommand on: anObject [

	aSelectionCommand operationState applyListRemoveIntervalSelection: aSelectionCommand on: anObject
]

{ #category : #dispatching }
ToListRemoveSelection >> applyListNoSelection: aSelectionCommand on: anObject [

	aSelectionCommand operationState applyListRemoveNoSelection: aSelectionCommand on: anObject
]

{ #category : #dispatching }
ToListRemoveSelection >> applyListWholeSelection: aSelectionCommand on: anObject [

	aSelectionCommand operationState applyListRemoveWholeSelection: aSelectionCommand on: anObject
]

{ #category : #testing }
ToListRemoveSelection >> isSelection [

	^ false
]
