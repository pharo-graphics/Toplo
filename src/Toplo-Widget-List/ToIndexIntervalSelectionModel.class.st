Class {
	#name : #ToIndexIntervalSelectionModel,
	#superclass : #Object,
	#instVars : [
		'intervals'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #initialization }
ToIndexIntervalSelectionModel >> containsIndex: anIndex [

	^ (self positionOfIntervalContainingIndex: anIndex) notNil
]

{ #category : #initialization }
ToIndexIntervalSelectionModel >> deselect: fromIndex to: toIndex [

	fromIndex to: toIndex do: [ :idx | self deselectIndex: idx ]
]

{ #category : #initialization }
ToIndexIntervalSelectionModel >> deselectIndex: anIndex [

	(self positionOfIntervalContainingIndex: anIndex)
		ifNotNil: [ :toRemove |
			intervals remove: toRemove.
			anIndex = toRemove first ifFalse: [
				intervals add: toRemove first to: anIndex - 1 ].
			anIndex = toRemove last ifFalse: [
				intervals add: anIndex + 1 to: toRemove last ] ]
]

{ #category : #initialization }
ToIndexIntervalSelectionModel >> initialize [ 

	super initialize.
	intervals := OrderedCollection new
]

{ #category : #initialization }
ToIndexIntervalSelectionModel >> insertInterval: anInterval [

	| i |
	"search for insertion point"
	intervals ifEmpty: [
		intervals add: anInterval.
		^ self ].
	i := 1.
	[
	i <= intervals size and: [
		anInterval first >= (intervals at: i) first ] ] whileTrue: [
		i := i + 1 ].
	intervals add: anInterval beforeIndex: i.

	" check each interval that comes after the new interval to determine if we can merge"
	[ i < intervals size ] whileTrue: [ " if arr[i].end >= next.start "
		(intervals at: i) last >= ((intervals at: i + 1) first - 1)
			ifTrue: [
				| first last |
				first := (intervals at: i) first min: (intervals at: i + 1) first.
				last := (intervals at: i) last max: (intervals at: i + 1) last.
				intervals at: i put: (first to: last).
				intervals removeAt: i + 1.
				i > 1 ifTrue: [
					(intervals at: i - 1) last >= ((intervals at: i) first - 1)
						ifTrue: [
							first := (intervals at: i - 1) first min:
								         (intervals at: i) first.
							last := (intervals at: i - 1) last max: (intervals at: i) last.
							intervals at: i - 1 put: (first to: last).
							intervals removeAt: i ] ] "remove node to the right" ]
			ifFalse: [ i := i + 1 ] ]
]

{ #category : #initialization }
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

{ #category : #initialization }
ToIndexIntervalSelectionModel >> positionOfIntervalContainingIndex: anIndex [

	intervals withIndexDo: [ :int :pos |
		(int includes: anIndex) ifTrue: [ ^ pos ] ].
	^ 0
]

{ #category : #initialization }
ToIndexIntervalSelectionModel >> removeAll [

	intervals removeAll
]

{ #category : #initialization }
ToIndexIntervalSelectionModel >> select: fromIndex to: toIndex [

]
