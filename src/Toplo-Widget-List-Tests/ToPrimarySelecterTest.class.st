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
	element selectionModel: ToPrimarySelectionModel new.
	selecter := ToPrimarySelecter
		            selectionModel: element selectionModel
		            operator: ToStandardSelectionModelOperator primary.
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
	self assert: element selectionModel isEmpty
]

{ #category : #tests }
ToPrimarySelecterTest >> testIntervalsIn [

	| intervals |
	intervals := selecter operator intervalsIn: #().
	self assert: intervals isEmpty.
	intervals := selecter operator intervalsIn: {2}.
	self assert: intervals size equals: 1.
	intervals := selecter operator intervalsIn: {2. 6}.
	self assert: intervals size equals: 2.
	intervals := selecter operator intervalsIn: {2. 6. 9}.
	self assert: intervals size equals: 3.
	
]

{ #category : #tests }
ToPrimarySelecterTest >> testIntervalsIn2 [

	| intervals |
	intervals := selecter operator intervalsIn: {2. 3. 6}.
	self assert: intervals size equals: 2.
	self assert: intervals first equals: (2 to: 3)	.
	self assert: intervals second equals: (6 to: 6).
	
	intervals := selecter operator intervalsIn: {2. 3. 5. 6. 7}.
	self assert: intervals size equals: 2.
	self assert: intervals first equals: (2 to: 3)	.
	self assert: intervals second equals: (5 to: 7).

	intervals := selecter operator intervalsIn: {2. 3. 5. 6. 7. 10}.
	self assert: intervals size equals: 3.
	self assert: intervals first equals: (2 to: 3)	.
	self assert: intervals second equals: (5 to: 7).
	self assert: intervals third equals: (10 to: 10).
	
	intervals := selecter operator intervalsIn: {2. 5. 6. 7. 10}.
	self assert: intervals size equals: 3.
	self assert: intervals first equals: (2 to: 2)	.
	self assert: intervals second equals: (5 to: 7).
	self assert: intervals third equals: (10 to: 10)
]
