Class {
	#name : #ToSelectionModelHolderForTest,
	#superclass : #BlElement,
	#traits : 'TBlEventTarget + TToPrenotificationTarget',
	#classTraits : 'TBlEventTarget classTrait + TToPrenotificationTarget classTrait',
	#instVars : [
		'selectionModel',
		'dataSource',
		'successfulCommand',
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
	selectionModel on: self.
	unselectableSelectionModel := self defaultSelectionModel.
	unselectableSelectionModel on: self.
	self addEventHandler: ToElementCommandEventHandler new.
	operator := ToPrimarySelectionModelOperator new.
	self addEventHandler: (BlEventHandler
			 on: ToListPrimarySelectionChangedEvent
			 do: [ :event | self successfulCommand: true ])
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> innerContainer [

	^ infinite
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

	| s |
	s := ToCompositeSelecter
		     selectionModel: self selectionModel
		     operator: operator.
	s multiple: true.
	s eventTarget: self.
	^ s
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

	^ ToPrimarySelectionModelOperator new
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> scrollIndex [ 

	^ scrollIndex 
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> scrollToDataSourcePosition: anIndex [

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

	| s |
	s := ToCompositeSelecter
		     selectionModel: self selectionModel
		     operator: operator.
	s multiple: false.
	s eventTarget: self.
	^ s
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
