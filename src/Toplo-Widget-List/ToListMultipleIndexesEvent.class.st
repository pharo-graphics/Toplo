Class {
	#name : #ToListMultipleIndexesEvent,
	#superclass : #ToListSelectionActionEventDep,
	#instVars : [
		'indexes'
	],
	#category : #'Toplo-Widget-List-Selection-Deprecated'
}

{ #category : #testing }
ToListMultipleIndexesEvent class >> isDeprecated [

	^ true
]

{ #category : #accessing }
ToListMultipleIndexesEvent >> indexes [

	^ indexes
]

{ #category : #accessing }
ToListMultipleIndexesEvent >> indexes: aCollectionOfIndexes [

	indexes := aCollectionOfIndexes
]

{ #category : #printing }
ToListMultipleIndexesEvent >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: ' indexes: '.
	self indexes printOn: aStream
]
