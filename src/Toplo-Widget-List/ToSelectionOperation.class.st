Class {
	#name : #ToSelectionOperation,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #dispatching }
ToSelectionOperation >> applyIndexesSelection: aSelectionCommand on: anObject [

	self subclassResponsibility 
]

{ #category : #dispatching }
ToSelectionOperation >> applyIntervalSelection: aSelectionCommand on: anObject [

	self subclassResponsibility 
]

{ #category : #dispatching }
ToSelectionOperation >> applyWholeSelection: aSelectionCommand on: anObject [

	self subclassResponsibility 
]

{ #category : #testing }
ToSelectionOperation >> isSelection [

	^ self subclassResponsibility 
]
