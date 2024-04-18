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

	| i |
	"search for insertion point"
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

{ #category : #initialization }
ToIndexIntervalSelectionModel >> checkMergeIntervalsAt: aPosition [

	| first last interval1 interval2 |
	aPosition < intervals size ifTrue: [
		interval1 := intervals at: aPosition.
		interval2 := intervals at: aPosition + 1.
		first := interval1 first min: interval2 first.
		last := interval1 last max: interval2 last.
		intervals at: aPosition put: (first to: last).
		intervals removeAt: aPosition + 1 ].
	(aPosition > 1 and: [ aPosition <= intervals size ]) ifFalse: [
		^ self ].
	interval1 := intervals at: aPosition - 1.
	interval2 := intervals at: aPosition.
	interval1 last >= (interval2 first - 1) ifFalse: [ ^ self ].
	first := interval1 first min: interval2 first.
	last := interval1 last max: interval2 last.
	intervals at: aPosition - 1 put: (first to: last).
	intervals removeAt: aPosition.
	self checkMergeIntervalsAt: aPosition
]

{ #category : #testing }
ToIndexIntervalSelectionModel >> containsIndex: anIndex [

	^ (self positionOfIntervalContainingIndex: anIndex) > 0
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

{ #category : #'api - testing' }
ToIndexIntervalSelectionModel >> intervalContainingIndex: anIndex [

	| pos |
	pos := self positionOfIntervalContainingIndex: anIndex.
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
ToIndexIntervalSelectionModel >> positionOfIntervalContainingIndex: anIndex [

	intervals withIndexDo: [ :int :pos |
		(int includes: anIndex) ifTrue: [ ^ pos ] ].
	^ 0
]

{ #category : #copying }
ToIndexIntervalSelectionModel >> postCopy [

	super postCopy.
	intervals := intervals copy
]

{ #category : #'api - testing' }
ToIndexIntervalSelectionModel >> removeAll [

	intervals removeAll
]

{ #category : #private }
ToIndexIntervalSelectionModel >> removeInterval: anInterval [

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
