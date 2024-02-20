Class {
	#name : #ToSelectionModelHolderForTest,
	#superclass : #BlElement,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'selectionModel',
		'dataSource',
		'successfulCommand',
		'data',
		'scrollIndex',
		'selecter'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Selecter'
}

{ #category : #accessing }
ToSelectionModelHolderForTest >> data [

	^ dataSource data
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
	self dataSource: ToObservableCollectionInfiniteDataSource new.
	selectionModel := self defaultSelectionModel.
	selectionModel onInstalledIn: self.
	self addEventHandler: ToCommandEventHandler new.
	self addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | self successfulCommand: true ]).

]

{ #category : #accessing }
ToSelectionModelHolderForTest >> itemCount [

	^ self dataSource itemCount
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> multiSelectionSelecter [

	selecter := ToMultiSelectionModelSelecter new.
	selecter onInstalledIn: self.
	^ selecter
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> noneSelectionSelecter [

	selecter := ToNoneSelectionModelSelecter new.
	selecter onInstalledIn: self.
	^ selecter
]

{ #category : #'event firing' }
ToSelectionModelHolderForTest >> notifySelectionChanged: anEvent [

	self dispatchEvent: anEvent
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> operator [

	| operator |
	operator := ToSelectionModelOperator new.
	operator onInstalledIn: self.
	^ operator
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> scrollIndex [ 

	^ scrollIndex 
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> scrollToIndex: anIndex [

	scrollIndex := anIndex
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> selecter [

	^ selecter
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> selectionModel [

	^ selectionModel 
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> singleSelectionSelecter [

	selecter := ToSingleSelectionModelSelecter new.
	selecter onInstalledIn: self.
	^ selecter
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> successfulCommand [

	^ successfulCommand
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> successfulCommand: anObject [

	successfulCommand := anObject
]
