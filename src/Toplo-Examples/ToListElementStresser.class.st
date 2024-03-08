Class {
	#name : #ToListElementStresser,
	#superclass : #Object,
	#instVars : [
		'tabsPanel',
		'maxTab',
		'maxRound',
		'rand',
		'counter',
		'listIdentifiers'
	],
	#category : #'Toplo-Examples'
}

{ #category : #running }
ToListElementStresser class >> run [

	<script>

	self new run

]

{ #category : #actions }
ToListElementStresser >> _actionFilterResultIn: aList [

	| idx pattern sieve |

		idx := self randIndexIn: aList.
		pattern := idx odd
			           ifTrue: [ '' ]
			           ifFalse: [
				           idx := self randIndexIn: aList.
				           idx even
					           ifTrue: [ 'Hel' ]
					           ifFalse: [ 'Good' ] ].
		sieve := aList userData at: #sieve.
		sieve pattern: pattern 
]

{ #category : #actions }
ToListElementStresser >> _actionShiftSelectionFromIn: aList [

	| nb idx |
	
		nb := self randIndexIn: aList.
		idx := self randIndexIn: aList.
		idx isZero ifFalse: [ aList selecter shiftSelection: nb from: idx ]
]

{ #category : #actions }
ToListElementStresser >> actionAddAfterIndexIn: aList [

	aList dataCritical: [
		aList dataAccessor
			add: 'Goodbye ' , self nextCounter asString
			afterIndex: (self randIndexIn: aList) ]
]

{ #category : #actions }
ToListElementStresser >> actionAtPutIn: aList [

	aList dataCritical: [
		| idx current |
		idx := self randIndexIn: aList.
		idx isZero ifFalse: [
			current := aList dataAccessor at: idx.
			aList dataAccessor
				at: idx
				put: current , ' ' , self nextCounter asString ] ]
]

{ #category : #actions }
ToListElementStresser >> actionDeselectAllIn: aList [

	aList dataCritical: [ aList selecter deselectAll ]
]

{ #category : #actions }
ToListElementStresser >> actionDeselectIndexIn: aList [

	aList dataCritical: [
		| idx |
		idx := self randIndexIn: aList.
		idx isZero ifFalse: [ aList selecter deselectIndex: idx ] ]
]

{ #category : #actions }
ToListElementStresser >> actionDeselectIndexesIn: aList [

	aList dataCritical: [
		| nb selected |
		nb := (self randIndexIn: aList) min: 30.
		nb isZero ifTrue: [ ^ self ].
		selected := (1 to: nb) collect: [ :i | self randIndexIn: aList ].
		aList selecter deselectIndexes: selected ]
]

{ #category : #actions }
ToListElementStresser >> actionDisableIndexIn: aList [

	aList dataCritical: [
		| idx |
		idx := self randIndexIn: aList.
		idx isZero ifFalse: [ aList disabledSelecter selectIndex: idx ] ]
]

{ #category : #actions }
ToListElementStresser >> actionDisableIndexesIn: aList [

	aList dataCritical: [
		| nb selected |
		nb := (self randIndexIn: aList) min: 30.
		nb isZero ifTrue: [ ^ self ].
		selected := (1 to: nb) collect: [ :i | self randIndexIn: aList ].
		aList disabledSelecter selectIndexes: selected ]
]

{ #category : #actions }
ToListElementStresser >> actionEnableIndexIn: aList [

	aList dataCritical: [
		| idx |
		idx := self randIndexIn: aList.
		idx isZero ifFalse: [ aList disabledSelecter deselectIndex: idx ] ]
]

{ #category : #actions }
ToListElementStresser >> actionEnableIndexesIn: aList [

	aList dataCritical: [
		| nb selected |
		nb := (self randIndexIn: aList) min: 30.
		nb isZero ifTrue: [ ^ self ].
		selected := (1 to: nb) collect: [ :i | self randIndexIn: aList ].
		aList disabledSelecter deselectIndexes: selected ]
]

{ #category : #actions }
ToListElementStresser >> actionRemoveAtIn: aList [

	aList dataCritical: [
		| idx |
		idx := self randIndexIn: aList.
		idx isZero ifFalse: [ aList dataAccessor removeAt: idx ] ]
]

{ #category : #actions }
ToListElementStresser >> actionSelectAllIn: aList [

	aList dataCritical: [ aList selecter selectAll ]
]

{ #category : #actions }
ToListElementStresser >> actionSelectIndexIn: aList [

	aList dataCritical: [
		| idx |
		idx := self randIndexIn: aList.
		idx isZero ifFalse: [ aList selecter selectIndex: idx ] ]
]

{ #category : #actions }
ToListElementStresser >> actionSelectIndexeToIn: aList [

	aList dataCritical: [
		| from to |
		from := self randIndexIn: aList.
		to := self randIndexIn: aList.
		(from isZero or: [ to isZero ]) ifTrue: [ ^ self ].
		aList selecter selectIndex: from to: to ]
]

{ #category : #actions }
ToListElementStresser >> actionSelectIndexesIn: aList [

	aList dataCritical: [
		| nb selected |
		nb := (self randIndexIn: aList) min: 30.
		nb isZero ifTrue: [ ^ self ].
		selected := (1 to: nb) collect: [ :i | self randIndexIn: aList ].
		aList selecter selectIndexes: selected ]
]

{ #category : #actions }
ToListElementStresser >> actionSelectOnlyIndexIn: aList [

	aList dataCritical: [
		| idx |
		idx := self randIndexIn: aList.
		idx isZero ifFalse: [ aList selecter selectOnlyIndex: idx ] ]
]

{ #category : #actions }
ToListElementStresser >> actionSelectOnlyIndexesIn: aList [

	aList dataCritical: [
		| nb selected |
		nb := (self randIndexIn: aList) min: 30.
		nb isZero ifTrue: [ ^ self ].
		selected := (1 to: nb) collect: [ :i | self randIndexIn: aList ].
		aList selecter selectOnlyIndexes: selected ]
]

{ #category : #actions }
ToListElementStresser >> actionSelectableIndexIn: aList [

	aList dataCritical: [
		| idx |
		idx := self randIndexIn: aList.
		idx isZero ifFalse: [ aList unselectableSelecter deselectIndex: idx ] ]
]

{ #category : #actions }
ToListElementStresser >> actionSelectableIndexesIn: aList [

	aList dataCritical: [
		| nb selected |
		nb := (self randIndexIn: aList) min: 30.
		nb isZero ifTrue: [ ^ self ].
		selected := (1 to: nb) collect: [ :i | self randIndexIn: aList ].
		aList unselectableSelecter deselectIndexes: selected ]
]

{ #category : #actions }
ToListElementStresser >> actionUnselectableIndexIn: aList [

	aList dataCritical: [
		| idx |
		idx := self randIndexIn: aList.
		idx isZero ifFalse: [ aList unselectableSelecter selectIndex: idx ] ]
]

{ #category : #actions }
ToListElementStresser >> actionUnselectableIndexesIn: aList [

	aList dataCritical: [
		| nb selected |
		nb := (self randIndexIn: aList) min: 30.
		nb isZero ifTrue: [ ^ self ].
		selected := (1 to: nb) collect: [ :i | self randIndexIn: aList ].
		aList unselectableSelecter selectIndexes: selected ]
]

{ #category : #private }
ToListElementStresser >> afterRoundInList: aList [

	self interRoundWaitDuration wait 
]

{ #category : #initialization }
ToListElementStresser >> initialize [

	| tabSelectionProcess |
	super initialize.

	counter := 0.
	rand := Random new.

	tabsPanel := ToTabPane new.
	listIdentifiers := Array new: self maxTab.

	1 to: self maxTab do: [ :i |
		| listAndNameAssoc tab |
		listAndNameAssoc := self newStressedListNumber: i.
		tab := ToTab new.
		tab labelText: listAndNameAssoc value.
		tab firstChild withNullSkin.
		tab addChild: ToLabel new withNullSkin at: 2.
		tab paneBuilder: [ :pane :theTabPane |
			pane addChild: listAndNameAssoc key ].
		tabsPanel addTab: tab ].

	tabSelectionProcess := [
	                       1 to: self maxRound do: [ :round |
		                       | idx |
		                       idx := (round \\ self maxTab + 1 max: 1)
			                              min: self maxTab.
		                       self tabsPanel enqueueTask:
			                       (BlTaskAction new action: [
				                        (self tabsPanel tabs at: idx) check ]).
		                       6 seconds wait ] ] newProcess.

	tabSelectionProcess name: self class name.
	tabSelectionProcess priority: Processor systemBackgroundPriority.

	self tabsPanel
		addEventHandlerOn: BlElementAddedToSceneGraphEvent
		do: [ :event | tabSelectionProcess resume ].
	self tabsPanel
		addEventHandlerOn: BlElementRemovedFromSceneGraphEvent
		do: [ :event | tabSelectionProcess terminate ]
]

{ #category : #accessing }
ToListElementStresser >> interRoundWaitDuration [

	^ 50 milliSeconds 
]

{ #category : #accessing }
ToListElementStresser >> maxListSize [

	^ 5000

]

{ #category : #accessing }
ToListElementStresser >> maxRound [

	^ maxRound ifNil: [ maxRound := 15000 ]
]

{ #category : #accessing }
ToListElementStresser >> maxRound: anObject [

	maxRound := anObject
]

{ #category : #accessing }
ToListElementStresser >> maxTab [

	^ maxTab ifNil: [ maxTab := 6 ]
]

{ #category : #accessing }
ToListElementStresser >> maxTab: anObject [

	maxTab := anObject
]

{ #category : #accessing }
ToListElementStresser >> minListSize [

	^ 20

]

{ #category : #initialization }
ToListElementStresser >> newStressedListNumber: aNumber [

	| list process size ident priority suffix sieve |
	rand := Random new.

	list := ToListElement new.
	sieve := ToListElementSieve new.
	sieve onInstalledIn: list.
	list userData at: #sieve put: sieve.
	
	priority := self nextProcessPriorityForListNumber: aNumber.
	size := self nextSizeForListNumber: aNumber.
	ident := (String loremIpsum: self maxTab * 1000) substrings at:
		         aNumber.
	ident := ident trimRight: [ :char | char isAlphaNumeric not ].

	suffix := String streamContents: [ :stream |
		          stream nextPutAll: ' ('.
		          stream nextPutAll: priority asString.
		          stream nextPutAll: ') '.
		          stream nextPutAll: size asString.
		          stream nextPutAll: ' ' ].

	listIdentifiers
		at: aNumber
		put: ident asRopedText bold , suffix asRopedText.

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
		           self processingRound: round inList: list number: aNumber.
		           self afterRoundInList: list ].
	           self processEndInList: list number: aNumber ] newProcess.

	process name: self class name.
	process priority: priority.

	self tabsPanel
		addEventHandlerOn: BlElementAddedToSceneGraphEvent
		do: [ :event | process resume ].
	self tabsPanel
		addEventHandlerOn: BlElementRemovedFromSceneGraphEvent
		do: [ :event | process terminate ].

	^ list -> (listIdentifiers at: aNumber)
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

{ #category : #running }
ToListElementStresser >> processEndInList: aList number: aNumber [

	| tab |
	tab := self tabsPanel tabs at: aNumber.
	self tabsPanel enqueueTask: (BlTaskAction new action: [
			 tab firstChild text foreground: Color green muchDarker.
			 tab firstChild textChanged ])
]

{ #category : #running }
ToListElementStresser >> processingRound: aRound inList: aList number: aNumber [

	| tab s |
	tab := self tabsPanel tabs at: aNumber.
	s := ' [' asRopedText , aRound asString asRopedText bold
	     , ('/' , self maxRound asString , ']') asRopedText.

	self tabsPanel enqueueTask: (BlTaskAction new action: [
			 (tab childAt: 2) text: s.
			 (tab childAt: 2) textChanged ]).

	self selectActionsToRun shuffled do: [ :act |
		"act traceCr."
		self perform: act with: aList ]
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

	self tabsPanel openInSpace.
"	self tabsPanel inspect"
]

{ #category : #running }
ToListElementStresser >> selectActionsToRun [

	^ self class selectors select: [ :selector | selector beginsWith: #action ]
]

{ #category : #accessing }
ToListElementStresser >> tabsPanel [

	^ tabsPanel
]
