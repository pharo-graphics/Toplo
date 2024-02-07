Class {
	#name : #ToWholeSelectionModel,
	#superclass : #ToUnderlyingSelectionModel,
	#classVars : [
		'UniqueInstance'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #accessing }
ToWholeSelectionModel class >> uniqueInstance [

	^ UniqueInstance ifNil: [ UniqueInstance := self new ]
]

{ #category : #'api - testing' }
ToWholeSelectionModel >> containsIndex: anIndex [

	^ true
]

{ #category : #copying }
ToWholeSelectionModel >> copy [ 

	^ self
]

{ #category : #testing }
ToWholeSelectionModel >> isWholeSelectionModel [

	^ true
]

{ #category : #accessing }
ToWholeSelectionModel >> selectedIndexesAmong: anInteger [

	anInteger ifNil: [ ^ super selectedIndexesAmong: anInteger ].
	^ 1 to: anInteger
]

{ #category : #enumerating }
ToWholeSelectionModel >> selectedIndexesCollect: aBlock among: anItemCount [

	^ (1 to: anItemCount) collect: aBlock
]

{ #category : #accessing }
ToWholeSelectionModel >> selectedIndexesCountAmong: anInteger [

	^ anInteger
]

{ #category : #enumerating }
ToWholeSelectionModel >> selectedIndexesDo: aBlock among: anItemCount [

	1 to: anItemCount do: aBlock
]
