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
		'selecter',
		'operator',
		'unselectableSelectionModel',
		'infinite'
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

	^ ToBasicListSelectionModel new
]

{ #category : #'event management accessing' }
ToSelectionModelHolderForTest >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> infinite [

	^ infinite
]

{ #category : #initialization }
ToSelectionModelHolderForTest >> initialize [

	super initialize.
	self dataSource: ToObservableCollectionInfiniteDataSource new.
	infinite := ToInfiniteElement onListElement: ToListElement new.
	self addChild: infinite.
	selectionModel := self defaultSelectionModel.
	selectionModel onInstalledIn: self.
	unselectableSelectionModel := self defaultSelectionModel.
	unselectableSelectionModel onInstalledIn: self.
	self addEventHandler: ToElementCommandEventHandler new.
	operator := ToPrimarySelectionModelOperator new.
	operator onInstalledIn: self.
	operator selectionModel: self selectionModel.
	self addEventHandler: (BlEventHandler
			 on: ToListPrimarySelectionChangedEvent
			 do: [ :event | self successfulCommand: true ]).

]

{ #category : #accessing }
ToSelectionModelHolderForTest >> itemCount [

	^ self dataSource itemCount
]

{ #category : #'mutual exclusion' }
ToSelectionModelHolderForTest >> layoutCritical: aBlock [

	aBlock value
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> multiSelectionSelecter [

	selecter := ToMultiSelectionModelSelecter new.
	selecter onInstalledIn: self.
	selecter operator: operator.
	^ selecter
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> noneSelectionSelecter [

	selecter := ToNoneSelectionModelSelecter new.
	selecter onInstalledIn: self.
	^ selecter
]

{ #category : #'event firing' }
ToSelectionModelHolderForTest >> notifyPrimarySelectionChanged: anEvent [

	self dispatchEvent: anEvent
]

{ #category : #'event firing' }
ToSelectionModelHolderForTest >> notifyUnselectableSelectionChanged: anEvent [

	self dispatchEvent: anEvent
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> operator [

	| operator |
	operator := ToPrimarySelectionModelOperator new.
	operator onInstalledIn: self.
	operator selectionModel: self selectionModel.
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
	selecter operator: operator.
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

{ #category : #accessing }
ToSelectionModelHolderForTest >> unselectableSelectionModel [

	^ unselectableSelectionModel 
]
