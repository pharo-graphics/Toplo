Class {
	#name : #ToListUniqueIndexEvent,
	#superclass : #ToListSelectionActionEvent,
	#instVars : [
		'index'
	],
	#category : #'Toplo-Widget-List-Infinite'
}

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
