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

	self underlyingModelDo: [ :ulm |
		anObject underlyingModelDo: [ :ulm2 | ^ ulm = ulm2 ] ]
]

{ #category : #'api - testing' }
ToSelectionModel >> containsIndex: anIndex [

	self underlyingModelDo: [ :ulm | ^ ulm containsIndex: anIndex ]
]

{ #category : #copying }
ToSelectionModel >> copySelectionFrom: anotherSelectionModel [

	anotherSelectionModel ifNil: [ ^ self ].
	anotherSelectionModel underlyingModelDo: [ :ulm |
		underlyingModel := ulm copy ]
]

{ #category : #updating }
ToSelectionModel >> deselectAll [

	self underlyingModelDo: [ :ulm | ulm removeAll ]
]

{ #category : #updating }
ToSelectionModel >> deselectIndex: anIndex [

	self underlyingModelDo: [ :ulm | ulm deselectIndex: anIndex ]
]

{ #category : #updating }
ToSelectionModel >> deselectIndex: aFirstIndex to: aSecondIndex [

	self underlyingModelDo: [ :ulm |
		| from to |
		from := aFirstIndex min: aSecondIndex.
		to := aFirstIndex max: aSecondIndex.
		(from <= to and: [ from > 0 and: [ to >= 0 ] ]) ifFalse: [ ^ self ].
		ulm deselect: from - 1 to: to ]
]

{ #category : #updating }
ToSelectionModel >> deselectIndexes: anArray [

	self underlyingModelDo: [ :ulm |
		anArray do: [ :idx | self deselectIndex: idx ] ]
]

{ #category : #accessing }
ToSelectionModel >> firstIndex [

	self underlyingModelDo: [ :ulm |
		self ifEmpty: [ ^ 0 ].
		^ ulm from + 1 ]
]

{ #category : #testing }
ToSelectionModel >> hasUnselectableInInterval: anInterval [

	^ false
]

{ #category : #comparing }
ToSelectionModel >> hash [

	self underlyingModelDo: [ :ulm | ^ self class hash bitXor: ulm hash ]
]

{ #category : #testing }
ToSelectionModel >> ifEmpty: aBlock [

	self underlyingModelDo: [ :ulm |
		self isEmpty ifFalse: [ ^ self ].
		aBlock value ]
]

{ #category : #testing }
ToSelectionModel >> ifNotEmpty: aBlock [

	self underlyingModelDo: [ :ulm |
		self isEmpty ifTrue: [ ^ self ].
		aBlock cull: self ]
]

{ #category : #initialization }
ToSelectionModel >> initialize [

	super initialize.
	underlyingModel := BlCompositeSelection new
]

{ #category : #testing }
ToSelectionModel >> isDisabledIndex: anIndex [

	^ false
]

{ #category : #testing }
ToSelectionModel >> isEmpty [

	self underlyingModelDo: [ :ulm | ^ ulm isEmpty ]
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
ToSelectionModel >> isUnselectableIndex: anIndex [

	^ false
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

	self underlyingModelDo: [ :ulm |
		self ifEmpty: [ ^ 0 ].
		^ ulm to ]
]

{ #category : #accessing }
ToSelectionModel >> nextSelectableIndexStartingAt: anIndex [

	anIndex < self itemCount ifTrue: [ ^ anIndex ].
	^ 0
]

{ #category : #'api - hooks' }
ToSelectionModel >> onInstalledIn: anElement [

	itemCountGetter := [ anElement itemCount ]
]

{ #category : #'api - hooks' }
ToSelectionModel >> onUninstalledIn: anElement [

	itemCountGetter := nil
]

{ #category : #copying }
ToSelectionModel >> postCopy [ 

	super postCopy.
	self underlyingModelDo: [ :ulm | underlyingModel := ulm copy ]
]

{ #category : #accessing }
ToSelectionModel >> previousSelectableIndexStartingAt: anIndex [

	anIndex > 0 ifTrue: [ ^ anIndex ].
	^ 0
]

{ #category : #updating }
ToSelectionModel >> selectAll [

	self underlyingModelDo: [ :ulm |
		ulm removeAll.
		self selectIndex: 1 to: self itemCount ]
]

{ #category : #updating }
ToSelectionModel >> selectIndex: anIndex [

	self underlyingModelDo: [ :ulm | ulm selectIndex: anIndex ]
]

{ #category : #updating }
ToSelectionModel >> selectIndex: aFirstIndex to: aSecondIndex [

	self underlyingModelDo: [ :ulm |
		| from to |
		from := aFirstIndex min: aSecondIndex.
		to := aFirstIndex max: aSecondIndex.
		ulm select: from - 1 to: to ]
]

{ #category : #updating }
ToSelectionModel >> selectIndexes: anArray [

	self underlyingModelDo: [ :ulm |
		anArray ifEmpty: [ ^ self ].
		anArray do: [ :idx | self selectIndex: idx ] ]
]

{ #category : #accessing }
ToSelectionModel >> selectedIndexes [

	self underlyingModelDo: [ :ulm | ^ ulm indices ]
]

{ #category : #enumerating }
ToSelectionModel >> selectedIndexesCollect: aBlock [

	self underlyingModelDo: [ :ulm | ^ ulm indicesCollect: aBlock ]
]

{ #category : #accessing }
ToSelectionModel >> selectedIndexesCount [

	| count |
	count := 0.
	self underlyingModelDo: [ :ulm | ulm do: [ :s | count := count + s interval size - 1 ] ].
	^ count
]

{ #category : #enumerating }
ToSelectionModel >> selectedIndexesDo: aBlock [

	self underlyingModelDo: [ :ulm | ^ ulm indicesDo: aBlock ]
]

{ #category : #accessing }
ToSelectionModel >> selectedIndexesIntervals [
	" return an array of intervals #( 2 3 4 6 7 8 ) -> { 2 to: 4. 6 to: 8 } "

	self underlyingModelDo: [ :ulm |
		^ Array streamContents: [ :stream |
			  self selectedIndexesIntervalsDo: [ :interval |
				  stream nextPut: interval ] ] ]
]

{ #category : #enumerating }
ToSelectionModel >> selectedIndexesIntervalsDo: aBlock [
	" aBlock has one interval argument "

	self underlyingModelDo: [ :ulm |
		| prev g |
		g := nil.
		prev := nil.
		self selectedIndexesDo: [ :idx |
			prev ifNil: [ g := idx to: idx ] ifNotNil: [
				prev + 1 = idx
					ifTrue: [ g := g first to: idx ]
					ifFalse: [
						aBlock value: g.
						g := idx to: idx ] ].
			prev := idx ].
		g ifNotNil: [ aBlock value: g ] ]
]

{ #category : #updating }
ToSelectionModel >> shift: aGap from: aStartIndex [

	self shift: aGap from: aStartIndex for: nil
]

{ #category : #updating }
ToSelectionModel >> shift: aGap from: aStartIndex for: anEventTarget [

	| from to prevIntervals high |
	aGap isZero ifTrue: [ ^ self ].
	
	self underlyingModelDo: [ :ulm |
		
		self isEmpty ifTrue: [ ^ self ].

		" 1 - keep selected intervals to reselect them accordingly at 2"
		prevIntervals := self selectedIndexesIntervals.
		high := self underlyingModel to.

		" deselect according to start index and gap "
		aGap <= 0
			ifTrue: [
				from := aStartIndex + aGap.
				to := aStartIndex.
				(high >= 0 and: [ from <= high ]) ifTrue: [
					ulm selections delete:
						(BlMonotoneSelection from: (from max: 0) to: high) ] ]
			ifFalse: [
				from := aStartIndex.
				to := aStartIndex + aGap min: high.

				from <= high ifTrue: [
					ulm selections delete:
						(BlMonotoneSelection from: (from - 1 max: 0) to: high) ] ].

		" 2 - reselect "
		prevIntervals do: [ :interval |
			| first last |
			(interval last >= aStartIndex and: [ interval last + aGap > 0 ])
				ifTrue: [
					first := interval first max: aStartIndex.
					last := interval last.

					ulm select: first + aGap - 1 to: last + aGap ] ] ]
]

{ #category : #accessing }
ToSelectionModel >> sideIdx: aGap startingAt: anIndex [

	self underlyingModelDo: [ :ulm |
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
			  ifFalse: [ nextIdx ] ]
]

{ #category : #updating }
ToSelectionModel >> transferIndex: anIndex from: anotherPrimarySelectionModel as: targetIndex [

	(anotherPrimarySelectionModel containsIndex: anIndex)
		ifTrue: [ self selectIndex: targetIndex ]
		ifFalse: [ self deselectIndex: targetIndex ]
]

{ #category : #updating }
ToSelectionModel >> transferSelectionFromIndex: anIndex toIndex: targetIndex in: anotherPrimarySelectionModel [ 

	(self containsIndex: anIndex)
		ifTrue: [ anotherPrimarySelectionModel selectIndex: targetIndex ]
		ifFalse: [ anotherPrimarySelectionModel deselectIndex: targetIndex ]
]

{ #category : #accessing }
ToSelectionModel >> underlyingModel [

	^ underlyingModel
]

{ #category : #updating }
ToSelectionModel >> underlyingModelDo: aBlock [

	aBlock value: underlyingModel
]
