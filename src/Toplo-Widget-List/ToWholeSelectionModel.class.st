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

{ #category : #testing }
ToWholeSelectionModel >> isWhole [

	^ true
]
