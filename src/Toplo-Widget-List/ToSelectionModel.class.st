Class {
	#name : #ToSelectionModel,
	#superclass : #Object,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'selection',
		'eventDispatcher'
	],
	#category : #'Toplo-Widget-List-infinite'
}

{ #category : #printing }
ToSelectionModel class >> modelName [
	^ 'Selection'
]

{ #category : #selection }
ToSelectionModel >> deselect: aFromIndex to: aToIndex [
	"Deselect items within a given interval"

	selection deselect: aFromIndex - 1 to: aToIndex.
	self dispatchDeselected: (aFromIndex to: aToIndex) 
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

{ #category : #notifying }
ToSelectionModel >> dispatchDeselected: anInterval [

	self fireEvent: (ToSelectionModelDeselectEvent new model: self; indexes: anInterval; yourself)
]

{ #category : #notifying }
ToSelectionModel >> dispatchSelected: aCollection [

	self fireEvent: (ToSelectionModelSelectEvent new model: self; indexes: aCollection; yourself)
]

{ #category : #'event management accessing' }
ToSelectionModel >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
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

	selection := BlCompositeSelection new.
	eventDispatcher := BlDirectEventDispatcher on: self
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
	self dispatchSelected: (aToIndex to: aToIndex)
]

{ #category : #selection }
ToSelectionModel >> select: aFromIndex to: aToIndex [
	"Select items within a given interval"

	selection select: aFromIndex - 1 to: aToIndex.
	self dispatchSelected: (aFromIndex to: aToIndex)
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
	self dispatchSelected: (anIndex to: anIndex)
]

{ #category : #selection }
ToSelectionModel >> selectIndexes: aCollection [

	aCollection do: [ :idx | selection select: idx - 1 to: idx ].
	self dispatchSelected: aCollection
]

{ #category : #accessing }
ToSelectionModel >> selectedIndexes [ 

	^ self indices
]

{ #category : #accessing }
ToSelectionModel >> size [

	^ self indices size
]
