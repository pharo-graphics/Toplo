Class {
	#name : #ToPrimarySelecterTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'selecter',
		'element'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Selecter'
}

{ #category : #running }
ToPrimarySelecterTest >> setUp [

	super setUp.
	element := ToSelecterEventTargetStub new.
	space root addChild: element.

	element selectionModel: ToPrimarySelectionModel new.
	selecter := ToPrimarySelecter new
		            selectionModel: element selectionModel;
		            selectionChangedEventClass:
			            ToListPrimarySelectionChangedEvent;
		            yourself.
	selecter commandApplicationStrategy: BlQueueBasedCommandApplicationStrategy new.
	selecter onInstalledIn: element
]

{ #category : #tests }
ToPrimarySelecterTest >> testAddCommand [

	| selChangedEvent cmd |
	element addEventHandler: (BlEventHandler
			 on: ToListPrimarySelectionChangedEvent
			 do: [ :event | selChangedEvent := event ]).
	element selectionModel deselectAll.
	self assert: element selectionModel isEmpty.
	selecter addCommand: (cmd := ToWholeSelectionCommand new
			        operation: ToAddSelectionOperation new;
			        yourself).
	self waitTestingSpaces.
	self assert: element selectionModel isNotEmpty.
	self assert: selChangedEvent notNil
]

{ #category : #tests }
ToPrimarySelecterTest >> testDeselectTo [

	| cmd |
	element selectionModel selectIndex: element itemCount + 1.
	self assert: element selectionModel selectedIndexes equals: #( 101 ).
	selecter addCommand: (cmd := ToIntervalSelectionCommand new
			        from: 1;
			        to: element itemCount + 1;
			        operation: ToRemoveSelectionOperation new;
			        yourself).
	self waitTestingSpaces.
	self assert: element selectionModel isEmpty
]

{ #category : #tests }
ToPrimarySelecterTest >> testDeselectToWithChangedItemCount [

	| cmd to |
	to := element itemCount + 1.
	element selectionModel itemCountGetter: to.
	element selectionModel selectIndex: to.
	self assert: element selectionModel selectedIndexes equals: { to }.
	element selectionModel itemCountGetter: 0.
	self assert: element selectionModel itemCount equals: 0.
	selecter addCommand: (cmd := ToIntervalSelectionCommand new
			        from: 1;
			        to: to;
			        operation: ToRemoveSelectionOperation new;
			        yourself).
	self waitTestingSpaces.
	self assert: element selectionModel isEmpty
]
