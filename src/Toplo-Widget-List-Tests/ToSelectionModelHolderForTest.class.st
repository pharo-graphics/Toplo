Class {
	#name : #ToSelectionModelHolderForTest,
	#superclass : #BlElement,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'selectionModel',
		'dataSource',
		'successfulCommand',
		'data'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Model'
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
	selectionModel := self defaultSelectionModel.
	selectionModel onInstalledIn: self.
	self addEventHandler: ToSelectionModelCommandEventHandler new.
	self addEventHandler: (BlEventHandler
			 on: ToSelectionResultEvent
			 do: [ :event | self successfulCommand: true ]).

]

{ #category : #accessing }
ToSelectionModelHolderForTest >> itemCount [

	^ self dataSource itemCount
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> operator [ 

	^  ToSelectionModelOperator new requester: self; yourself

]

{ #category : #accessing }
ToSelectionModelHolderForTest >> selecter [

	^ ToSelectionModelSelecter new
		  operator: self operator;
		  target: self;
		  yourself
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