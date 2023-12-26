Class {
	#name : #ToListSelectIndexesEvent,
	#superclass : #ToListSelectionActionEvent,
	#instVars : [
		'indexes'
	],
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #accessing }
ToListSelectIndexesEvent >> indexes [

	^ indexes
]

{ #category : #accessing }
ToListSelectIndexesEvent >> indexes: aCollectionOfIndexes [

	indexes := aCollectionOfIndexes
]

{ #category : #printing }
ToListSelectIndexesEvent >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: ' indexes: '.
	self indexes printOn: aStream
]

{ #category : #sending }
ToListSelectIndexesEvent >> sendTo: anObject [

	anObject listSelectIndexesEvent: self
]
