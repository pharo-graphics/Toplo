Class {
	#name : #ToFiniteListElementStresserWithActionMethods,
	#superclass : #ToFiniteListElementStresser,
	#category : #'Toplo-Examples-Stressers'
}

{ #category : #running }
ToFiniteListElementStresserWithActionMethods class >> run [

	<script>

	self new run

]

{ #category : #actions }
ToFiniteListElementStresserWithActionMethods >> actionAddAfterIndexIn: aList [

	| idx v |
	v := self nextCounter.
	idx := self randIndex.
	self storeRunnedAction: 'list dataAccessor add: ' , v asString , ' afterIndex: ', idx asString , '. '.
	aList dataAccessor add: v afterIndex: idx
]

{ #category : #actions }
ToFiniteListElementStresserWithActionMethods >> actionAddAllIn: aList [

	self storeRunnedAction: 'list dataAccessor addAll: (1 to: size). '.
	aList dataAccessor addAll: (1 to: size).

]

{ #category : #actions }
ToFiniteListElementStresserWithActionMethods >> actionAtPutIn: aList [

	| idx v |
	idx := self randIndex.
	idx isZero ifTrue: [ ^ self ].
	v := self nextCounter.
	self storeRunnedAction: 'list dataAccessor at: ', idx asString, ' put: ', v asString, '. '.
	aList dataAccessor
		at: idx
		put: v
]

{ #category : #actions }
ToFiniteListElementStresserWithActionMethods >> actionDeselectAllIn: aList [

	self storeRunnedAction: 'list selecter deselectAll. '.
	aList selecter deselectAll.

]

{ #category : #actions }
ToFiniteListElementStresserWithActionMethods >> actionDeselectIndexIn: aList [

	| idx |
	idx := self randIndex.
	idx isZero ifTrue: [ ^ self ].
	self storeRunnedAction: 'list selecter deselectIndex:' , idx asString , '. '.
	aList selecter deselectIndex: idx.

]

{ #category : #actions }
ToFiniteListElementStresserWithActionMethods >> actionDeselectIndexesIn: aList [

	| nb selected |
	nb := self randIndex min: 30.
	nb isZero ifTrue: [ ^ self ].
	selected := (1 to: nb) collect: [ :i | self randIndex ].
	self storeRunnedAction: 'list selecter deselectIndexes: ' , selected asString , '. '.
	aList selecter deselectIndexes: selected.

]

{ #category : #actions }
ToFiniteListElementStresserWithActionMethods >> actionRemoveAllIn: aList [

	self storeRunnedAction: 'list dataAccessor removeAll. '.
	aList dataAccessor removeAll.

]

{ #category : #actions }
ToFiniteListElementStresserWithActionMethods >> actionSelectAllIn: aList [

	self storeRunnedAction: 'list selecter selectAll. '.
	aList selecter selectAll.

]

{ #category : #actions }
ToFiniteListElementStresserWithActionMethods >> actionSelectIndexIn: aList [

	| idx |
	idx := self randIndex.
	idx isZero ifTrue: [ ^ self ].
	self storeRunnedAction: 'list selecter selectIndex: ' , idx asString , '. '.
	aList selecter selectIndex: idx.

]

{ #category : #actions }
ToFiniteListElementStresserWithActionMethods >> actionSelectIndexeToIn: aList [

	| from to |
	from := self randIndex.
	to := self randIndex.
	(from isZero or: [ to isZero ]) ifTrue: [ ^ self ].
	self storeRunnedAction: 'list selecter selectIndex: ' , from asString , ' to: ', to asString, '. '.
	aList selecter selectIndex: from to: to.

]

{ #category : #actions }
ToFiniteListElementStresserWithActionMethods >> actionSelectIndexesIn: aList [

	| nb selected |
	nb := (self randIndex) min: 30.
	nb isZero ifTrue: [ ^ self ].
	selected := (1 to: nb) collect: [ :i | self randIndex ].
	self storeRunnedAction: 'list selecter selectIndexes: ' , selected asString, '. '.
	aList selecter selectIndexes: selected.

]

{ #category : #actions }
ToFiniteListElementStresserWithActionMethods >> actionSelectOnlyIndexIn: aList [

	| idx |
	idx := self randIndex.
	idx isZero ifTrue: [ ^ self ].
	self storeRunnedAction: 'list selecter selectOnlyIndex: ' , idx asString , '. '.
	aList selecter selectOnlyIndex: idx.

]

{ #category : #actions }
ToFiniteListElementStresserWithActionMethods >> actionSelectOnlyIndexesIn: aList [

	| nb selected |
	nb := (self randIndex) min: 30.
	nb isZero ifTrue: [ ^ self ].
	selected := (1 to: nb) collect: [ :i | self randIndex ].
	self storeRunnedAction: 'list selecter selectOnlyIndexes: ' , selected asString , '. '.
	aList selecter selectOnlyIndexes: selected.

]

{ #category : #actions }
ToFiniteListElementStresserWithActionMethods >> actionShiftSelectionFromIn: aList [

	| nb idx |
	nb := self randIndex.
	idx := self randIndex.
	idx isZero ifTrue: [ ^ self ].
	self storeRunnedAction: 'list selecter shiftSelection: ' , nb asString , ' from: ', idx asString , '. '.
	aList selecter shiftSelection: nb from: idx.

]

{ #category : #running }
ToFiniteListElementStresserWithActionMethods >> processBlock [

	^ [
		  | startTime endTime |
		  startTime := DateAndTime now.
		  round := 0.
		  self maxRound timesRepeat: [
				  round := round + 1.
				  self selectActionsToRun shuffled do: [ :act |
					  list inUIProcessDo: [ self perform: act with: list ] ] ].
		  endTime := DateAndTime now.
		  (endTime - startTime) asDuration traceCr ]
]

{ #category : #running }
ToFiniteListElementStresserWithActionMethods >> selectActionsToRun [

	^ self class selectors select: [ :selector |
		  selector beginsWith: #action ]
]
