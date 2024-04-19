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
	intervals ifEmpty: [
		intervals add: anInterval.
		^ self ].
	i := 1.
	[
	i <= intervals size and: [
		anInterval first >= (intervals at: i) first ] ] whileTrue: [
		(intervals at: i) = anInterval ifTrue: [ ^ self ].
		i := i + 1 ].
	" i can be after the end (i > intervals size) "
	intervals add: anInterval beforeIndex: i.

	" check each interval that comes after the new interval to determine if we can merge"
	[ i <= intervals size ] whileTrue: [
		(i = intervals size or: [
			 (intervals at: i) last >= ((intervals at: i + 1) first - 1) ])
			ifTrue: [
				self checkMergeIntervalsAt: i.
				i = intervals size ifTrue: [ ^ self ] ]
			ifFalse: [ i := i + 1 ] ]
]

{ #category : #private }
ToIndexIntervalSelectionModel >> checkMergeIntervalsAt: aPosition [

	| first last interval1 interval2 |
	" first, try to merge with previous interval "
	aPosition < intervals size ifTrue: [
		interval1 := intervals at: aPosition.
		interval2 := intervals at: aPosition + 1.
		first := interval1 first min: interval2 first.
		last := interval1 last max: interval2 last.
		(intervals at: aPosition) setFrom: first to: last by: 1.
		intervals removeAt: aPosition + 1 ].

	" second, try to merge with next interval "
	(aPosition > 1 and: [ aPosition <= intervals size ]) ifFalse: [
		^ self ].
	interval1 := intervals at: aPosition - 1.
	interval2 := intervals at: aPosition.
	interval1 last >= (interval2 first - 1) ifFalse: [ ^ self ].
	first := interval1 first min: interval2 first.
	last := interval1 last max: interval2 last.
	(intervals at: aPosition - 1) setFrom: first to: last by: 1.
	intervals removeAt: aPosition.
	self checkMergeIntervalsAt: aPosition
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

{ #category : #testing }
ToIndexIntervalSelectionModel >> isEmpty [

	^ intervals isEmpty
]

{ #category : #accessing }
ToIndexIntervalSelectionModel >> lastIndex [

	^ intervals ifEmpty: [ 0 ] ifNotEmpty: [ intervals last last ]
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

	| first last idx |
	intervals ifEmpty: [ ^ self ].

	first := anInterval first.
	last := anInterval last.

	idx := 0.
	[ idx < intervals size ] whileTrue: [
		| int a b |
		idx := idx + 1.
		int := intervals at: idx.
		a := int first.
		b := int last.
		(a > last or: [ b < first ])
			ifTrue: [ (intervals at: idx) setFrom: a to: b by: 1 ]
			ifFalse: [
				(a < first or: [ b > last ]) ifTrue: [
					| gap |
					gap := 0.
					a < first ifTrue: [
						intervals add: (a to: first - 1) beforeIndex: idx.
						gap := gap + 1 ].
					b > last ifTrue: [
						intervals add: (last + 1 to: b) beforeIndex: idx + gap.
						gap := gap + 1 ].
					idx := idx + gap ].
				intervals removeAt: idx ] ]
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
ToIndexIntervalSelectionModel >> selectIndexes: anArray [

	anArray do: [ :idx | self addInterval: (idx to: idx) ]
]
