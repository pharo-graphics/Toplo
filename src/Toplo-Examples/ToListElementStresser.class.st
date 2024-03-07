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

{ #category : #actions }
ToListElementStresser >> actionAddAfterIndexIn: aList [

	aList dataAccessor
		add: 'Goodbye ' , self nextCounter asString
		afterIndex: (self randIndexIn: aList)
]

{ #category : #actions }
ToListElementStresser >> actionAtPutIn: aList [

	| idx current |
	idx := self randIndexIn: aList.
	idx isZero ifFalse: [
		current := aList dataAccessor at: idx.
		aList dataAccessor at: idx put: current , ' ' , self nextCounter asString ]
]

{ #category : #actions }
ToListElementStresser >> actionDeselectIndexIn: aList [

	| idx |
	idx := self randIndexIn: aList.
	idx isZero ifFalse: [ aList selecter deselectIndex: idx ]
]

{ #category : #actions }
ToListElementStresser >> actionDisableIndexIn: aList [

	| idx |
	idx := self randIndexIn: aList.
	idx isZero ifFalse: [ aList disabledSelecter selectIndex: idx ]
]

{ #category : #actions }
ToListElementStresser >> actionEnableIndexIn: aList [

	| idx |
	idx := self randIndexIn: aList.
	idx isZero ifFalse: [ aList disabledSelecter deselectIndex: idx ]
]

{ #category : #actions }
ToListElementStresser >> actionRemoveAtIn: aList [

	| idx |
	idx := self randIndexIn: aList.
	idx isZero ifFalse: [ aList dataAccessor removeAt: idx ]
]

{ #category : #actions }
ToListElementStresser >> actionSelectIndexIn: aList [

	| idx |
	idx := self randIndexIn: aList.
	idx isZero ifFalse: [ aList selecter selectIndex: idx ]
]

{ #category : #actions }
ToListElementStresser >> actionSelectableIndexIn: aList [

	| idx |
	idx := self randIndexIn: aList.
	idx isZero ifFalse: [ aList unselectableSelecter deselectIndex: idx ]
]

{ #category : #actions }
ToListElementStresser >> actionUnselectableIndexIn: aList [

	| idx |
	idx := self randIndexIn: aList.
	idx isZero ifFalse: [ aList unselectableSelecter selectIndex: idx ]
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
		| listAndNameAssoc tab |
		listAndNameAssoc := self newStressedListNumber: i.
		tab := ToTab new.
		tab labelText: listAndNameAssoc value.
		tab paneBuilder: [ :pane :theTabPane |
			pane addChild: listAndNameAssoc key ].
		tabsPanel addTab: tab ]
]

{ #category : #private }
ToListElementStresser >> maxListSize [

	^ 5000

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

	^ 5

]

{ #category : #private }
ToListElementStresser >> newStressedListNumber: aNumber [

	| list process size ident priority |
	rand := Random new.

	list := ToListElement new.
	priority := self nextProcessPriorityForListNumber: aNumber.
	size := self nextSizeForListNumber: aNumber.
	ident := String streamContents: [ :stream |
		         stream nextPutAll:
			         ((String loremIpsum: self maxTab * 1000) substrings at:
				          aNumber).
		         stream nextPutAll: ' ('.
		         stream nextPutAll: priority asString.
		         stream nextPutAll: ') '.
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
		           self selectActionsToRun shuffled do: [ :act |
			           self perform: act with: list ].
		           50 milliSeconds wait ] ] newProcess.

	process name: self class name.
	process priority: priority.

	self tabsPanel
		addEventHandlerOn: BlElementAddedToSceneGraphEvent
		do: [ :event | process resume ].
	self tabsPanel
		addEventHandlerOn: BlElementRemovedFromSceneGraphEvent
		do: [ :event | process terminate ].

	^ list -> ident
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
		  ifFalse: [ ((rand nextIntegerBetween: 1 and: s) max: 1) min: s]
]

{ #category : #running }
ToListElementStresser >> run [

	self tabsPanel openInSpace
]

{ #category : #running }
ToListElementStresser >> selectActionsToRun [

	^ self class selectors select: [ :selector | selector beginsWith: #action ]
]

{ #category : #accessing }
ToListElementStresser >> tabsPanel [

	^ tabsPanel
]
