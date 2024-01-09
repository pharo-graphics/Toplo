Class {
	#name : #ToInfiniteSelectionModel,
	#superclass : #Object,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'selection'
	],
	#category : #'Toplo-Widget-List-Selection'
}

{ #category : #printing }
ToInfiniteSelectionModel class >> modelName [
	^ 'Selection'
]

{ #category : #selection }
ToInfiniteSelectionModel >> deselect: aFromIndex to: aToIndex [
	"Deselect items within a given interval"

	selection deselect: aFromIndex - 1 to: aToIndex
]

{ #category : #selection }
ToInfiniteSelectionModel >> deselectAll [
	"Deselect all items"

	selection reverseDo: [ :aMonotoneSelection | self deselect: aMonotoneSelection from + 1 to: aMonotoneSelection to ]
]

{ #category : #selection }
ToInfiniteSelectionModel >> deselectIndex: anIndex [
	"Deselect items with a given index"

	self deselect: anIndex to: anIndex
]

{ #category : #accessing }
ToInfiniteSelectionModel >> first [

	^ self indices first
]

{ #category : #testing }
ToInfiniteSelectionModel >> ifEmpty: aBlock [

	^ self isEmpty
		ifTrue: [ aBlock value ]
		ifFalse: [ self ]
]

{ #category : #testing }
ToInfiniteSelectionModel >> ifNotEmpty: aBlock [

	^ self isEmpty
		ifTrue: [ self ]
		ifFalse: [ aBlock cull: self ]
]

{ #category : #testing }
ToInfiniteSelectionModel >> includes: anIndex [
	"Return true if item at a given index is selected, false otherwise"
	<return: #Boolean>

	^ selection containsIndex: anIndex
]

{ #category : #accessing }
ToInfiniteSelectionModel >> indices [
	<return: #Collection of: #Number>
	
	^ selection indices
]

{ #category : #initialization }
ToInfiniteSelectionModel >> initialize [
	super initialize.

	selection := BlCompositeSelection new
]

{ #category : #testing }
ToInfiniteSelectionModel >> isEmpty [
	<return: #Boolean>
	
	^ selection isEmpty
]

{ #category : #testing }
ToInfiniteSelectionModel >> isNotEmpty [
	<return: #Boolean>
	
	^ selection isNotEmpty
]

{ #category : #accessing }
ToInfiniteSelectionModel >> last [

	^ self indices last
]

{ #category : #copying }
ToInfiniteSelectionModel >> postCopy [  

	selection := selection copy.
	^ super postCopy
]

{ #category : #selection }
ToInfiniteSelectionModel >> select: aToIndex [
	"Select items within a given interval"

	selection select: aToIndex - 1 to: aToIndex
]

{ #category : #selection }
ToInfiniteSelectionModel >> select: aFromIndex to: aToIndex [
	"Select items within a given interval"

	selection select: aFromIndex - 1 to: aToIndex
]

{ #category : #selection }
ToInfiniteSelectionModel >> selectIndex: anIndex [
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
ToInfiniteSelectionModel >> selectIndexes: aCollection [

	aCollection do: [ :idx | selection select: idx - 1 to: idx ]
]

{ #category : #accessing }
ToInfiniteSelectionModel >> selectedIndexes [ 

	^ self indices
]

{ #category : #accessing }
ToInfiniteSelectionModel >> size [

	^ self indices size
]
