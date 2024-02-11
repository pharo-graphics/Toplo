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

{ #category : #'api - testing' }
ToUnderlyingSelectionModel >> containsIndex: anIndex [

	^ self subclassResponsibility 
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
ToUnderlyingSelectionModel >> firstIndexAmong: anItemCount [

	^ self subclassResponsibility 
]

{ #category : #testing }
ToUnderlyingSelectionModel >> isCompositeSelectionModel [

	^ false
]

{ #category : #testing }
ToUnderlyingSelectionModel >> isEmpty [

	^ false
]

{ #category : #testing }
ToUnderlyingSelectionModel >> isEmptySelectionModel [

	^ false
]

{ #category : #testing }
ToUnderlyingSelectionModel >> isWholeSelectionModel [

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

{ #category : #accessing }
ToUnderlyingSelectionModel >> selectedIndexesAmong: anInteger [

	^ ToInvalidCommand signal
]

{ #category : #enumerating }
ToUnderlyingSelectionModel >> selectedIndexesCollect: aBlock among: anItemCount [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToUnderlyingSelectionModel >> selectedIndexesCountAmong: anInteger [

	^ self subclassResponsibility 
]

{ #category : #enumerating }
ToUnderlyingSelectionModel >> selectedIndexesDo: aBlock among: anItemCount [

	^ self subclassResponsibility 
]
