Class {
	#name : #ToBasicInfiniteListElementStressTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'list',
		'size',
		'process',
		'round',
		'counter',
		'rand',
		'maxRound'
	],
	#category : #'Toplo-Widget-List-Tests-Core-FiniteListElement'
}

{ #category : #actions }
ToBasicInfiniteListElementStressTest >> actionAddAfterIndexIn: aList [

	aList dataAccessor
		add: self nextCounter 
		afterIndex: self randIndex
]

{ #category : #actions }
ToBasicInfiniteListElementStressTest >> actionAddAllIn: aList [

	aList dataAccessor addAll: (1 to: size)
]

{ #category : #actions }
ToBasicInfiniteListElementStressTest >> actionAtPutIn: aList [

	| idx current |
	idx := self randIndex.
	idx isZero ifTrue: [ ^ self ].
	current := aList dataAccessor at: idx.
	aList dataAccessor
		at: idx
		put: self nextCounter
]

{ #category : #actions }
ToBasicInfiniteListElementStressTest >> actionDeselectAllIn: aList [

	aList selecter deselectAll
]

{ #category : #actions }
ToBasicInfiniteListElementStressTest >> actionDeselectIndexIn: aList [

	| idx |
	idx := self randIndex.
	idx isZero ifFalse: [ aList selecter deselectIndex: idx ]
]

{ #category : #actions }
ToBasicInfiniteListElementStressTest >> actionDeselectIndexesIn: aList [

	| nb selected |
	nb := (self randIndex) min: 30.
	nb isZero ifTrue: [ ^ self ].
	selected := (1 to: nb) collect: [ :i | self randIndex ].
	aList selecter deselectIndexes: selected
]

{ #category : #actions }
ToBasicInfiniteListElementStressTest >> actionRemoveAllIn: aList [

	aList dataAccessor removeAll
]

{ #category : #actions }
ToBasicInfiniteListElementStressTest >> actionRemoveAtIn: aList [

	| idx |
	idx := self randIndex.
	idx isZero ifFalse: [ aList dataAccessor removeAt: idx ]
]

{ #category : #actions }
ToBasicInfiniteListElementStressTest >> actionSelectAllIn: aList [

	aList selecter selectAll
]

{ #category : #actions }
ToBasicInfiniteListElementStressTest >> actionSelectIndexIn: aList [

	| idx |
	idx := self randIndex.
	idx isZero ifFalse: [ aList selecter selectIndex: idx ]
]

{ #category : #actions }
ToBasicInfiniteListElementStressTest >> actionSelectIndexeToIn: aList [

	| from to |
	from := self randIndex.
	to := self randIndex.
	(from isZero or: [ to isZero ]) ifTrue: [ ^ self ].
	aList selecter selectIndex: from to: to
]

{ #category : #actions }
ToBasicInfiniteListElementStressTest >> actionSelectIndexesIn: aList [

	| nb selected |
	nb := (self randIndex) min: 30.
	nb isZero ifTrue: [ ^ self ].
	selected := (1 to: nb) collect: [ :i | self randIndex ].
	aList selecter selectIndexes: selected
]

{ #category : #actions }
ToBasicInfiniteListElementStressTest >> actionSelectOnlyIndexIn: aList [

	| idx |
	idx := self randIndex.
	idx isZero ifFalse: [ aList selecter selectOnlyIndex: idx ]
]

{ #category : #actions }
ToBasicInfiniteListElementStressTest >> actionSelectOnlyIndexesIn: aList [

	| nb selected |
	nb := (self randIndex) min: 30.
	nb isZero ifTrue: [ ^ self ].
	selected := (1 to: nb) collect: [ :i | self randIndex ].
	aList selecter selectOnlyIndexes: selected
]

{ #category : #actions }
ToBasicInfiniteListElementStressTest >> actionShiftSelectionFromIn: aList [

	| nb idx |
	nb := self randIndex.
	idx := self randIndex.
	idx isZero ifFalse: [ aList selecter shiftSelection: nb from: idx ]
]

{ #category : #accessing }
ToBasicInfiniteListElementStressTest >> nextCounter [

	^ counter := counter + 1
]

{ #category : #accessing }
ToBasicInfiniteListElementStressTest >> randIndex [

	| s |
	s := list dataAccessor size.
	^ s isZero
		  ifTrue: [ 0 ]
		  ifFalse: [ ((rand nextIntegerBetween: 1 and: s) max: 1) min: s]
]

{ #category : #tests }
ToBasicInfiniteListElementStressTest >> runStress [

	| sem |
	list dataAccessor addAll:
		((1 to: size) collect: [ :i | 'Hello ' , i asString ]).
	list matchParent.

	sem := Semaphore new.
	process := [
		           round := 0.
		           maxRound timesRepeat: [
				           round := round + 1.
				           self selectActionsToRun shuffled do: [ :act |
					           self perform: act with: list ] ].
		           sem signal ] newProcess.
	process name: self class name.

	space root addChild: list.
	self waitTestingSpaces.

	process resume.
	sem wait.
	self assert: round equals: maxRound
]

{ #category : #actions }
ToBasicInfiniteListElementStressTest >> selectActionsToRun [

	^ self class selectors select: [ :selector |
		  selector beginsWith: #action ]
]

{ #category : #running }
ToBasicInfiniteListElementStressTest >> setUp [

	super setUp.
	rand := Random new.
	size := 500.
	counter := 0
]

{ #category : #running }
ToBasicInfiniteListElementStressTest >> tearDown [

	process terminate.
	super tearDown.

]

{ #category : #tests }
ToBasicInfiniteListElementStressTest >> testFiniteListElement [

	list := ToListElement finite.
	maxRound := 6.
	self runStress
]

{ #category : #tests }
ToBasicInfiniteListElementStressTest >> testInfiniteListElement [

	list := ToListElement infinite.
	maxRound := 1000.
	self runStress
]
