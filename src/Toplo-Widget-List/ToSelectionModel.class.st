Class {
	#name : #ToSelectionModel,
	#superclass : #Object,
	#instVars : [
		'underlyingModel',
		'itemCountGetter'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #comparing }
ToSelectionModel >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].

	^ underlyingModel = anObject underlyingModel
]

{ #category : #accessing }
ToSelectionModel >> allIndexes [

	^ (1 to: self itemCount) asArray
]

{ #category : #enumerating }
ToSelectionModel >> allIndexesDo: aValuable [

	1 to: self itemCount do: [ :idx | aValuable value: idx ]
]

{ #category : #'api - testing' }
ToSelectionModel >> containsAnyOfInterval: anInterval [

	^ underlyingModel containsAnyOfInterval: anInterval
]

{ #category : #'api - testing' }
ToSelectionModel >> containsIndex: anIndex [

	^ underlyingModel containsIndex: anIndex
]

{ #category : #copying }
ToSelectionModel >> copySelectionFrom: anotherSelectionModel [

	" just copy the root selection "
	underlyingModel := anotherSelectionModel underlyingModel copy
]

{ #category : #updating }
ToSelectionModel >> deselectAll [

	underlyingModel removeAll
]

{ #category : #updating }
ToSelectionModel >> deselectIndex: anIndex [

	underlyingModel deselectIndex: anIndex
]

{ #category : #updating }
ToSelectionModel >> deselectIndex: aFirstIndex to: aSecondIndex [

	| from to |
	from := aFirstIndex min: aSecondIndex.
	to := aFirstIndex max: aSecondIndex.
	(from <= to and: [ from > 0 and: [ to >= 0 ] ]) ifFalse: [ ^ self ].
	underlyingModel deselectIndex: from to: to
]

{ #category : #updating }
ToSelectionModel >> deselectIndexes: anArray [

	anArray do: [ :idx | self deselectIndex: idx ]
]

{ #category : #accessing }
ToSelectionModel >> deselectedIndexes [

	^ self allIndexes difference: self selectedIndexes
]

{ #category : #accessing }
ToSelectionModel >> firstIndex [

	^ underlyingModel firstIndex
]

{ #category : #comparing }
ToSelectionModel >> hash [

	^ self class hash bitXor: underlyingModel hash
]

{ #category : #testing }
ToSelectionModel >> ifEmpty: aBlock [

	self isEmpty ifFalse: [ ^ self ].
	^ aBlock value
]

{ #category : #testing }
ToSelectionModel >> ifEmpty: aBlock ifNotEmpty: notEmptyBlock [

	self isEmpty ifFalse: [ ^ notEmptyBlock cull: self ].
	^ aBlock value
]

{ #category : #testing }
ToSelectionModel >> ifNotEmpty: aBlock [

	self isEmpty ifTrue: [ ^ self ].
	^ aBlock cull: self
]

{ #category : #testing }
ToSelectionModel >> ifNotEmpty: notEmptyBlock ifEmpty: aBlock [ 

	self isEmpty ifFalse: [ ^ notEmptyBlock cull: self ].
	^ aBlock value
]

{ #category : #initialization }
ToSelectionModel >> initialize [

	super initialize.
	underlyingModel := self newUnderlyingModel 
]

{ #category : #testing }
ToSelectionModel >> isDisabledIndex: anIndex [

	^ false
]

{ #category : #testing }
ToSelectionModel >> isEmpty [

	^ underlyingModel isEmpty
]

{ #category : #testing }
ToSelectionModel >> isHiddenIndex: anIndex [

	^ false
]

{ #category : #testing }
ToSelectionModel >> isNotEmpty [

	^ self isEmpty not
]

{ #category : #testing }
ToSelectionModel >> isSelectableIndex: anIndex [

	^ (self isUnselectableIndex: anIndex) not
]

{ #category : #testing }
ToSelectionModel >> isUnselectableIndex: anIndex [

	^ false
]

{ #category : #testing }
ToSelectionModel >> isVisibleIndex: anIndex [

	^ (self isHiddenIndex: anIndex) not
]

{ #category : #accessing }
ToSelectionModel >> itemCount [

	
	^ self itemCountGetter value
]

{ #category : #accessing }
ToSelectionModel >> itemCountGetter [

	itemCountGetter ifNil: [ Error signal: 'A selection model must have an initalized itemCountGetter' ].
	^ itemCountGetter 
]

{ #category : #accessing }
ToSelectionModel >> itemCountGetter: aValuable [

	" aValuable takes no args and return the number of items (typically, a datasource items count) "
	itemCountGetter := aValuable
]

{ #category : #accessing }
ToSelectionModel >> lastIndex [

	^ underlyingModel lastIndex
]

{ #category : #accessing }
ToSelectionModel >> makeDisabledUnselectable [

	^ false
]

{ #category : #accessing }
ToSelectionModel >> makeDisabledUnselectable: aBoolean [

	"make nothing for the general case"
]

{ #category : #initialization }
ToSelectionModel >> newUnderlyingModel [ 

	^ self underlyingModelClass new
]

{ #category : #accessing }
ToSelectionModel >> nextSelectableIndexStartingAt: anIndex [

	anIndex <= self itemCount ifTrue: [ ^ anIndex ].
	^ 0
]

{ #category : #'api - hooks' }
ToSelectionModel >> on: anElement [

	itemCountGetter := [ anElement itemCount ]
]

{ #category : #copying }
ToSelectionModel >> postCopy [

	| newUnderlyingModel |
	super postCopy.
	newUnderlyingModel := underlyingModel copy.
	underlyingModel := newUnderlyingModel
]

{ #category : #accessing }
ToSelectionModel >> previousSelectableIndexStartingAt: anIndex [

	anIndex > 0 ifTrue: [ ^ anIndex ].
	^ 0
]

{ #category : #dependencies }
ToSelectionModel >> release [ 

	super release.
	underlyingModel release.
	underlyingModel := nil
]

{ #category : #updating }
ToSelectionModel >> resetAll [

	self deselectAll
]

{ #category : #updating }
ToSelectionModel >> selectAll [

	self selectIndex: 1 to: self itemCount
]

{ #category : #updating }
ToSelectionModel >> selectIndex: anIndex [

	self selectOneMoreIndex: anIndex
]

{ #category : #updating }
ToSelectionModel >> selectIndex: aFirstIndex to: aSecondIndex [

	| from to |
	from := (aFirstIndex min: aSecondIndex) max: 1.
	to := aFirstIndex max: aSecondIndex.
	underlyingModel selectIndex: from  to: to
]

{ #category : #updating }
ToSelectionModel >> selectIndexes: anArray [

	anArray ifEmpty: [ ^ self ].
	anArray do: [ :idx | self selectOneMoreIndex: idx ]
]

{ #category : #updating }
ToSelectionModel >> selectOneMoreIndex: anIndex [

	underlyingModel selectOneMoreIndex: anIndex
]

{ #category : #accessing }
ToSelectionModel >> selectedIndexes [

	^ underlyingModel indices
]

{ #category : #enumerating }
ToSelectionModel >> selectedIndexesCollect: aBlock [

	^ underlyingModel indicesCollect: aBlock
]

{ #category : #accessing }
ToSelectionModel >> selectedIndexesCount [


	^ underlyingModel indicesCount
]

{ #category : #enumerating }
ToSelectionModel >> selectedIndexesDo: aBlock [

	underlyingModel indicesDo: aBlock
]

{ #category : #accessing }
ToSelectionModel >> selectedIndexesIntervals [
	" return an array of intervals #( 2 3 4 6 7 8 ) -> { 2 to: 4. 6 to: 8 } "

	^ underlyingModel intervals
]

{ #category : #enumerating }
ToSelectionModel >> selectedIndexesIntervalsDo: aBlock [
	" aBlock has one interval argument "

	underlyingModel intervalsDo: aBlock
]

{ #category : #updating }
ToSelectionModel >> shift: aGap from: aStartIndex [
	"I update the selection after adding or removing items from/in a listElement.
	The gap is < 0 for items removal.
	In that case, the selection interval are shift from startIndex toward the start of the list.
	After the shift, the startIndex IS NOT present in the selection.
	The gap is > 0 for adding.
	In that case, the selection intervals are shift from startIndex toward the end of list.
	After the shift, the startIndex IS present in the selection."

	| prevIntervals lastIndex minLastIndex |
	"'ToSelectionModel>> shift: ' trace. aGap trace. ' from: ' trace. aStartIndex traceCr."
	aGap isZero ifTrue: [ ^ self ].
	self isEmpty ifTrue: [ ^ self ].
	"'ToSelectionModel>>shift: itemsCount ' trace. self itemCount traceCr."
	lastIndex := underlyingModel lastIndex.

	" 1 - keep selected intervals to reselect them accordingly at 3 "
	prevIntervals := self selectedIndexesIntervals.

	" 2 - deselect according to start index and gap "
	underlyingModel
		removeIntervalFromIndex: aStartIndex
		toIndex: lastIndex + 1.

	"prevIntervals traceCr."
	" 3 - reselect "
	" in case of items adding, include the startIndex "
	minLastIndex := aGap < 0
		                ifTrue: [ aStartIndex ]
		                ifFalse: [ aStartIndex - 1 ].
	prevIntervals
		select: [ :int | int last > minLastIndex ]
		thenDo: [ :int |
				| first last |
				first := (int first max: aStartIndex) + aGap max: 1.
				last := int last + aGap max: 0.
				underlyingModel selectIndex: first to: last ].

	" 4 - remove selection outside the valid selection interval (1 to: self itemCount) "
	lastIndex := underlyingModel lastIndex.
	lastIndex > self itemCount ifFalse: [ ^ self ].
	underlyingModel deselectIndex: self itemCount + 1 to: lastIndex
]

{ #category : #accessing }
ToSelectionModel >> sideIdx: aGap startingAt: anIndex [

	| nextIdx |
	nextIdx := anIndex.
	(self containsIndex: nextIdx) ifFalse: [
		^ aGap < 0
			  ifTrue: [ self previousSelectableIndexStartingAt: nextIdx ]
			  ifFalse: [ self nextSelectableIndexStartingAt: nextIdx ] ].
	[
	(nextIdx between: 1 and: self itemCount) and: [
		(self containsIndex: nextIdx) or: [
			self isUnselectableIndex: nextIdx ] ] ] whileTrue: [
		nextIdx := nextIdx + aGap ].
	nextIdx := (nextIdx max: 1) min: self itemCount.

	^ (self isUnselectableIndex: nextIdx)
		  ifTrue: [ 0 ]
		  ifFalse: [ nextIdx ]
]

{ #category : #updating }
ToSelectionModel >> transferSelectionFromIndex: anIndex toIndex: targetIndex in: anotherPrimarySelectionModel [

	(self containsIndex: anIndex)
		ifTrue: [
		anotherPrimarySelectionModel selectOneMoreIndex: targetIndex ]
		ifFalse: [ anotherPrimarySelectionModel deselectIndex: targetIndex ]
]

{ #category : #accessing }
ToSelectionModel >> underlyingModel [

	^ underlyingModel
]

{ #category : #initialization }
ToSelectionModel >> underlyingModelClass [

	"^ BlCompositeSelection"
	^ ToIntervalCollection 
]
