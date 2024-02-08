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
		'selecter',
		'scrollIndex'
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
	self addEventHandler: ToListSelectionModelEventHandler new.
	self addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | self successfulCommand: true ]).

]

{ #category : #accessing }
ToSelectionModelHolderForTest >> itemCount [

	^ self dataSource itemCount
]

{ #category : #accessing }
ToSelectionModelHolderForTest >> operator [ 

	^  ToSelectionModelOperator new

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

	^ selecter ifNil: [selecter := ToSelectionModelSelecter new
		  target: self;
		  yourself ]
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
