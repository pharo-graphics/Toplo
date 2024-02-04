Class {
	#name : #ToSelectionModelHolderForTest,
	#superclass : #Object,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'selectionModel',
		'eventDispatcher',
		'selectionStrategy',
		'dataSource',
		'successfulCommand'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Command'
}

{ #category : #accessing }
ToSelectionModelHolderForTest >> dataSource [

	^ dataSource
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> dataSource: aDataSource [

	dataSource := aDataSource
]

{ #category : #initialization }
ToSelectionModelHolderForTest >> defaultSelectionModel [

	^ ToSelectionModel new
]

{ #category : #'event management accessing' }
ToSelectionModelHolderForTest >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #initialization }
ToSelectionModelHolderForTest >> initialize [

	super initialize.
	eventDispatcher := BlDirectEventDispatcher on: self.
	self selectionStrategy: ToListSelectionStrategy new.
	self selectionStrategy mode: ToListMultiSelectionMode new.
	self addEventHandler: selectionStrategy.
	self addEventHandler: (BlEventHandler
			 on: ToSelectionResultEvent
			 do: [ :event | self successfulCommand: true ]).
	selectionModel := self defaultSelectionModel 
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> selecter [ 

	^  self selectionModel newSelecter on: self.

]

{ #category : #accessing }
ToSelectionModelHolderForTest >> selectionHasChanged [

	^ selectionStrategy selectionHasChanged
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> selectionModel [

	^ selectionModel 
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> selectionStrategy [

	^ selectionStrategy
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> selectionStrategy: aToListSelectionStrategy [

	selectionStrategy := aToListSelectionStrategy
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> successfulCommand [

	^ successfulCommand
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> successfulCommand: anObject [

	successfulCommand := anObject
]
