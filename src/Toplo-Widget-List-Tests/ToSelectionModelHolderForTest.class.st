Class {
	#name : #ToSelectionModelHolderForTest,
	#superclass : #Object,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'selectionModel',
		'eventDispatcher',
		'dataSource',
		'successfulCommand',
		'selectionMode',
		'data'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Command'
}

{ #category : #accessing }
ToSelectionModelHolderForTest >> data [

	^ data
]

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
	data := ToObservableCollection new.
	self dataSource: ToInfiniteObservableCollectionDataSource new.
	self dataSource data: data.
	self selectionMode: ToListMultiSelectionMode new.
	self addEventHandler: ToSelectionRequestEventHandler new.
	self addEventHandler: (BlEventHandler
			 on: ToSelectionResultEvent
			 do: [ :event | self successfulCommand: true ]).
	selectionModel := self defaultSelectionModel.
	selectionModel onInstalledIn: self
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> itemCount [

	^ self dataSource itemCount
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> selecter [ 

	^  self selectionModel newSelecter on: self.

]

{ #category : #accessing }
ToSelectionModelHolderForTest >> selectionMode [

	^ selectionMode
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> selectionMode: aSelectionMode [

	selectionMode := aSelectionMode
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> selectionModel [

	^ selectionModel 
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> successfulCommand [

	^ successfulCommand
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> successfulCommand: anObject [

	successfulCommand := anObject
]
