Class {
	#name : #ToIndexIntervalSelectionModel,
	#superclass : #Object,
	#instVars : [
		'intervals'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #comparing }
ToIndexIntervalSelectionModel >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ intervals = anObject intervals
]

{ #category : #private }
ToIndexIntervalSelectionModel >> addInterval: anInterval [
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
	self merge
]

{ #category : #testing }
ToIndexIntervalSelectionModel >> containsIndex: anIndex [

	^ (self positionOfIntervalWithIndex: anIndex) > 0
]

{ #category : #'api - selection' }
ToIndexIntervalSelectionModel >> deselect: anIndex to: aLastIndex [

	self removeInterval: (anIndex to: aLastIndex)
]

{ #category : #'api - selection' }
ToIndexIntervalSelectionModel >> deselectIndex: aNumber [

	self deselect: aNumber to: aNumber
]

{ #category : #'api - selection' }
ToIndexIntervalSelectionModel >> deselectIndex: fromIndex to: toIndex [

	self deselect: fromIndex to: toIndex
]

{ #category : #'api - selection' }
ToIndexIntervalSelectionModel >> deselectIndexes: anArray [

	anArray do: [ :idx | self deselectIndex: idx ]
]

{ #category : #enumerating }
ToIndexIntervalSelectionModel >> do: aBlock [

	intervals do: aBlock
]

{ #category : #accessing }
ToIndexIntervalSelectionModel >> firstIndex [

	^ intervals ifEmpty: [ 0 ] ifNotEmpty: [ intervals first first ]
]

{ #category : #comparing }
ToIndexIntervalSelectionModel >> hash [

	^ self class hash bitXor: intervals hash
]

{ #category : #accessing }
ToIndexIntervalSelectionModel >> indices [

	^ Array streamContents: [ :aStream |
		  intervals do: [ :eachInterval | aStream nextPutAll: eachInterval ] ]
]

{ #category : #enumerating }
ToIndexIntervalSelectionModel >> indicesCollect: aBlock [

	^ Array streamContents: [ :stream |
		  self do: [ :eachInterval |
			  stream nextPutAll: (eachInterval collect: aBlock) ] ]
]

{ #category : #accessing }
ToIndexIntervalSelectionModel >> indicesCount [

	| count |
	count := 0.
	intervals do: [ :s | count := count + s size ].
	^ count
]

{ #category : #enumerating }
ToIndexIntervalSelectionModel >> indicesDo: aBlock [

	self do: [ :eachInterval | eachInterval do: aBlock ]
]

{ #category : #initialization }
ToIndexIntervalSelectionModel >> initialize [ 

	super initialize.
	intervals := OrderedCollection new
]

{ #category : #private }
ToIndexIntervalSelectionModel >> intervalWithIndex: anIndex [

	| pos |
	pos := self positionOfIntervalWithIndex: anIndex.
	^ pos isZero
		  ifTrue: [  ]
		  ifFalse: [ intervals at: pos ]
]

{ #category : #accessing }
ToIndexIntervalSelectionModel >> intervals [

	^ intervals
]

{ #category : #enumerating }
ToIndexIntervalSelectionModel >> intervalsDo: aBlock [

	self do: aBlock
]

{ #category : #testing }
ToIndexIntervalSelectionModel >> isEmpty [

	^ intervals isEmpty
]

{ #category : #accessing }
ToIndexIntervalSelectionModel >> lastIndex [

	^ intervals ifEmpty: [ 0 ] ifNotEmpty: [ intervals last last ]
]

{ #category : #private }
ToIndexIntervalSelectionModel >> merge [

	self mergeStartingAt: 1
]

{ #category : #private }
ToIndexIntervalSelectionModel >> mergeStartingAt: aPosition [

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
ToIndexIntervalSelectionModel >> positionOfIntervalWithIndex: anIndex [

	intervals withIndexDo: [ :int :pos |
		(int includes: anIndex) ifTrue: [ ^ pos ] ].
	^ 0
]

{ #category : #copying }
ToIndexIntervalSelectionModel >> postCopy [

	super postCopy.
	intervals := intervals copy
]

{ #category : #'api - selection' }
ToIndexIntervalSelectionModel >> removeAll [

	intervals removeAll
]

{ #category : #private }
ToIndexIntervalSelectionModel >> removeInterval: anInterval [
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
	intervals := newIntervals
]

{ #category : #private }
ToIndexIntervalSelectionModel >> removeIntervalFromIndex: aFromIndex toIndex: aToIndex [

	self removeInterval: (aFromIndex to: aToIndex)
]

{ #category : #'api - selection' }
ToIndexIntervalSelectionModel >> select: fromIndex to: toIndex [

	self addInterval: (fromIndex to: toIndex)
]

{ #category : #'api - selection' }
ToIndexIntervalSelectionModel >> selectIndex: aNumber [

	self addInterval: (aNumber to: aNumber)
]

{ #category : #'api - selection' }
ToIndexIntervalSelectionModel >> selectIndex: fromIndex to: toIndex [

	self select: fromIndex to: toIndex
]

{ #category : #'api - selection' }
ToIndexIntervalSelectionModel >> selectIndexes: anArray [

	anArray do: [ :idx | self addInterval: (idx to: idx) ]
]
