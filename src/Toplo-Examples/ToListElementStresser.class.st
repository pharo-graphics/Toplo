Class {
	#name : #ToListElementStresser,
	#superclass : #Object,
	#instVars : [
		'tabsPanel',
		'maxTab',
		'maxRound',
		'rand',
		'counter'
	],
	#category : #'Toplo-Examples'
}

{ #category : #running }
ToListElementStresser class >> run [

	<script>

	self new run

]

{ #category : #running }
ToListElementStresser >> actionsToRunIn: aList [

	^ {
		  [ self atPutIn: aList ].
		  [ self addAfterIndexIn: aList ].
		  [ self addAfterIndexIn: aList ].
		  [ self selectIndexIn: aList ].
		  [ self deselectIndexIn: aList ].
		  [ self disableIndexIn: aList ].
		  [ self unselectableIndexIn: aList ].
		  [ self enableIndexIn: aList ].
		  [ self selectableIndexIn: aList ].
		  [ self removeAtIn: aList ].
		  [ self removeAtIn: aList ] }
]

{ #category : #actions }
ToListElementStresser >> addAfterIndexIn: aList [

	aList dataAccessor
		add: 'Goodbye ' , self nextCounter asString
		afterIndex: (self randIndexIn: aList)
]

{ #category : #actions }
ToListElementStresser >> atPutIn: aList [

	| idx current |
	idx := self randIndexIn: aList.
	idx isZero ifFalse: [
		current := aList dataAccessor at: idx.
		aList dataAccessor at: idx put: current , ' ' , self nextCounter asString ]
]

{ #category : #actions }
ToListElementStresser >> deselectIndexIn: aList [

	| idx |
	idx := self randIndexIn: aList.
	idx isZero ifFalse: [ aList selecter deselectIndex: idx ]
]

{ #category : #actions }
ToListElementStresser >> disableIndexIn: aList [

	| idx |
	idx := self randIndexIn: aList.
	idx isZero ifFalse: [ aList disabledSelecter selectIndex: idx ]
]

{ #category : #actions }
ToListElementStresser >> enableIndexIn: aList [

	| idx |
	idx := self randIndexIn: aList.
	idx isZero ifFalse: [ aList disabledSelecter deselectIndex: idx ]
]

{ #category : #initialization }
ToListElementStresser >> initialize [

	| priorities |
	super initialize.

	counter := 0.
	rand := Random new.
	priorities := {
		              Processor lowestPriority.
		              Processor userBackgroundPriority.
		              Processor systemBackgroundPriority }.

	tabsPanel := ToTabPane new.

	1 to: self maxTab do: [ :i |
		| ident size list tab |
		size := rand nextIntegerBetween: 1 and: (i even
				         ifTrue: [ 20 ]
				         ifFalse: [ 3000 ]).
		ident := String streamContents: [ :stream |
			         stream nextPutAll:
				         ((String loremIpsum: self maxTab * 1000) substrings at: i).
			         stream nextPutAll: ' '.
			         stream nextPutAll: size asString ].

		list := self
			        newStressedListNumber: i.
		tab := ToTab new.
		tab labelText: ident.
		tab paneBuilder: [ :pane :theTabPane | pane addChild: list ].
		tabsPanel addTab: tab ]
]

{ #category : #private }
ToListElementStresser >> maxListSize [

	^ 3000

]

{ #category : #accessing }
ToListElementStresser >> maxRound [

	^ maxRound ifNil: [ maxRound := 10000 ]
]

{ #category : #accessing }
ToListElementStresser >> maxRound: anObject [

	maxRound := anObject
]

{ #category : #accessing }
ToListElementStresser >> maxTab [

	^ maxTab ifNil: [ maxTab := 10 ]
]

{ #category : #accessing }
ToListElementStresser >> maxTab: anObject [

	maxTab := anObject
]

{ #category : #private }
ToListElementStresser >> minListSize [

	^ 20

]

{ #category : #private }
ToListElementStresser >> newStressedListNumber: aNumber [

	| list process size ident |
	rand := Random new.

	list := ToListElement new.
	size := self nextSizeForListNumber: aNumber.
	ident := String streamContents: [ :stream |
		         stream nextPutAll:
			         ((String loremIpsum: self maxTab * 1000) substrings at:
				          aNumber).
		         stream nextPutAll: ' '.
		         stream nextPutAll: size asString ].

	list nodeBuilder: [ :node :holder |
		holder isUnselectable ifTrue: [ node background: Color red ].
		node addChild: (ToLabel text: holder dataItem asString) hMatchParent ].

	list dataAccessor addAll:
		((1 to: size) collect: [ :i | 'Hello ' , i asString ]).

	list withRowNumbers.
	list matchParent.

	process := [
	           | round |
	           round := 0.
	           self maxRound timesRepeat: [
		           round := round + 1.
		           (round \\ 100) isZero ifTrue: [
			           (ident , ' round: ') trace.
			           round traceCr ].
		           (self actionsToRunIn: list) shuffled do: [ :act |
			           act value ].
		           50 milliSeconds wait ] ] newProcess.

	process name: self class name.
	process priority: (self nextProcessPriorityForListNumber: aNumber).

	self tabsPanel
		addEventHandlerOn: BlElementAddedToSceneGraphEvent
		do: [ :event | process resume ].
	self tabsPanel
		addEventHandlerOn: BlElementRemovedFromSceneGraphEvent
		do: [ :event | process terminate ].

	^ list
]

{ #category : #private }
ToListElementStresser >> nextCounter [

	counter := counter + 1.
	^ counter
]

{ #category : #private }
ToListElementStresser >> nextProcessPriorityForListNumber: aNumber [

	| priorities |
	priorities := {
		              Processor lowestPriority.
		              Processor userBackgroundPriority.
		              Processor systemBackgroundPriority }.

	^ priorities at: aNumber \\ priorities size + 1
]

{ #category : #private }
ToListElementStresser >> nextSizeForListNumber: aNumber [

	^ rand nextIntegerBetween: 1 and: (aNumber even
			   ifTrue: [ self minListSize ]
			   ifFalse: [ self maxListSize ])
]

{ #category : #private }
ToListElementStresser >> randIndexIn: aList [

	| s |
	s := aList dataAccessor size.
	^ s isZero
		  ifTrue: [ 0 ]
		  ifFalse: [ rand nextIntegerBetween: 1 and: s ]
]

{ #category : #actions }
ToListElementStresser >> removeAtIn: aList [

	| idx |
	idx := self randIndexIn: aList.
	idx isZero ifFalse: [ aList dataAccessor removeAt: idx ]
]

{ #category : #running }
ToListElementStresser >> run [

	self tabsPanel openInSpace
]

{ #category : #actions }
ToListElementStresser >> selectIndexIn: aList [

	| idx |
	idx := self randIndexIn: aList.
	idx isZero ifFalse: [ aList selecter selectIndex: idx ]
]

{ #category : #actions }
ToListElementStresser >> selectableIndexIn: aList [

	| idx |
	idx := self randIndexIn: aList.
	idx isZero ifFalse: [ aList unselectableSelecter deselectIndex: idx ]
]

{ #category : #accessing }
ToListElementStresser >> tabsPanel [

	^ tabsPanel
]

{ #category : #actions }
ToListElementStresser >> unselectableIndexIn: aList [

	| idx |
	idx := self randIndexIn: aList.
	idx isZero ifFalse: [ aList unselectableSelecter selectIndex: idx ]
]
