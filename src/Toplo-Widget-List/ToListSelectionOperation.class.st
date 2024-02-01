Class {
	#name : #ToListSelectionOperation,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #dispatching }
ToListSelectionOperation >> applyListIndexesSelection: aSelectionCommand on: anObject [

	self subclassResponsibility 
]

{ #category : #dispatching }
ToListSelectionOperation >> applyListIntervalSelection: aSelectionCommand on: anObject [

	self subclassResponsibility 
]

{ #category : #dispatching }
ToListSelectionOperation >> applyListNoSelection: aSelectionCommand on: anObject [

	self subclassResponsibility 
]

{ #category : #dispatching }
ToListSelectionOperation >> applyListWholeSelection: aSelectionCommand on: anObject [

	self subclassResponsibility 
]

{ #category : #testing }
ToListSelectionOperation >> isSelection [

	^ self subclassResponsibility 
]
