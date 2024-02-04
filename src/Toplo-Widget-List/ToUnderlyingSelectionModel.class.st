Class {
	#name : #ToUnderlyingSelectionModel,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #requirements }
ToUnderlyingSelectionModel class >> composite [

	^ ToCompositeSelectionModel new 
]

{ #category : #requirements }
ToUnderlyingSelectionModel class >> empty [

	^ ToEmptySelectionModel uniqueInstance 
]

{ #category : #requirements }
ToUnderlyingSelectionModel class >> whole [

	^ ToWholeSelectionModel uniqueInstance 
]

{ #category : #'accessing selection' }
ToUnderlyingSelectionModel >> deselect: aFromTextIndex to: aToTextIndex [

	^ ToInvalidCommand signal
]

{ #category : #'accessing selection' }
ToUnderlyingSelectionModel >> deselectIndex: anIndex [

	^ ToInvalidCommand signal
]

{ #category : #accessing }
ToUnderlyingSelectionModel >> indices [

	^ ToInvalidCommand signal
]

{ #category : #testing }
ToUnderlyingSelectionModel >> isComposite [

	^ false
]

{ #category : #testing }
ToUnderlyingSelectionModel >> isEmpty [

	^ false
]

{ #category : #testing }
ToUnderlyingSelectionModel >> isWhole [

	^ false
]

{ #category : #'accessing selection' }
ToUnderlyingSelectionModel >> select: aFromTextIndex to: aToTextIndex [

	^ ToInvalidCommand signal
]

{ #category : #'accessing selection' }
ToUnderlyingSelectionModel >> selectIndex: anIndex [

	^ ToInvalidCommand signal
]
