Class {
	#name : #ToEmptySelectionModel,
	#superclass : #ToUnderlyingSelectionModel,
	#classVars : [
		'UniqueInstance'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #accessing }
ToEmptySelectionModel class >> uniqueInstance [

	^ UniqueInstance ifNil: [ UniqueInstance := self new ]
]

{ #category : #'api - testing' }
ToEmptySelectionModel >> containsIndex: anIndex [

	^ false
]

{ #category : #copying }
ToEmptySelectionModel >> copy [ 

	^ self
]

{ #category : #'accessing selection' }
ToEmptySelectionModel >> deselect: aFromTextIndex to: aToTextIndex [
]

{ #category : #'accessing selection' }
ToEmptySelectionModel >> deselectIndex: anIndex [
]

{ #category : #testing }
ToEmptySelectionModel >> isEmpty [

	^ true
]

{ #category : #testing }
ToEmptySelectionModel >> isEmptySelectionModel [

	^ true
]

{ #category : #'accessing selection' }
ToEmptySelectionModel >> select: aFromTextIndex to: aToTextIndex [

	^ ToInvalidCommand signal
]

{ #category : #accessing }
ToEmptySelectionModel >> selectedIndexesAmong: anInteger [ 

	^ {  }
]

{ #category : #enumerating }
ToEmptySelectionModel >> selectedIndexesCollect: aBlock among: anItemCount [

	^ #()
]

{ #category : #accessing }
ToEmptySelectionModel >> selectedIndexesCountAmong: anInteger [

	^ 0
]

{ #category : #enumerating }
ToEmptySelectionModel >> selectedIndexesDo: aBlock among: anItemCount [


]
