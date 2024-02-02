Class {
	#name : #ToAddSelectionOperation,
	#superclass : #ToSelectionOperation,
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #dispatching }
ToAddSelectionOperation >> applyIndexesSelection: aSelectionCommand on: anObject [

	anObject addIndexesSelectionCommand: aSelectionCommand
]

{ #category : #dispatching }
ToAddSelectionOperation >> applyIntervalSelection: aSelectionCommand on: anObject [

	anObject addIntervalSelectionCommand: aSelectionCommand
]

{ #category : #dispatching }
ToAddSelectionOperation >> applyWholeSelection: aSelectionCommand on: anObject [

	anObject addWholeSelectionCommand: aSelectionCommand
]

{ #category : #testing }
ToAddSelectionOperation >> isSelection [

	^ true
]
