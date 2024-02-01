Class {
	#name : #ToListAddSelection,
	#superclass : #ToListSelectionOperation,
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #dispatching }
ToListAddSelection >> applyListIndexesSelection: aSelectionCommand on: anObject [

	aSelectionCommand operationState applyListAddIndexesSelection: aSelectionCommand on: anObject
]

{ #category : #dispatching }
ToListAddSelection >> applyListIntervalSelection: aSelectionCommand on: anObject [

	aSelectionCommand operationState applyListAddIntervalSelection: aSelectionCommand on: anObject
]

{ #category : #dispatching }
ToListAddSelection >> applyListNoSelection: aSelectionCommand on: anObject [

	aSelectionCommand operationState applyListAddNoSelection: aSelectionCommand on: anObject
]

{ #category : #dispatching }
ToListAddSelection >> applyListWholeSelection: aSelectionCommand on: anObject [

	aSelectionCommand operationState applyListAddWholeSelection: aSelectionCommand on: anObject
]

{ #category : #testing }
ToListAddSelection >> isSelection [

	^ true
]
