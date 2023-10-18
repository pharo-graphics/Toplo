Class {
	#name : #ToInfiniteSelectionChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'newSelectedIndexes',
		'oldSelectedIndexes'
	],
	#category : 'Toplo-Widget-List-infinite'
}

{ #category : #'instance creation' }
ToInfiniteSelectionChangedEvent class >> from: oldArray to: newArray [
	^ self new
		oldSelectedIndexes: oldArray;
		newSelectedIndexes: newArray;
		yourself
]

{ #category : #accessing }
ToInfiniteSelectionChangedEvent >> newSelectedIndexes [
	^ newSelectedIndexes
]

{ #category : #accessing }
ToInfiniteSelectionChangedEvent >> newSelectedIndexes: anObject [
	newSelectedIndexes := anObject
]

{ #category : #accessing }
ToInfiniteSelectionChangedEvent >> oldSelectedIndexes [
	^ oldSelectedIndexes
]

{ #category : #accessing }
ToInfiniteSelectionChangedEvent >> oldSelectedIndexes: anObject [
	oldSelectedIndexes := anObject
]

{ #category : #sending }
ToInfiniteSelectionChangedEvent >> sendTo: anObject [

	anObject infiniteSelectionChangedEvent: self
]
