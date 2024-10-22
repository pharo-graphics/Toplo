Class {
	#name : #ToSelectionOperation,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Command'
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
ToSelectionOperation >> isAdd [ 

	^ self subclassResponsibility 
]

{ #category : #testing }
ToSelectionOperation >> isRemove [

	^ self subclassResponsibility 
]
