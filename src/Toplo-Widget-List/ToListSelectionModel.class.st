Class {
	#name : #ToListSelectionModel,
	#superclass : #Object,
	#instVars : [
		'underlyingModel',
		'itemCountGetter',
		'monitor'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #comparing }
ToListSelectionModel >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].

	self underlyingModelDo: [ :ulm |
		anObject underlyingModelDo: [ :ulm2 | ^ ulm = ulm2 ] ]
]

{ #category : #'api - testing' }
ToListSelectionModel >> containsIndex: anIndex [

	self underlyingModelDo: [ :ulm | ^ ulm containsIndex: anIndex ]
]

{ #category : #copying }
ToListSelectionModel >> copySelectionFrom: anotherSelectionModel [

	anotherSelectionModel underlyingModelDo: [ :ulm | underlyingModel := ulm copy ]
]

{ #category : #updating }
ToListSelectionModel >> deselectAll [

	self underlyingModelDo: [ :ulm | ulm removeAll ]
]

{ #category : #updating }
ToListSelectionModel >> deselectIndex: anIndex [

	self underlyingModelDo: [ :ulm | ulm deselectIndex: anIndex ]
]

{ #category : #updating }
ToListSelectionModel >> deselectIndex: aFirstIndex to: aSecondIndex [

	self underlyingModelDo: [ :ulm |
		| from to |
		from := aFirstIndex min: aSecondIndex.
		to := aFirstIndex max: aSecondIndex.
		(from <= to and: [ from > 0 and: [ to >= 0 ] ]) ifFalse: [ ^ self ].
		ulm deselect: from - 1 to: to ]
]

{ #category : #updating }
ToListSelectionModel >> deselectIndexes: anArray [

	self underlyingModelDo: [ :ulm |
		anArray do: [ :idx | self deselectIndex: idx ] ]
]

{ #category : #accessing }
ToListSelectionModel >> firstIndex [

	self underlyingModelDo: [ :ulm |
		self ifEmpty: [ ^ 0 ].
		^ ulm from + 1 ]
]

{ #category : #comparing }
ToListSelectionModel >> hash [

	self underlyingModelDo: [ :ulm | ^ self class hash bitXor: ulm hash ]
]

{ #category : #testing }
ToListSelectionModel >> ifEmpty: aBlock [

	self underlyingModelDo: [ :ulm |
		self isEmpty ifFalse: [ ^ self ].
		aBlock value ]
]

{ #category : #testing }
ToListSelectionModel >> ifNotEmpty: aBlock [

	self underlyingModelDo: [ :ulm |
		self isEmpty ifTrue: [ ^ self ].
		aBlock cull: self ]
]

{ #category : #initialization }
ToListSelectionModel >> initialize [

	super initialize.
	underlyingModel := BlCompositeSelection new.
	monitor := Monitor new.
]

{ #category : #testing }
ToListSelectionModel >> isEmpty [

	self underlyingModelDo: [ :ulm | ^ ulm isEmpty ]
]

{ #category : #testing }
ToListSelectionModel >> isNotEmpty [

	^ self isEmpty not
]

{ #category : #testing }
ToListSelectionModel >> isUnselectableIndex: anIndex [

	^ false
]

{ #category : #accessing }
ToListSelectionModel >> itemCount [

	
	^ self itemCountGetter value
]

{ #category : #accessing }
ToListSelectionModel >> itemCountGetter [

	itemCountGetter ifNil: [ Error signal: 'A selection model must have an initalized itemCountGetter' ].
	^ itemCountGetter 
]

{ #category : #accessing }
ToListSelectionModel >> itemCountGetter: aValuable [

	" aValuable takes no args and return the number of items (typically, a datasource items count) "
	itemCountGetter := aValuable
]

{ #category : #accessing }
ToListSelectionModel >> lastIndex [

	self underlyingModelDo: [ :ulm |
		self ifEmpty: [ ^ 0 ].
		^ ulm to ]
]

{ #category : #accessing }
ToListSelectionModel >> nextSelectableIndexStartingAt: anIndex [

	anIndex < self itemCount ifTrue: [ ^ anIndex ].
	^ 0
]

{ #category : #'api - hooks' }
ToListSelectionModel >> onInstalledIn: anElement [

	itemCountGetter := [ anElement itemCount ]
]

{ #category : #'api - hooks' }
ToListSelectionModel >> onUninstalledIn: anElement [

	itemCountGetter := nil
]

{ #category : #copying }
ToListSelectionModel >> postCopy [ 

	super postCopy.
	self underlyingModelDo: [ :ulm | underlyingModel := ulm copy ].
	monitor := Monitor new.
]

{ #category : #accessing }
ToListSelectionModel >> previousSelectableIndexStartingAt: anIndex [

	anIndex > 0 ifTrue: [ ^ anIndex ].
	^ 0
]

{ #category : #updating }
ToListSelectionModel >> selectAll [

	self underlyingModelDo: [ :ulm |
		ulm removeAll.
		self selectIndex: 1 to: self itemCount ]
]

{ #category : #updating }
ToListSelectionModel >> selectIndex: anIndex [

	self underlyingModelDo: [ :ulm | ulm selectIndex: anIndex ]
]

{ #category : #updating }
ToListSelectionModel >> selectIndex: aFirstIndex to: aSecondIndex [

	self underlyingModelDo: [ :ulm |
		| from to |
		from := aFirstIndex min: aSecondIndex.
		to := aFirstIndex max: aSecondIndex.
		ulm select: from - 1 to: to ]
]

{ #category : #updating }
ToListSelectionModel >> selectIndexes: anArray [

	self underlyingModelDo: [ :ulm |
		anArray ifEmpty: [ ^ self ].
		anArray do: [ :idx | self selectIndex: idx ] ]
]

{ #category : #accessing }
ToListSelectionModel >> selectedIndexes [

	self underlyingModelDo: [ :ulm | ^ ulm indices ]
]

{ #category : #enumerating }
ToListSelectionModel >> selectedIndexesCollect: aBlock [

	self underlyingModelDo: [ :ulm | ^ ulm indicesCollect: aBlock ]
]

{ #category : #accessing }
ToListSelectionModel >> selectedIndexesCount [

	| count |
	count := 0.
	self underlyingModelDo: [ :ulm | ulm do: [ :s | count := count + s interval size - 1 ] ].
	^ count min: self itemCount
]

{ #category : #enumerating }
ToListSelectionModel >> selectedIndexesDo: aBlock [

	self underlyingModelDo: [ :ulm | ^ ulm indicesDo: aBlock ]
]

{ #category : #accessing }
ToListSelectionModel >> selectedIndexesIntervals [
	" return an array of intervals #( 2 3 4 6 7 8 ) -> { 2 to: 4. 6 to: 8 } "

	self underlyingModelDo: [ :ulm |
		^ Array streamContents: [ :stream |
			  self selectedIndexesIntervalsDo: [ :interval |
				  stream nextPut: interval ] ] ]
]

{ #category : #enumerating }
ToListSelectionModel >> selectedIndexesIntervalsDo: aBlock [
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
ToListSelectionModel >> shift: aGap from: aStartIndex [

	self shift: aGap from: aStartIndex for: nil
]

{ #category : #updating }
ToListSelectionModel >> shift: aGap from: aStartIndex for: anEventTarget [

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
ToListSelectionModel >> sideIdx: aGap startingAt: anIndex [

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

{ #category : #accessing }
ToListSelectionModel >> underlyingModel [

	^ underlyingModel
]

{ #category : #updating }
ToListSelectionModel >> underlyingModelDo: aBlock [

	monitor critical: [ aBlock value: underlyingModel ]
]
