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

	^ dataSource
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
	self dataSource: ToInfiniteCollectionDataSource new.
	infinite := ToInfiniteElement onListElement: ToListElement new.
	self addChild: infinite.
	selectionModel := self defaultSelectionModel.
	selectionModel onInstalledIn: self.
	unselectableSelectionModel := self defaultSelectionModel.
	unselectableSelectionModel onInstalledIn: self.
	self addEventHandler: ToElementCommandEventHandler new.
	operator := ToPrimarySelectionModelOperator on: self.
	self addEventHandler: (BlEventHandler
			 on: ToListPrimarySelectionChangedEvent
			 do: [ :event | self successfulCommand: true ])
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

	^ (ToCompositeSelecter
		   selectionModel: self selectionModel
		   operator: operator) multiple: true
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> nodeContainer [

	^ infinite
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> noneSelectionSelecter [

	^ selecter := ToListElementSelecter new
		              enabled: false;
		              yourself
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

	^ ToPrimarySelectionModelOperator on: self
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

	^ (ToCompositeSelecter
		   selectionModel: self selectionModel
		   operator: operator) multiple: false
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
