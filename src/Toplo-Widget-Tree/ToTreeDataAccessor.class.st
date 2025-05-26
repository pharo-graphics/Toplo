Class {
	#name : #ToTreeDataAccessor,
	#superclass : #Object,
	#traits : 'TToOrderedCollectionLikeAPI + TBlEventTarget + TBlDebug',
	#classTraits : 'TToOrderedCollectionLikeAPI classTrait + TBlEventTarget classTrait + TBlDebug classTrait',
	#instVars : [
		'treeElement',
		'parentWrapper',
		'eventDispatcher'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'t - collection api - copying' }
ToTreeDataAccessor >> , otherCollection [ 
	"Concatenate two Strings or Collections."
	
	^ self asOrderedCollection, otherCollection
]

{ #category : #'t - collection api - adding' }
ToTreeDataAccessor >> add: newObject afterIndex: index [
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just after index. Answer newObject."

	self dataSource
		add: (self newWrapperFor: newObject)
		afterIndex: index
]

{ #category : #'t - collection api - adding' }
ToTreeDataAccessor >> add: newObject beforeIndex: index [ 
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just before index. Answer newObject."

	self dataSource
		add: (self newWrapperFor: newObject)
		beforeIndex: index
]

{ #category : #'t - collection api - adding' }
ToTreeDataAccessor >> addAll: aCollection afterIndex: index [

	self dataSource
		addAll: (aCollection collect: [ :e | self newWrapperFor: e ])
		afterIndex: index
]

{ #category : #'t - collection api - adding' }
ToTreeDataAccessor >> addAllLast: aCollection [

	self dataSource addAllLast:
		(aCollection collect: [ :o | self newWrapperFor: o ])
]

{ #category : #'t - collection api - adding' }
ToTreeDataAccessor >> addFirst: newObject [
	"Add newObject to the end of the receiver. Answer newObject."

	self dataSource addFirst: (self newWrapperFor: newObject)
]

{ #category : #'t - collection api - adding' }
ToTreeDataAccessor >> addLast: newObject [
	"Add newObject to the end of the receiver. Answer newObject."

	self dataSource addLast: (self newWrapperFor: newObject)
]

{ #category : #'t - collection api - converting' }
ToTreeDataAccessor >> asArray [

	^ self dataSource asArray collect: [ :w | w unwrapped ]
]

{ #category : #'t - collection api - converting' }
ToTreeDataAccessor >> asOrderedCollection [

	^ self dataSource asOrderedCollection collect: [ :w | w unwrapped ]
]

{ #category : #'t - collection api - accessing' }
ToTreeDataAccessor >> at: anInteger [ 

	^ self unwrappedAt: anInteger
]

{ #category : #'t - collection api - accessing' }
ToTreeDataAccessor >> at: anInteger put: anObject [

	(self dataSource at: anInteger) wrapped: anObject
]

{ #category : #'t - collection api - copying' }
ToTreeDataAccessor >> copyFrom: start to: stop [
	"Answer a copy of a subset of the receiver, starting from element at
	index start until element at index stop."

	| newSize |
	newSize := stop - start + 1.
	newSize <= 0 ifTrue: [ ^ self species ofSize: 0 ].
	^ (self species ofSize: newSize)
		  replaceFrom: 1
		  to: newSize
		  with: self asArray
		  startingAt: start
]

{ #category : #'t - collection api - copying' }
ToTreeDataAccessor >> copyReplaceFrom: start to: stop with: replacementCollection [
	"Concatenate two Strings or Collections."

	^ self asOrderedCollection
		  copyReplaceFrom: start
		  to: stop
		  with: replacementCollection
]

{ #category : #'accessing - dataSource' }
ToTreeDataAccessor >> dataSource [

	^ treeElement dataSource
]

{ #category : #'accessing - dataSource' }
ToTreeDataAccessor >> dataWrapperClass [ 

	^ ToTreeDataItemWrapper
]

{ #category : #'t - collection api - enumerating' }
ToTreeDataAccessor >> do: aBlock [

	self dataSource do: [ :w | aBlock value: w unwrapped ]
]

{ #category : #private }
ToTreeDataAccessor >> errorSizeMismatch [
	"Signal a SizeMismatch exception"

	SizeMismatch signal
]

{ #category : #'event management accessing' }
ToTreeDataAccessor >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher 
]

{ #category : #'t - collection api - accessing' }
ToTreeDataAccessor >> indexOf: anElement startingAt: start ifAbsent: exceptionBlock [
	"Answer the index of the first occurrence of anElement after start
	within the receiver. If the receiver does not contain anElement,
	answer the 	result of evaluating the argument, exceptionBlock."

	"(#(a b c d e) indexOf: #c startingAt: 2 ifAbsent: 7) >>> 3"

	"(#(a b c d e) indexOf: #c startingAt: 4 ifAbsent: 7) >>> 7"

	| ds |
	ds := self dataSource.
	start to: ds size do: [ :idx |
	(self unwrappedAt: idx) = anElement ifTrue: [ ^ idx ] ].
	^ exceptionBlock value
]

{ #category : #initialization }
ToTreeDataAccessor >> initialize [

	super initialize.
	eventDispatcher := BlDirectEventDispatcher on: self
]

{ #category : #private }
ToTreeDataAccessor >> invalidOperation [

	Error signal: 'Invalid data accessor operation'
]

{ #category : #'accessing - dataSource' }
ToTreeDataAccessor >> newWrapperFor: anObject [

	^ self dataWrapperClass new
		  treeElement: treeElement;
		  parentWrapper: parentWrapper;
		  dataItem: anObject
]

{ #category : #'t - observable collection - removing' }
ToTreeDataAccessor >> onSievedWith: aSieve [

	| interval |
	interval := 1 to: aSieve currentData size.
	self dataSource notifyEmptinessChangeAfter: [
			self initializeWith: aSieve currentData.
			self dataSource notifySievedWith: aSieve interval: interval ]
]

{ #category : #'t - collection api - removing' }
ToTreeDataAccessor >> removeAll [

	^ self dataSource removeAll
]

{ #category : #'t - collection api - removing' }
ToTreeDataAccessor >> removeAllSuchThat: aBlock [

	self asArray do: [:each | (aBlock value: each) ifTrue: [self remove: each]]
]

{ #category : #'t - collection api - removing' }
ToTreeDataAccessor >> removeAt: removedIndex [

	^ (self dataSource removeAt: removedIndex) unwrapped
]

{ #category : #'t - collection api - removing' }
ToTreeDataAccessor >> removeFrom: start to: stop [

	self dataSource removeFrom: start to: stop
]

{ #category : #'t - collection api - accessing' }
ToTreeDataAccessor >> replaceFrom: start to: stop with: replacement startingAt: repStart [
	"This destructively replaces elements from start to stop in the receiver
	starting at index, repStart, in the sequenceable collection,
	replacementCollection. Answer the receiver. No range checks are
	performed."

	| index repOff |
	repOff := repStart - start.
	index := start - 1.
	[ (index := index + 1) <= stop ] whileTrue: [
		self at: index put: (replacement at: repOff + index) ]
]

{ #category : #'t - collection api - initialization' }
ToTreeDataAccessor >> reset [

	self dataSource reset
]

{ #category : #'t - collection api - enumerating' }
ToTreeDataAccessor >> reverseDo: aBlock [

	self dataSource reverseDo: [ :w | aBlock value: w unwrapped ]
]

{ #category : #'t - collection api - copying' }
ToTreeDataAccessor >> reversed [

	"Answer a copy of the receiver with element order reversed.  "

	^ self asOrderedCollection reversed
]

{ #category : #'t - collection api - accessing' }
ToTreeDataAccessor >> size [

	^ self dataSource size
]

{ #category : #private }
ToTreeDataAccessor >> species [ 

	^ OrderedCollection 
]

{ #category : #accessing }
ToTreeDataAccessor >> treeElement [

	^ treeElement
]

{ #category : #accessing }
ToTreeDataAccessor >> treeElement: aTreeElement [

	treeElement := aTreeElement
]

{ #category : #'accessing - dataSource' }
ToTreeDataAccessor >> unwrappedAt: anInteger [ 

	^ (self dataSource at: anInteger) unwrapped
]

{ #category : #'accessing - dataSource' }
ToTreeDataAccessor >> useParentWrapper: aWrapper while: aBlock [

	| previous |
	previous := parentWrapper.
	parentWrapper := aWrapper.
	aBlock value.
	parentWrapper := previous
]
