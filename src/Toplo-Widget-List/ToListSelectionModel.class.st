Class {
	#name : 'ToListSelectionModel',
	#superclass : 'Object',
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'selection',
		'eventDispatcher'
	],
	#category : 'Toplo-Widget-List-Infinite',
	#package : 'Toplo-Widget-List',
	#tag : 'Infinite'
}

{ #category : 'printing' }
ToListSelectionModel class >> modelName [
	^ 'Selection'
]

{ #category : 'selection' }
ToListSelectionModel >> deselect: aFromIndex to: aToIndex [
	"Deselect items within a given interval"

	selection deselect: aFromIndex - 1 to: aToIndex.
	self dispatchDeselected: (aFromIndex to: aToIndex) 
]

{ #category : 'selection' }
ToListSelectionModel >> deselectAll [
	"Deselect all items"

	selection reverseDo: [ :aMonotoneSelection | self deselect: aMonotoneSelection from + 1 to: aMonotoneSelection to ]
]

{ #category : 'selection' }
ToListSelectionModel >> deselectIndex: anIndex [
	"Deselect items with a given index"

	self deselect: anIndex to: anIndex
]

{ #category : 'notifying' }
ToListSelectionModel >> dispatchDeselected: anInterval [

	self fireEvent: (ToListSelectionModelDeselectEvent new model: self; indexes: anInterval; yourself)
]

{ #category : 'notifying' }
ToListSelectionModel >> dispatchSelected: aCollection [

	self fireEvent: (ToListSelectionModelSelectEvent new model: self; indexes: aCollection; yourself)
]

{ #category : 'event management accessing' }
ToListSelectionModel >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : 'accessing' }
ToListSelectionModel >> first [

	^ self indices first
]

{ #category : 'testing' }
ToListSelectionModel >> ifEmpty: aBlock [

	^ self isEmpty
		ifTrue: [ aBlock value ]
		ifFalse: [ self ]
]

{ #category : 'testing' }
ToListSelectionModel >> ifNotEmpty: aBlock [

	^ self isEmpty
		ifTrue: [ self ]
		ifFalse: [ aBlock cull: self ]
]

{ #category : 'testing' }
ToListSelectionModel >> includes: anIndex [
	"Return true if item at a given index is selected, false otherwise"
	<return: #Boolean>

	^ selection containsIndex: anIndex
]

{ #category : 'accessing' }
ToListSelectionModel >> indices [
	<return: #Collection of: #Number>
	
	^ selection indices
]

{ #category : 'initialization' }
ToListSelectionModel >> initialize [
	super initialize.

	selection := BlCompositeSelection new.
	eventDispatcher := BlDirectEventDispatcher on: self
]

{ #category : 'testing' }
ToListSelectionModel >> isEmpty [
	<return: #Boolean>
	
	^ selection isEmpty
]

{ #category : 'testing' }
ToListSelectionModel >> isNotEmpty [
	<return: #Boolean>
	
	^ selection isNotEmpty
]

{ #category : 'accessing' }
ToListSelectionModel >> last [

	^ self indices last
]

{ #category : 'copying' }
ToListSelectionModel >> postCopy [  

	selection := selection copy.
	^ super postCopy
]

{ #category : 'selection' }
ToListSelectionModel >> select: aToIndex [
	"Select items within a given interval"

	selection select: aToIndex - 1 to: aToIndex.
	self dispatchSelected: (aToIndex to: aToIndex)
]

{ #category : 'selection' }
ToListSelectionModel >> select: aFromIndex to: aToIndex [
	"Select items within a given interval"

	selection select: aFromIndex - 1 to: aToIndex.
	self dispatchSelected: (aFromIndex to: aToIndex)
]

{ #category : 'selection' }
ToListSelectionModel >> selectIndex: anIndex [
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

{ #category : 'selection' }
ToListSelectionModel >> selectIndexes: aCollection [

	aCollection do: [ :idx | selection select: idx - 1 to: idx ].
	self dispatchSelected: aCollection
]

{ #category : 'accessing' }
ToListSelectionModel >> selectedIndexes [ 

	^ self indices
]

{ #category : 'accessing' }
ToListSelectionModel >> size [

	^ self indices size
]
