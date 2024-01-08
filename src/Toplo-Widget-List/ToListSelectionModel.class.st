Class {
	#name : #ToListSelectionModel,
	#superclass : #Object,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'selection'
	],
	#category : #'Toplo-Widget-List-Selection'
}

{ #category : #printing }
ToListSelectionModel class >> modelName [
	^ 'Selection'
]

{ #category : #selection }
ToListSelectionModel >> deselect: aFromIndex to: aToIndex [
	"Deselect items within a given interval"

	selection deselect: aFromIndex - 1 to: aToIndex
]

{ #category : #selection }
ToListSelectionModel >> deselectAll [
	"Deselect all items"

	selection reverseDo: [ :aMonotoneSelection | self deselect: aMonotoneSelection from + 1 to: aMonotoneSelection to ]
]

{ #category : #selection }
ToListSelectionModel >> deselectIndex: anIndex [
	"Deselect items with a given index"

	self deselect: anIndex to: anIndex
]

{ #category : #accessing }
ToListSelectionModel >> first [

	^ self indices first
]

{ #category : #testing }
ToListSelectionModel >> ifEmpty: aBlock [

	^ self isEmpty
		ifTrue: [ aBlock value ]
		ifFalse: [ self ]
]

{ #category : #testing }
ToListSelectionModel >> ifNotEmpty: aBlock [

	^ self isEmpty
		ifTrue: [ self ]
		ifFalse: [ aBlock cull: self ]
]

{ #category : #testing }
ToListSelectionModel >> includes: anIndex [
	"Return true if item at a given index is selected, false otherwise"
	<return: #Boolean>

	^ selection containsIndex: anIndex
]

{ #category : #accessing }
ToListSelectionModel >> indices [
	<return: #Collection of: #Number>
	
	^ selection indices
]

{ #category : #initialization }
ToListSelectionModel >> initialize [
	super initialize.

	selection := BlCompositeSelection new
]

{ #category : #testing }
ToListSelectionModel >> isEmpty [
	<return: #Boolean>
	
	^ selection isEmpty
]

{ #category : #testing }
ToListSelectionModel >> isNotEmpty [
	<return: #Boolean>
	
	^ selection isNotEmpty
]

{ #category : #accessing }
ToListSelectionModel >> last [

	^ self indices last
]

{ #category : #copying }
ToListSelectionModel >> postCopy [  

	selection := selection copy.
	^ super postCopy
]

{ #category : #selection }
ToListSelectionModel >> select: aToIndex [
	"Select items within a given interval"

	selection select: aToIndex - 1 to: aToIndex
]

{ #category : #selection }
ToListSelectionModel >> select: aFromIndex to: aToIndex [
	"Select items within a given interval"

	selection select: aFromIndex - 1 to: aToIndex
]

{ #category : #selection }
ToListSelectionModel >> selectIndex: anIndex [
	"Select an item at a given index deselecting all previously selected items"
	| aSelectionCopy |

	aSelectionCopy := selection copy.
	aSelectionCopy deselect: anIndex - 1 to: anIndex.

	aSelectionCopy do: [ :aMonotoneSelection | self deselect: aMonotoneSelection from + 1 to: aMonotoneSelection to ].

	(self includes: anIndex)
		ifTrue: [ ^ self ].

	selection select: anIndex - 1 to: anIndex
]

{ #category : #selection }
ToListSelectionModel >> selectIndexes: aCollection [

	aCollection do: [ :idx | selection select: idx - 1 to: idx ]
]

{ #category : #accessing }
ToListSelectionModel >> selectedIndexes [ 

	^ self indices
]

{ #category : #accessing }
ToListSelectionModel >> size [

	^ self indices size
]
