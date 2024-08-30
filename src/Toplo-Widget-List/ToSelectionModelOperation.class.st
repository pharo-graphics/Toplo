Class {
	#name : #ToSelectionModelOperation,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Command'
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

{ #category : #testing }
ToSelectionModelOperation >> isAdd [ 

	^ self subclassResponsibility 
]

{ #category : #testing }
ToSelectionModelOperation >> isRemove [

	^ self subclassResponsibility 
]
