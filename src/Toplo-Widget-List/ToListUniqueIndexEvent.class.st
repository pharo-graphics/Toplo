Class {
	#name : #ToListUniqueIndexEvent,
	#superclass : #ToListSelectionActionEventDep,
	#instVars : [
		'index'
	],
	#category : #'Toplo-Widget-List-Selection-Deprecated'
}

{ #category : #testing }
ToListUniqueIndexEvent class >> isDeprecated [

	^ true
]

{ #category : #accessing }
ToListUniqueIndexEvent >> index [

	^ index
]

{ #category : #accessing }
ToListUniqueIndexEvent >> index: anInteger [

	index := anInteger
]

{ #category : #printing }
ToListUniqueIndexEvent >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: ' index: '.
	self index printOn: aStream
]
