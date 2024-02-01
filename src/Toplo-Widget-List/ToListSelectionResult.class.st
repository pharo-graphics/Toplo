Class {
	#name : #ToListSelectionResult,
	#superclass : #ToListSelectionOperationState,
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #dispatching }
ToListSelectionResult >> applyListAddIndexesSelection: aSelectionCommand on: anObject [

	anObject listAddIndexesSelectionResult: aSelectionCommand
]

{ #category : #dispatching }
ToListSelectionResult >> applyListAddIntervalSelection: aSelectionCommand on: anObject [

	anObject listAddIntervalSelectionResult: aSelectionCommand
]

{ #category : #dispatching }
ToListSelectionResult >> applyListAddNoSelection: aSelectionCommand on: anObject [

	anObject listAddNoSelectionResult: aSelectionCommand
]

{ #category : #dispatching }
ToListSelectionResult >> applyListAddWholeSelection: aSelectionCommand on: anObject [

	anObject listAddWholeSelectionResult: aSelectionCommand
]

{ #category : #dispatching }
ToListSelectionResult >> applyListRemoveIndexesSelection: aSelectionCommand on: anObject [

	anObject listRemoveIndexesSelectionResult: aSelectionCommand
]

{ #category : #dispatching }
ToListSelectionResult >> applyListRemoveIntervalSelection: aSelectionCommand on: anObject [

	anObject listRemoveIntervalSelectionResult: aSelectionCommand
]

{ #category : #dispatching }
ToListSelectionResult >> applyListRemoveNoSelection: aSelectionCommand on: anObject [

	anObject listRemoveNoSelectionResult: aSelectionCommand
]

{ #category : #dispatching }
ToListSelectionResult >> applyListRemoveWholeSelection: aSelectionCommand on: anObject [

	anObject listRemoveWholeSelectionResult: aSelectionCommand
]

{ #category : #testing }
ToListSelectionResult >> isRequest [

	^ false
]
