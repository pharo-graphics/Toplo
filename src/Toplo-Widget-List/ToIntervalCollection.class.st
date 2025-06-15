Class {
	#name : #ToIntervalCollection,
	#superclass : #Object,
	#instVars : [
		'intervals'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #comparing }
ToIntervalCollection >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ intervals = anObject intervals
]

{ #category : #private }
ToIntervalCollection >> addInterval: anInterval [
	" adapted from https://coderbyte.com/algorithm/insert-interval-into-list-of-sorted-disjoint-intervals "

	| i |
	anInterval ifEmpty: [ ^ self ].
	anInterval last isZero ifTrue: [ ^ self ].
	intervals ifEmpty: [
		intervals add: anInterval.
		^ self ].
	i := 1.
	[
	i <= intervals size and: [
		anInterval first >= (intervals at: i) first ] ] whileTrue: [
		| curr |
		curr := intervals at: i.
		((curr includes: anInterval first) and: [
			 curr includes: anInterval last ]) ifTrue: [ ^ self ].
		i := i + 1 ].

	intervals add: anInterval beforeIndex: i.
	self merge.
	self checkIntervals.

]

{ #category : #checking }
ToIntervalCollection >> checkIntervals [

	"intervals size traceCr."
	true ifTrue: [ ^ self ].
	1 to: intervals size do: [ :idx |
		| curr |
		curr := intervals at: idx.
		curr first <= curr last ifFalse: [
			Error signal: 'Malformed interval at ' , idx asString ].
		idx > 1 ifTrue: [
			| prev |
			prev := intervals at: idx - 1.
			prev first < curr first ifFalse: [
				Error signal:
					' first should be < than next interval at: ' , idx asString ].
			prev last < (curr last - 1) ifFalse: [
				Error signal:
					' last should be < than next interval - 1 at: ' , idx asString ] ] ]
]

{ #category : #testing }
ToIntervalCollection >> containsAnyOfInterval: anInterval [

	intervals do: [ :int |
			int last < anInterval first ifFalse: [
					| first last |
					first := anInterval first max: int first.
					last := anInterval last min: int last.
					(int includesAnyOf: (first to: last)) ifTrue: [ ^ true ] ] ].
	^ false
]

{ #category : #testing }
ToIntervalCollection >> containsIndex: anIndex [

	^ (self positionOfIntervalWithIndex: anIndex) > 0
]

{ #category : #'api - selection' }
ToIntervalCollection >> deselect: anIndex to: aLastIndex [

	self removeInterval: (anIndex to: aLastIndex)
]

{ #category : #'api - selection' }
ToIntervalCollection >> deselectIndex: aNumber [

	self deselect: aNumber to: aNumber
]

{ #category : #'api - selection' }
ToIntervalCollection >> deselectIndex: fromIndex to: toIndex [

	self deselect: fromIndex to: toIndex
]

{ #category : #'api - selection' }
ToIntervalCollection >> deselectIndexes: anArray [

	anArray do: [ :idx | self deselectIndex: idx ]
]

{ #category : #enumerating }
ToIntervalCollection >> do: aBlock [

	intervals do: aBlock
]

{ #category : #accessing }
ToIntervalCollection >> firstIndex [

	^ intervals ifEmpty: [ 0 ] ifNotEmpty: [ intervals first first ]
]

{ #category : #comparing }
ToIntervalCollection >> hash [

	^ self class hash bitXor: intervals hash
]

{ #category : #accessing }
ToIntervalCollection >> indices [

	^ Array streamContents: [ :aStream |
		  intervals do: [ :eachInterval | aStream nextPutAll: eachInterval ] ]
]

{ #category : #enumerating }
ToIntervalCollection >> indicesCollect: aBlock [

	^ Array streamContents: [ :stream |
		  self do: [ :eachInterval |
			  stream nextPutAll: (eachInterval collect: aBlock) ] ]
]

{ #category : #accessing }
ToIntervalCollection >> indicesCount [

	| count |
	count := 0.
	intervals do: [ :s | count := count + s size ].
	^ count
]

{ #category : #enumerating }
ToIntervalCollection >> indicesDo: aBlock [

	self do: [ :eachInterval | eachInterval do: aBlock ]
]

{ #category : #initialization }
ToIntervalCollection >> initialize [ 

	super initialize.
	intervals := OrderedCollection new
]

{ #category : #private }
ToIntervalCollection >> intervalWithIndex: anIndex [

	| pos |
	pos := self positionOfIntervalWithIndex: anIndex.
	^ pos isZero
		  ifTrue: [  ]
		  ifFalse: [ intervals at: pos ]
]

{ #category : #accessing }
ToIntervalCollection >> intervals [

	^ intervals
]

{ #category : #enumerating }
ToIntervalCollection >> intervalsDo: aBlock [

	self do: aBlock
]

{ #category : #testing }
ToIntervalCollection >> isEmpty [

	^ intervals isEmpty
]

{ #category : #accessing }
ToIntervalCollection >> lastIndex [

	^ intervals ifEmpty: [ 0 ] ifNotEmpty: [ intervals last last ]
]

{ #category : #private }
ToIntervalCollection >> merge [

	self mergeStartingAt: 1
]

{ #category : #private }
ToIntervalCollection >> mergeStartingAt: aPosition [

	| first last interval1 interval2 |
	" try to merge with previous interval "
	aPosition < intervals size ifFalse: [ ^ self ].
	interval1 := intervals at: aPosition.
	interval2 := intervals at: aPosition + 1.

	(interval1 last >= (interval2 first - 1) or: [
		 interval1 last >= interval2 last ]) ifFalse: [
		^ self mergeStartingAt: aPosition + 1 ].

	first := interval1 first min: interval2 first.
	last := interval1 last max: interval2 last.
	intervals at: aPosition put: (first to: last).
	intervals removeAt: aPosition + 1.
	self mergeStartingAt: aPosition
]

{ #category : #private }
ToIntervalCollection >> positionOfIntervalWithIndex: anIndex [

	intervals withIndexDo: [ :int :pos |
		(int includes: anIndex) ifTrue: [ ^ pos ] ].
	^ 0
]

{ #category : #copying }
ToIntervalCollection >> postCopy [

	super postCopy.
	intervals := intervals copy
]

{ #category : #dependencies }
ToIntervalCollection >> release [ 

	super release.
	intervals removeAll.
	intervals := nil
]

{ #category : #'api - selection' }
ToIntervalCollection >> removeAll [

	intervals removeAll
]

{ #category : #private }
ToIntervalCollection >> removeInterval: anInterval [
	" adapted from https://leetcode.ca/2019-05-25-1272-Remove-Interval/ "

	| newIntervals first last |
	intervals ifEmpty: [ ^ self ].

	first := anInterval first.
	last := anInterval last.

	newIntervals := OrderedCollection new.
	intervals do: [ :int |
		| a b |
		a := int first.
		b := int last.
		(a > last or: [ b < first ])
			ifTrue: [ newIntervals add: (a to: b) ]
			ifFalse: [
				a < first ifTrue: [ newIntervals add: (a to: (first - 1)) ].
				b > last ifTrue: [ newIntervals add: ((last + 1) to: b) ] ] ].
	intervals := newIntervals.
	self checkIntervals.

]

{ #category : #private }
ToIntervalCollection >> removeIntervalFromIndex: aFromIndex toIndex: aToIndex [
	"'ToIntervalCollection>>removeIntervalFromIndex: ' trace. aFromIndex trace. ' toIndex: ' trace. aToIndex traceCr."
	self removeInterval: (aFromIndex to: aToIndex)
]

{ #category : #'api - selection' }
ToIntervalCollection >> select: fromIndex to: toIndex [

	self addInterval: (fromIndex to: toIndex)
]

{ #category : #'api - selection' }
ToIntervalCollection >> selectIndex: aNumber [

	self addInterval: (aNumber to: aNumber)
]

{ #category : #'api - selection' }
ToIntervalCollection >> selectIndex: fromIndex to: toIndex [

	self select: fromIndex to: toIndex
]

{ #category : #'api - selection' }
ToIntervalCollection >> selectIndexes: anArray [

	anArray do: [ :idx | self addInterval: (idx to: idx) ]
]
