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

	^ self underlyingModel = anObject underlyingModel
]

{ #category : #'api - testing' }
ToSelectionModel >> containsIndex: anIndex [

	^ self underlyingModel containsIndex: anIndex
]

{ #category : #copying }
ToSelectionModel >> copySelectionFrom: anotherSelectionModel [

	underlyingModel := anotherSelectionModel underlyingModel copy
]

{ #category : #updating }
ToSelectionModel >> deselectAll [

	self underlyingModel removeAll 
]

{ #category : #updating }
ToSelectionModel >> deselectIndex: anIndex [

	self underlyingModel deselectIndex: anIndex
]

{ #category : #updating }
ToSelectionModel >> deselectIndex: aFirstIndex to: aSecondIndex [

	| from to |
	from := aFirstIndex min: aSecondIndex.
	to := aFirstIndex max: aSecondIndex.
	(from <= to
		and: [ from > 0
			and: [ to >= 0 ] ]) ifFalse: [ ^ self ].
	self underlyingModel 
		deselect: from - 1
		to: to
]

{ #category : #updating }
ToSelectionModel >> deselectIndexes: anArray [

	anArray do: [ :idx | self deselectIndex: idx ]
]

{ #category : #accessing }
ToSelectionModel >> firstIndex [

	self ifEmpty: [^ 0].
	^ self underlyingModel from + 1
]

{ #category : #comparing }
ToSelectionModel >> hash [

	^ self class hash bitXor: self underlyingModel hash
]

{ #category : #testing }
ToSelectionModel >> ifEmpty: aBlock [

	self isEmpty ifFalse: [ ^ self ].
	aBlock value
]

{ #category : #testing }
ToSelectionModel >> ifNotEmpty: aBlock [

	self isEmpty ifTrue: [ ^ self ].
	aBlock cull: self
]

{ #category : #initialization }
ToSelectionModel >> initialize [

	super initialize.
	underlyingModel := BlCompositeSelection new
]

{ #category : #testing }
ToSelectionModel >> isEmpty [

	^ self underlyingModel isEmpty
]

{ #category : #testing }
ToSelectionModel >> isNotEmpty [

	^ self isEmpty not
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

	self ifEmpty: [^ 0].
	^ self underlyingModel to
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
	underlyingModel := underlyingModel copy
]

{ #category : #updating }
ToSelectionModel >> selectAll [

	self selectIndex: 1 to: self itemCount
]

{ #category : #updating }
ToSelectionModel >> selectIndex: anIndex [

	self underlyingModel selectIndex: anIndex
]

{ #category : #updating }
ToSelectionModel >> selectIndex: aFirstIndex to: aSecondIndex [

	| from to |
	from := aFirstIndex min: aSecondIndex.
	to := aFirstIndex max: aSecondIndex.
	self underlyingModel 
		select: from - 1
		to: to
]

{ #category : #updating }
ToSelectionModel >> selectIndexes: anArray [

	anArray ifEmpty: [ ^ self ].
	anArray do: [ :idx | self selectIndex: idx ]
]

{ #category : #accessing }
ToSelectionModel >> selectedIndexes [

	^ self underlyingModel indices
]

{ #category : #enumerating }
ToSelectionModel >> selectedIndexesCollect: aBlock [

	^ self underlyingModel indicesCollect: aBlock
]

{ #category : #accessing }
ToSelectionModel >> selectedIndexesCount [

	| count |
	count := 0.
	self underlyingModel do: [ :s | count := count + s interval size - 1 ].
	^ count
]

{ #category : #enumerating }
ToSelectionModel >> selectedIndexesDo: aBlock [

	^ self underlyingModel indicesDo: aBlock
]

{ #category : #updating }
ToSelectionModel >> shift: aGap from: aStartIndex [

	| from to prev high |
	
	self flag: 'Certainely too naive. should be optimized. see comments below '.
	
	aGap isZero ifTrue: [ ^ self ].
	self isEmpty ifTrue: [ ^ self ].

	prev := self underlyingModel copy.
	high := self underlyingModel to.

	aGap <= 0
		ifTrue: [
			from := aStartIndex + aGap.
			to := aStartIndex.
			(high >= 0 and: [from <= high ]) ifTrue: [
				self underlyingModel selections delete:
					(BlMonotoneSelection from: (from max: 0) to: high) ].
			" this do: enumeration should be optimized to avoid the use of selectIndex "
			prev indices do: [ :idx |
				(idx >= aStartIndex and: [ idx + aGap > 0 ]) ifTrue: [
					self underlyingModel selectIndex: idx + aGap ] ] ]
		ifFalse: [
			from := aStartIndex.
			to := aStartIndex + aGap min: high.

			from <= high ifTrue: [
				self underlyingModel selections delete:
					(BlMonotoneSelection from: (from - 1 max: 0) to: high) ].
			" this do: enumeration should be optimized to avoid the use of selectIndex "
			prev indicesDo: [ :idx |
				(idx >= aStartIndex and: [ idx + aGap > 0 ]) ifTrue: [
					self underlyingModel selectIndex: idx + aGap ] ] ]
]

{ #category : #accessing }
ToSelectionModel >> underlyingModel [

	^ underlyingModel
]

{ #category : #accessing }
ToSelectionModel >> underlyingModel: anUnderlyingModel [

	underlyingModel := anUnderlyingModel
]
