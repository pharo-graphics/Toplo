Class {
	#name : #ToListSelectionOperationState,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #dispatching }
ToListSelectionOperationState >> applyListAddIndexesSelection: aSelectionCommand on: anObject [

	self subclassResponsibility 
]

{ #category : #dispatching }
ToListSelectionOperationState >> applyListAddIntervalSelection: aSelectionCommand on: anObject [

	self subclassResponsibility 
]

{ #category : #dispatching }
ToListSelectionOperationState >> applyListAddNoSelection: aSelectionCommand on: anObject [

	self subclassResponsibility 
]

{ #category : #dispatching }
ToListSelectionOperationState >> applyListAddWholeSelection: aSelectionCommand on: anObject [

	self subclassResponsibility 
]

{ #category : #dispatching }
ToListSelectionOperationState >> applyListRemoveIndexesSelection: aSelectionCommand on: anObjec [

	self subclassResponsibility 
]

{ #category : #dispatching }
ToListSelectionOperationState >> applyListRemoveIntervalSelection: aSelectionCommand on: anObject [

	self subclassResponsibility 
]

{ #category : #dispatching }
ToListSelectionOperationState >> applyListRemoveNoSelection: aSelectionCommand on: anObject [

	self subclassResponsibility 
]

{ #category : #dispatching }
ToListSelectionOperationState >> applyListRemoveWholeSelection: aSelectionCommand on: anObject [

	self subclassResponsibility 
]

{ #category : #testing }
ToListSelectionOperationState >> isRequest [

	^ self subclassResponsibility 
]
