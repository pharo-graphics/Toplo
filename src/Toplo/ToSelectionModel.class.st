Class {
	#name : #ToSelectionModel,
	#superclass : #Object,
	#instVars : [
		'selection'
	],
	#category : #'Toplo-Core-Infinite'
}

{ #category : #printing }
ToSelectionModel class >> modelName [
	^ 'Selection'
]

{ #category : #'api - testing' }
ToSelectionModel >> contains: anIndex [
	"Return true if item at a given index is selected, false otherwise"
	<return: #Boolean>

	^ selection containsIndex: anIndex
]

{ #category : #'api - selection' }
ToSelectionModel >> deselect: aFromIndex to: aToIndex [
	"Deselect items within a given interval"

	selection deselect: aFromIndex - 1 to: aToIndex.
	self notifyDeselected: (aFromIndex to: aToIndex) 
]

{ #category : #'api - selection' }
ToSelectionModel >> deselectAll [
	"Deselect all items"

	selection reverseDo: [ :aMonotoneSelection | self deselect: aMonotoneSelection from + 1 to: aMonotoneSelection to ]
]

{ #category : #'api - selection' }
ToSelectionModel >> deselectOne: anIndex [
	"Deselect items with a given index"

	self deselect: anIndex to: anIndex
]

{ #category : #'api - testing' }
ToSelectionModel >> hasSelection [
	<return: #Boolean>
	
	^ selection isNotEmpty
]

{ #category : #'api - accessing' }
ToSelectionModel >> indices [
	<return: #Collection of: #Number>
	
	^ selection indices
]

{ #category : #initialization }
ToSelectionModel >> initialize [
	super initialize.

	selection := BlCompositeSelection new
]

{ #category : #notifying }
ToSelectionModel >> notifyDeselected: anInterval [
]

{ #category : #notifying }
ToSelectionModel >> notifySelected: anInterval [
	self
		notifySelected: anInterval
		dueTo: nil
]

{ #category : #notifying }
ToSelectionModel >> notifySelected: anInterval dueTo: aSourceEvent [
]

{ #category : #'api - selection' }
ToSelectionModel >> select: aFromIndex to: aToIndex [
	"Select items within a given interval"

	self
		select: aFromIndex
		to: aToIndex
		dueTo: nil
]

{ #category : #'api - selection' }
ToSelectionModel >> select: aFromIndex to: aToIndex dueTo: aSourceEvent [
	"Select items within a given interval"

	selection select: aFromIndex - 1 to: aToIndex.
	self notifySelected: (aFromIndex to: aToIndex) dueTo: aSourceEvent
]

{ #category : #'api - selection' }
ToSelectionModel >> selectOne: anIndex [
	"Select an item at a given index deselecting all previously selected items"
	
	self
		selectOne: anIndex
		dueTo: nil
]

{ #category : #'api - selection' }
ToSelectionModel >> selectOne: anIndex dueTo: aSourceEvent [
	"Select an item at a given index deselecting all previously selected items"
	| aSelectionCopy |

	aSelectionCopy := selection copy.
	aSelectionCopy deselect: anIndex - 1 to: anIndex.

	aSelectionCopy do: [ :aMonotoneSelection | self deselect: aMonotoneSelection from + 1 to: aMonotoneSelection to ].

	(self contains: anIndex)
		ifTrue: [ ^ self ].

	selection select: anIndex - 1 to: anIndex.
	self notifySelected: (anIndex to: anIndex) dueTo: aSourceEvent
]
