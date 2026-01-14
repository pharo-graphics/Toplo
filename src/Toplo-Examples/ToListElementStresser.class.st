Class {
	#name : #ToListElementStresser,
	#superclass : #Object,
	#instVars : [
		'commandApplicationStrategy',
		'tabsPanel',
		'maxTab',
		'maxRound',
		'rand',
		'counter',
		'listIdentifiers',
		'maxPrimaryIntervals',
		'maxNbTasks',
		'endTime',
		'startTime'
	],
	#category : #'Toplo-Examples-Stressers'
}

{ #category : #running }
ToListElementStresser class >> run [

	<script>

	self new run

]

{ #category : #running }
ToListElementStresser class >> runInSDL [

	<script>
	self new runInHost: BlOSWindowSDL2Host new
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
				           ifTrue: [ 'G' ]
				           ifFalse: [ 'H' ] ].
	sieve := aList userData at: #sieve.
	sieve pattern: pattern
]

{ #category : #actions }
ToListElementStresser >> _actionHiddenAllIn: aList [

	aList hiddenSelecter selectAll
]

{ #category : #actions }
ToListElementStresser >> _actionHiddenIndexesIn: aList [

	| nb selected |
	nb := (self randIndexIn: aList) min: 30.
	nb isZero ifTrue: [ ^ self ].
	selected := (1 to: nb) collect: [ :i | self randIndexIn: aList ].
	aList hiddenSelecter selectIndexes: selected
]

{ #category : #actions }
ToListElementStresser >> _actionReplaceAllIn: aList [

	| size |
	size := self nextSizeForListNumber: 0.
	aList dataAccessor removeAll.
	aList dataAccessor addAll:
		((1 to: size) collect: [ :i | 'Hello ' , i asString ])
]

{ #category : #actions }
ToListElementStresser >> _actionUnhiddenAllIn: aList [

	aList hiddenSelecter deselectAll
]

{ #category : #actions }
ToListElementStresser >> _actionUnhiddenIndexesIn: aList [

	| nb selected |
	nb := (self randIndexIn: aList) min: 30.
	nb isZero ifTrue: [ ^ self ].
	selected := (1 to: nb) collect: [ :i | self randIndexIn: aList ].
	aList hiddenSelecter deselectIndexes: selected
]

{ #category : #actions }
ToListElementStresser >> actionAddAfterIndexIn: aList [

	aList dataAccessor
		add: 'Goodbye ' , self nextCounter asString
		afterIndex: (self randIndexIn: aList)
]

{ #category : #actions }
ToListElementStresser >> actionAddAllIn: aList [

	| size |
	size := self nextSizeForListNumber: 0.
	aList dataAccessor addAll:
		((1 to: size) collect: [ :i | 'Hello ' , i asString ])
]

{ #category : #actions }
ToListElementStresser >> actionAtPutIn: aList [

	| idx current |
	idx := self randIndexIn: aList.
	idx isZero ifTrue: [ ^ self ].
	current := aList dataAccessor at: idx.
	aList dataAccessor
		at: idx
		put: current , ' ' , self nextCounter asString
]

{ #category : #actions }
ToListElementStresser >> actionDeselectAllIn: aList [

	aList selecter deselectAll
]

{ #category : #actions }
ToListElementStresser >> actionDeselectIndexIn: aList [

	| idx |
	idx := self randIndexIn: aList.
	idx isZero ifFalse: [ aList selecter deselectIndex: idx ]
]

{ #category : #actions }
ToListElementStresser >> actionDeselectIndexesIn: aList [

	| nb selected |
	nb := (self randIndexIn: aList) min: 30.
	nb isZero ifTrue: [ ^ self ].
	selected := (1 to: nb) collect: [ :i | self randIndexIn: aList ].
	aList selecter deselectIndexes: selected
]

{ #category : #actions }
ToListElementStresser >> actionRemoveAllIn: aList [

	aList dataAccessor removeAll
]

{ #category : #actions }
ToListElementStresser >> actionRemoveAtIn: aList [

	| idx |
	idx := self randIndexIn: aList.
	idx isZero ifFalse: [ aList dataAccessor removeAt: idx ]
]

{ #category : #actions }
ToListElementStresser >> actionSelectAllIn: aList [

	aList selecter selectAll
]

{ #category : #actions }
ToListElementStresser >> actionSelectIndexIn: aList [

	| idx |
	idx := self randIndexIn: aList.
	idx isZero ifFalse: [ aList selecter selectIndex: idx ]
]

{ #category : #actions }
ToListElementStresser >> actionSelectIndexeToIn: aList [

	| from to |
	from := self randIndexIn: aList.
	to := self randIndexIn: aList.
	(from isZero or: [ to isZero ]) ifTrue: [ ^ self ].
	aList selecter selectIndex: from to: to
]

{ #category : #actions }
ToListElementStresser >> actionSelectIndexesIn: aList [

	| nb selected |
	nb := (self randIndexIn: aList) min: 30.
	nb isZero ifTrue: [ ^ self ].
	selected := (1 to: nb) collect: [ :i | self randIndexIn: aList ].
	aList selecter selectIndexes: selected
]

{ #category : #actions }
ToListElementStresser >> actionSelectOnlyIndexIn: aList [

	| idx |
	idx := self randIndexIn: aList.
	idx isZero ifFalse: [ aList selecter selectOnlyIndex: idx ]
]

{ #category : #actions }
ToListElementStresser >> actionSelectOnlyIndexesIn: aList [

	| nb selected |
	nb := (self randIndexIn: aList) min: 30.
	nb isZero ifTrue: [ ^ self ].
	selected := (1 to: nb) collect: [ :i | self randIndexIn: aList ].
	aList selecter selectOnlyIndexes: selected
]

{ #category : #actions }
ToListElementStresser >> actionShiftSelectionFromIn: aList [

	| nb idx |
	nb := self randIndexIn: aList.
	idx := self randIndexIn: aList.
	idx isZero ifFalse: [ aList selecter shiftSelection: nb from: idx ]
]

{ #category : #private }
ToListElementStresser >> afterRoundInList: aList [

	self interRoundWaitDuration wait 
]

{ #category : #running }
ToListElementStresser >> applyCommand: aCommand [

	| tab s |
	tab := self tabsPanel items at: aCommand listNumber.
	s := ' [' asRopedText , aCommand round asString asRopedText bold
	     , ('/' , self maxRound asString , ']') asRopedText.
	tab endElement: (ToAttributedLabel text: s).
	self selectActionsToRun shuffled do: [ :act |
		self perform: act with: aCommand list ]
]

{ #category : #running }
ToListElementStresser >> finishedInAllTabs [

	^ tabsPanel items allSatisfy: [ :tab |
		  | list |
		  list := tab userData at: #list.
		  list userData at: #finishedStress ifAbsent: [false] ]
]

{ #category : #initialization }
ToListElementStresser >> initialize [

	| tabSelectionProcess |
	super initialize.

	counter := 0.
	maxPrimaryIntervals := 0.
	maxNbTasks := 0.
	rand := Random new.

	tabsPanel := ToTabPaneElement new.
	tabsPanel isFlowable: true.
	tabsPanel isScrollable: false.
	tabsPanel vertical: true.
	tabsPanel matchParent.
	listIdentifiers := Array new: self maxTab.


	1 to: self maxTab do: [ :i |
		| paneListAssoc tab list ident |
		paneListAssoc := self newStressedListNumber: i.
		list := paneListAssoc value.
		ident := list userData at: #identifier.
		tab := ToTabButton new.
		tab userData at: #list put: list.
		tab labelText: ident.
		tab paneBuilder: [ :pane  |
			pane addChild: paneListAssoc key ].
		tabsPanel addItem: tab ].

	tabSelectionProcess := [
	                       | round |
	                       round := 0.
	                       startTime := DateAndTime now.
	                       [ self finishedInAllTabs ] whileFalse: [
		                       | idx |
		                       round := round + 1.
		                       idx := (round \\ self maxTab + 1 max: 1)
			                              min: self maxTab.
		                       (self tabsPanel items at: idx) check.
		                       1 seconds wait].
	                       endTime := DateAndTime now.
	                       (endTime - startTime) asDuration traceCr ]
		                       newProcess.

	tabSelectionProcess name: self class name.
	tabSelectionProcess priority: Processor userBackgroundPriority.

	commandApplicationStrategy := BlQueueBasedCommandApplicationStrategy
		                              new
		                              element: self tabsPanel;
		                              yourself.

	self tabsPanel
		addEventHandlerOn: ToAddedToSpaceEvent 
		do: [ :event | tabSelectionProcess resume ].
	self tabsPanel
		addEventHandlerOn: ToRemovedFromSpaceEvent 
		do: [ :event | tabSelectionProcess terminate ]
]

{ #category : #accessing }
ToListElementStresser >> interRoundWaitDuration [

	^ 30 milliSeconds 
]

{ #category : #accessing }
ToListElementStresser >> maxListSize [

	^ 5000

]

{ #category : #accessing }
ToListElementStresser >> maxRound [

	^ maxRound ifNil: [ maxRound := 2000 ]
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

	^ 50

]

{ #category : #initialization }
ToListElementStresser >> newListElement [ 

	^ ToListElement infinite
]

{ #category : #initialization }
ToListElementStresser >> newSelectionBoardOn: aListElement [

	| pane lab labItem |
	pane := ToMenuPane horizontal.
	pane addItem: (ToMenuItem new
			 labelText: 'Inspect';
			 clickAction: [ :evt | evt target space inspect ];
			 yourself).
	pane addItem: (ToMenuItem new
			 labelText: 'Statistics';
			 clickAction: [ :evt | evt target space showStatisticsWindow ];
			 yourself).
	lab := ToLabel new.
	labItem := ToCustomMenuItem new.
	labItem addChild: lab.
	pane addItem: labItem.
	aListElement
		addEventHandlerOn: ToListSelectionChangedEvent
		do: [ :event |
			| nb |
			nb := aListElement selectionModel underlyingModel intervals size.
			lab text: (self selectionResultsTextOn: aListElement) ].
	"pane childrenDo: [ :child | child constraintsDo: [ :c | c linear vertical alignCenter ] ]."
	^ pane
]

{ #category : #initialization }
ToListElementStresser >> newStressedListNumber: aNumber [

	| list process size ident priority suffix pane |
	pane := ToPane vertical.
	pane matchParent.

	list := self newListElement.
	list id: #list.

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

	list dataAccessor addAll:
		((1 to: size) collect: [ :i | 'Hello ' , i asString ]).

	list withRowNumbers.
	list matchParent.

	process := [
		           | round |
		           round := 0.
		           list userData at: #finishedStress put: false.
		           self maxRound timesRepeat: [
				           round := round + 1.
				           self
					           processingRound: round
					           inList: list
					           number: aNumber.
				           self afterRoundInList: list ].
		           self processEndInList: list number: aNumber ] newProcess.

	process name: self class name.
	process priority: priority.

	self tabsPanel
		addEventHandlerOn: ToAddedToSpaceEvent
		do: [ :event | process resume ].
	self tabsPanel
		addEventHandlerOn: ToRemovedFromSpaceEvent
		do: [ :event | process terminate ].

	pane addChild: list.
	pane addChild: (self newSelectionBoardOn: list).
	list userData
		at: #identifier
		put: ident asRopedText bold , suffix asRopedText.

	^ pane -> list
]

{ #category : #private }
ToListElementStresser >> nextCounter [

	counter := counter + 1.
	^ counter
]

{ #category : #private }
ToListElementStresser >> nextProcessPriorityForListNumber: aNumber [

	^ Processor userBackgroundPriority.
]

{ #category : #accessing }
ToListElementStresser >> nextSizeForListNumber: aNumber [

	"^ aNumber even
		  ifTrue: [ rand nextIntegerBetween: 1 and: self minListSize ]
		  ifFalse: [
		  rand nextIntegerBetween: self minListSize and: self maxListSize ]"
	^ 2000
]

{ #category : #running }
ToListElementStresser >> processEndInList: aList number: aNumber [

	| tab |
	aList userData at: #finishedStress put: true.
	tab := self tabsPanel items at: aNumber.
	self tabsPanel enqueueTask: (BlTaskAction new action: [
			 tab label text foreground: Color green muchDarker ])
]

{ #category : #running }
ToListElementStresser >> processingRound: aRound inList: aList number: aNumber [

	commandApplicationStrategy
		addCommand: (ToListElementStresserCommand new
				 round: aRound;
				 list: aList;
				 listNumber: aNumber;
				 yourself)
		from: self
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
ToListElementStresser >> resizeSpace [

	self tabsPanel spaceDo: [ :sp |
		| w h |
		w := rand nextIntegerBetween: 1 and: 1024.
		h := rand nextIntegerBetween: 1 and: 900.
		sp extent: w @ h ]
]

{ #category : #running }
ToListElementStresser >> run [

	self tabsPanel openInSpace.
"	self tabsPanel inspect"
]

{ #category : #running }
ToListElementStresser >> runInHost: aBlOSWindowHost [

	| space |
	space := BlSpace new.
	space host: aBlOSWindowHost.
	space root addChild: self tabsPanel.
	space show
]

{ #category : #running }
ToListElementStresser >> selectActionsToRun [

	^ self class selectors select: [ :selector | selector beginsWith: #action ]
]

{ #category : #initialization }
ToListElementStresser >> selectionResultsTextOn: aListElement [

	| nb nbTasks |
	self tabsPanel space ifNil: [ ^ self ].
	nbTasks := self tabsPanel space taskQueue size.
	maxNbTasks := maxNbTasks max: nbTasks.
	nb := aListElement selectionModel underlyingModel intervals size.
	maxPrimaryIntervals := nb max: maxPrimaryIntervals.
	^ 'Tasks: ', nbTasks asString, '/', maxNbTasks asString, ' -  Intervals: < primary ' , nb asString , '/'
	  , maxPrimaryIntervals asString , ' >'
]

{ #category : #accessing }
ToListElementStresser >> tabsPanel [

	^ tabsPanel
]
