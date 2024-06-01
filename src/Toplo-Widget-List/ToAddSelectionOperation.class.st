Class {
	#name : #ToAddSelectionOperation,
	#superclass : #ToSelectionModelOperation,
	#instVars : [
		'deselectAllBefore'
	],
	#category : #'Toplo-Widget-List-Command'
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

{ #category : #accessing }
ToAddSelectionOperation >> deselectAllBefore [

	^ deselectAllBefore ifNil: [ deselectAllBefore := false ]
]

{ #category : #accessing }
ToAddSelectionOperation >> deselectAllBefore: aBoolean [

	deselectAllBefore := aBoolean
]
