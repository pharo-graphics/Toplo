Class {
	#name : #ToSelectionChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'newSelectedIndexes',
		'oldSelectedIndexes'
	],
	#category : #'Toplo-Core-Infinite'
}

{ #category : #'instance creation' }
ToSelectionChangedEvent class >> from: oldArray to: newArray [
	^ self new
		oldSelectedIndexes: oldArray;
		newSelectedIndexes: newArray;
		yourself
]

{ #category : #accessing }
ToSelectionChangedEvent >> newSelectedIndexes [
	^ newSelectedIndexes
]

{ #category : #accessing }
ToSelectionChangedEvent >> newSelectedIndexes: anObject [
	newSelectedIndexes := anObject
]

{ #category : #accessing }
ToSelectionChangedEvent >> oldSelectedIndexes [
	^ oldSelectedIndexes
]

{ #category : #accessing }
ToSelectionChangedEvent >> oldSelectedIndexes: anObject [
	oldSelectedIndexes := anObject
]

{ #category : #sending }
ToSelectionChangedEvent >> sendTo: anObject [

	anObject selectionChanged: self
]
