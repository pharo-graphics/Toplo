Class {
	#name : #ToSelectionModelOperation,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #dispatching }
ToSelectionModelOperation >> applyIndexesSelection: aSelectionCommand on: anObject [

	self subclassResponsibility 
]

{ #category : #dispatching }
ToSelectionModelOperation >> applyIntervalSelection: aSelectionCommand on: anObject [

	self subclassResponsibility 
]

{ #category : #dispatching }
ToSelectionModelOperation >> applyWholeSelection: aSelectionCommand on: anObject [

	self subclassResponsibility 
]
