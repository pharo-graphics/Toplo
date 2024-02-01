Class {
	#name : #ToListSelectionRequest,
	#superclass : #ToListSelectionOperationState,
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #dispatching }
ToListSelectionRequest >> applyListAddIndexesSelection: aSelectionCommand on: anObject [

	anObject listAddIndexesSelectionRequest: aSelectionCommand
]

{ #category : #dispatching }
ToListSelectionRequest >> applyListAddIntervalSelection: aSelectionCommand on: anObject [

	anObject listAddIntervalSelectionRequest: aSelectionCommand
]

{ #category : #dispatching }
ToListSelectionRequest >> applyListAddNoSelection: aSelectionCommand on: anObject [

	anObject listAddNoSelectionRequest: aSelectionCommand
]

{ #category : #dispatching }
ToListSelectionRequest >> applyListAddWholeSelection: aSelectionCommand on: anObject [

	anObject listAddWholeSelectionRequest: aSelectionCommand
]

{ #category : #dispatching }
ToListSelectionRequest >> applyListRemoveIndexesSelection: aSelectionCommand on: anObject [

	anObject listRemoveIndexesSelectionRequest: aSelectionCommand
]

{ #category : #dispatching }
ToListSelectionRequest >> applyListRemoveIntervalSelection: aSelectionCommand on: anObject [

	anObject listRemoveIntervalSelectionRequest: aSelectionCommand
]

{ #category : #dispatching }
ToListSelectionRequest >> applyListRemoveNoSelection: aSelectionCommand on: anObject [

	anObject listRemoveNoSelectionRequest: aSelectionCommand
]

{ #category : #dispatching }
ToListSelectionRequest >> applyListRemoveWholeSelection: aSelectionCommand on: anObject [

	anObject listRemoveWholeSelectionRequest: aSelectionCommand
]

{ #category : #testing }
ToListSelectionRequest >> isRequest [

	^ true
]
