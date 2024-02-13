Class {
	#name : #ToSelectionModelOperation,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Selection-Command'
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
