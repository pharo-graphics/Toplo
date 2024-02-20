Class {
	#name : #ToSelectionModelOperatorTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'holder',
		'selectionChanged',
		'operator'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Selecter'
}

{ #category : #running }
ToSelectionModelOperatorTest >> setUp [

	super setUp.
	selectionChanged := false.
	holder := ToSelectionModelHolderForTest new.
	space root addChild: holder.
	holder data addAll: (1 to: 1000).
	holder addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | selectionChanged := true ]).
	operator := holder operator
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testAddCommand [

	| selChangedEvent cmd |
	holder addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | selChangedEvent := event ]).

	operator addCommand: (cmd := ToWholeSelectionCommand new
			        operation: ToAddSelectionOperation new;
			        yourself).
	self waitTestingSpaces.
	self assert: holder selectionModel isNotEmpty.
	self assert: selChangedEvent notNil
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testDeselectTo [

	| cmd |
	holder selectionModel selectIndex: holder itemCount + 1.
	self assert: holder selectionModel selectedIndexes equals: #( ).
	operator addCommand: (cmd := ToIntervalSelectionCommand new
			        from: 1;
			        to: holder itemCount + 1;
			        operation: ToRemoveSelectionOperation new;
			        yourself).
	self waitTestingSpaces.
	self assert: holder selectionModel isEmpty
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testDeselectToWithChangedItemCount [

	| cmd to |
	to := holder itemCount + 1.
	holder selectionModel itemCountGetter: to.
	holder selectionModel selectIndex: to.
	self assert: holder selectionModel selectedIndexes equals: { to }.
	holder selectionModel itemCountGetter: 0.
	self assert: holder selectionModel itemCount equals: 0.
	operator addCommand: (cmd := ToIntervalSelectionCommand new
			        from: 1;
			        to: to;
			        operation: ToRemoveSelectionOperation new;
			        yourself).
	self waitTestingSpaces.
	self assert: holder selectionModel isEmpty
]
