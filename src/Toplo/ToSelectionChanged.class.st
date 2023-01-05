Class {
	#name : #ToSelectionChanged,
	#superclass : #BlEvent,
	#instVars : [
		'newSelectedIndexes',
		'oldSelectedIndexes'
	],
	#category : #'Toplo-Core-Infinite'
}

{ #category : #'instance creation' }
ToSelectionChanged class >> from: oldArray to: newArray [
	^ self new
		oldSelectedIndexes: oldArray;
		newSelectedIndexes: newArray;
		yourself
]

{ #category : #accessing }
ToSelectionChanged >> newSelectedIndexes [
	^ newSelectedIndexes
]

{ #category : #accessing }
ToSelectionChanged >> newSelectedIndexes: anObject [
	newSelectedIndexes := anObject
]

{ #category : #accessing }
ToSelectionChanged >> oldSelectedIndexes [
	^ oldSelectedIndexes
]

{ #category : #accessing }
ToSelectionChanged >> oldSelectedIndexes: anObject [
	oldSelectedIndexes := anObject
]

{ #category : #sending }
ToSelectionChanged >> sendTo: anObject [

	anObject selectionChanged: self
]
