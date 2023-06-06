Class {
	#name : #ToSelectionModel,
	#superclass : #Object,
	#traits : 'TBlAnnouncerProvider',
	#classTraits : 'TBlAnnouncerProvider classTrait',
	#instVars : [
		'selection'
	],
	#category : #'Toplo-Core-Infinite'
}

{ #category : #printing }
ToSelectionModel class >> modelName [
	^ 'Selection'
]

{ #category : #notifying }
ToSelectionModel >> announceDeselected: anInterval [

	self announce: (ToDeselectAnnouncement new model: self; indexes: anInterval)
]

{ #category : #notifying }
ToSelectionModel >> announceSelected: aCollection [

	self announce: (ToSelectAnnouncement new model: self; indexes: aCollection)
]

{ #category : #selection }
ToSelectionModel >> deselect: aFromIndex to: aToIndex [
	"Deselect items within a given interval"

	selection deselect: aFromIndex - 1 to: aToIndex.
	self announceDeselected: (aFromIndex to: aToIndex) 
]

{ #category : #selection }
ToSelectionModel >> deselectAll [
	"Deselect all items"

	selection reverseDo: [ :aMonotoneSelection | self deselect: aMonotoneSelection from + 1 to: aMonotoneSelection to ]
]

{ #category : #selection }
ToSelectionModel >> deselectIndex: anIndex [
	"Deselect items with a given index"

	self deselect: anIndex to: anIndex
]

{ #category : #accessing }
ToSelectionModel >> first [

	^ self indices first
]

{ #category : #testing }
ToSelectionModel >> ifEmpty: aBlock [

	^ self isEmpty
		ifTrue: [ aBlock value ]
		ifFalse: [ self ]
]

{ #category : #testing }
ToSelectionModel >> ifNotEmpty: aBlock [

	^ self isEmpty
		ifTrue: [ self ]
		ifFalse: [ aBlock cull: self ]
]

{ #category : #testing }
ToSelectionModel >> includes: anIndex [
	"Return true if item at a given index is selected, false otherwise"
	<return: #Boolean>

	^ selection containsIndex: anIndex
]

{ #category : #accessing }
ToSelectionModel >> indices [
	<return: #Collection of: #Number>
	
	^ selection indices
]

{ #category : #initialization }
ToSelectionModel >> initialize [
	super initialize.

	selection := BlCompositeSelection new
]

{ #category : #testing }
ToSelectionModel >> isEmpty [
	<return: #Boolean>
	
	^ selection isEmpty
]

{ #category : #testing }
ToSelectionModel >> isNotEmpty [
	<return: #Boolean>
	
	^ selection isNotEmpty
]

{ #category : #accessing }
ToSelectionModel >> last [

	^ self indices last
]

{ #category : #copying }
ToSelectionModel >> postCopy [  

	selection := selection copy.
	^ super postCopy
]

{ #category : #selection }
ToSelectionModel >> select: aToIndex [
	"Select items within a given interval"

	selection select: aToIndex - 1 to: aToIndex.
	self announceSelected: (aToIndex to: aToIndex)
]

{ #category : #selection }
ToSelectionModel >> select: aFromIndex to: aToIndex [
	"Select items within a given interval"

	selection select: aFromIndex - 1 to: aToIndex.
	self announceSelected: (aFromIndex to: aToIndex)
]

{ #category : #selection }
ToSelectionModel >> selectIndex: anIndex [
	"Select an item at a given index deselecting all previously selected items"
	| aSelectionCopy |

	aSelectionCopy := selection copy.
	aSelectionCopy deselect: anIndex - 1 to: anIndex.

	aSelectionCopy do: [ :aMonotoneSelection | self deselect: aMonotoneSelection from + 1 to: aMonotoneSelection to ].

	(self includes: anIndex)
		ifTrue: [ ^ self ].

	selection select: anIndex - 1 to: anIndex.
	self announceSelected: (anIndex to: anIndex)
]

{ #category : #selection }
ToSelectionModel >> selectIndexes: aCollection [

	aCollection do: [ :idx | selection select: idx - 1 to: idx ].
	self announceSelected: aCollection
]

{ #category : #accessing }
ToSelectionModel >> selectedIndexes [ 

	^ self indices
]

{ #category : #accessing }
ToSelectionModel >> size [

	^ self indices size
]
