Class {
	#name : #ToAddSelectionOperation,
	#superclass : #ToSelectionModelOperation,
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
