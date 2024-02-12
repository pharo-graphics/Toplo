Class {
	#name : #ToRemoveSelectionOperation,
	#superclass : #ToSelectionModelOperation,
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #dispatching }
ToRemoveSelectionOperation >> applyIndexesSelection: aSelectionCommand on: anObject [

	anObject removeIndexesSelectionCommand: aSelectionCommand
]

{ #category : #dispatching }
ToRemoveSelectionOperation >> applyIntervalSelection: aSelectionCommand on: anObject [

	anObject removeIntervalSelectionCommand: aSelectionCommand
]

{ #category : #dispatching }
ToRemoveSelectionOperation >> applyWholeSelection: aSelectionCommand on: anObject [

	anObject removeWholeSelectionCommand: aSelectionCommand
]
