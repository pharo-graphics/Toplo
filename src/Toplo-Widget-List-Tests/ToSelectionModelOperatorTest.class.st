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
