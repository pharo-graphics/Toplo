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
			 on: ToListPrimarySelectionChangedEvent
			 do: [ :event | selectionChanged := true ]).
	operator := holder operator
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testAddCommand [

	| selChangedEvent cmd |
	holder addEventHandler: (BlEventHandler
			 on: ToListPrimarySelectionChangedEvent
			 do: [ :event | selChangedEvent := event ]).

	operator addCommand: (cmd := ToWholeSelectionCommand new
			        operator: operator;
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
	self assert: holder selectionModel selectedIndexes equals: #( 1001 ).
	operator addCommand: (cmd := ToIntervalSelectionCommand new
			        operator: operator;
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
			        operator: operator;
			        from: 1;
			        to: to;
			        operation: ToRemoveSelectionOperation new;
			        yourself).
	self waitTestingSpaces.
	self assert: holder selectionModel isEmpty
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testIntervalsIn [

	| intervals |
	intervals := operator intervalsIn: #().
	self assert: intervals isEmpty.
	intervals := operator intervalsIn: {2}.
	self assert: intervals size equals: 1.
	intervals := operator intervalsIn: {2. 6}.
	self assert: intervals size equals: 2.
	intervals := operator intervalsIn: {2. 6. 9}.
	self assert: intervals size equals: 3.
	
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testIntervalsIn2 [

	| intervals |
	intervals := operator intervalsIn: {2. 3. 6}.
	self assert: intervals size equals: 2.
	self assert: intervals first equals: (2 to: 3)	.
	self assert: intervals second equals: (6 to: 6).
	
	intervals := operator intervalsIn: {2. 3. 5. 6. 7}.
	self assert: intervals size equals: 2.
	self assert: intervals first equals: (2 to: 3)	.
	self assert: intervals second equals: (5 to: 7).

	intervals := operator intervalsIn: {2. 3. 5. 6. 7. 10}.
	self assert: intervals size equals: 3.
	self assert: intervals first equals: (2 to: 3)	.
	self assert: intervals second equals: (5 to: 7).
	self assert: intervals third equals: (10 to: 10).
	
	intervals := operator intervalsIn: {2. 5. 6. 7. 10}.
	self assert: intervals size equals: 3.
	self assert: intervals first equals: (2 to: 2)	.
	self assert: intervals second equals: (5 to: 7).
	self assert: intervals third equals: (10 to: 10)
]
