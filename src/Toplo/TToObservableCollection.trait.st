Trait {
	#name : #TToObservableCollection,
	#instVars : [
		'list'
	],
	#category : #'Toplo-Core-Infinite'
}

{ #category : #'t - observable collection copying' }
TToObservableCollection >> , otherCollection [ 
	"Concatenate two Strings or Collections."
	
	^ self copyReplaceFrom: self size + 1
		  to: self size
		  with: otherCollection
]

{ #category : #'t - observable collection adding' }
TToObservableCollection >> add: newObject [

	self addLast: newObject 
]

{ #category : #'t - observable collection adding' }
TToObservableCollection >> add: newObject after: oldObject [

	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just succeeding oldObject. Answer newObject.
	Raises an error if oldObject is not found"

	| idx |
	idx := list indexOf: oldObject.
	self add: newObject afterIndex: idx
]

{ #category : #'t - observable collection adding' }
TToObservableCollection >> add: newObject afterIndex: index [ 
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just after index. Answer newObject."
	
	list add: newObject afterIndex: index.
	self announce: (ToCollectionAddChange new interval: (index + 1 to: index + 1 )).
	
]

{ #category : #'t - observable collection private' }
TToObservableCollection >> add: newObject before: oldObject [ 
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just preceding oldObject. Answer newObject."

	| idx |
	idx := self indexOf: oldObject.
	self add: newObject beforeIndex: idx
]

{ #category : #'t - observable collection private' }
TToObservableCollection >> add: newObject beforeIndex: index [ 
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just before index. Answer newObject."

	list add: newObject beforeIndex: index.
	self announce: (ToCollectionAddChange new interval: (index to: index )).
	
]

{ #category : #'t - observable collection adding' }
TToObservableCollection >> addAll: aCollection [ 
	"Add each element of aCollection at my end. Answer aCollection."

	^ self addAllLast: aCollection
]

{ #category : #'t - observable collection adding' }
TToObservableCollection >> addAllFirst: aCollection [

	list addAllFirst: aCollection.
	aCollection ifNotEmpty: [ 
		self announce: (ToCollectionAddChange new interval: (1 to: aCollection size)) ]
]

{ #category : #'t - observable collection adding' }
TToObservableCollection >> addAllLast: aCollection [

	| idx |
	idx := list size.
	list addAllLast: aCollection.
	aCollection ifNotEmpty: [ 
		self announce: (ToCollectionAddChange new interval:
				 (idx + 1 to: idx + aCollection size)) ]
]

{ #category : #'t - observable collection adding' }
TToObservableCollection >> addFirst: newObject [

	"Add newObject to the end of the receiver. Answer newObject."

	list addFirst: newObject.
	self announce: (ToCollectionAddChange new interval: (1 to: 1))
]

{ #category : #'t - observable collection adding' }
TToObservableCollection >> addLast: newObject [

	"Add newObject to the end of the receiver. Answer newObject."

	list addLast: newObject.
	self announce:
		(ToCollectionAddChange new interval: (self size to: self size))
]

{ #category : #'t - observable collection converting' }
TToObservableCollection >> asArray [

	^ list asArray
]

{ #category : #'t - observable collection converting' }
TToObservableCollection >> asOrderedCollection [

	^ OrderedCollection newFrom: list
]

{ #category : #'t - observable collection accessing' }
TToObservableCollection >> at: anInteger [ 

	^ list at: anInteger
]

{ #category : #'t - observable collection accessing' }
TToObservableCollection >> at: anInteger put: anObject [

	list at: anInteger put: anObject.
	self announce: (ToCollectionUpdateChange new interval: (anInteger to: anInteger))
]

{ #category : #'t - observable collection copying' }
TToObservableCollection >> copyFrom: startIndex to: endIndex [ 
	"Answer a copy of the receiver that contains elements from position
	startIndex to endIndex."

	| l |
	l := list copyFrom: startIndex to: endIndex.
	^ self species newFrom: l
]

{ #category : #'t - observable collection copying' }
TToObservableCollection >> copyReplaceFrom: start to: stop with: replacementCollection [

	"Concatenate two Strings or Collections."

	| l n |
	l := list copyReplaceFrom: start to: stop with: replacementCollection.
	n := self species newFrom: l.
	^ n
]

{ #category : #'t - observable collection enumerating' }
TToObservableCollection >> detect: aBlock ifNone: exceptionBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument.
	Answer the first element for which aBlock evaluates to true. If none
	evaluate to true, then evaluate the argument, exceptionBlock."
	
	^ list detect: aBlock ifNone: exceptionBlock
]

{ #category : #'t - observable collection enumerating' }
TToObservableCollection >> do: aBlock [

	list do: aBlock
]

{ #category : #'t - observable collection accessing' }
TToObservableCollection >> first [

	^ list first
]

{ #category : #'t - observable collection copying' }
TToObservableCollection >> first: n [
	"Answer the first n elements of the receiver.
	Raise an error if there are not enough elements."

	^ self copyFrom: 1 to: n
]

{ #category : #'t - observable collection testing' }
TToObservableCollection >> ifEmpty: aBlock [
	"Evaluate the given block with the receiver as argument, answering its value
	unless the receiver is not empty, in which case answer the receiver."

	^ self isEmpty
		ifFalse: [ self ]
		ifTrue: [ aBlock value ]
]

{ #category : #'t - observable collection testing' }
TToObservableCollection >> ifNotEmpty: aBlock [
	"Evaluate the given block with the receiver as argument, answering its value
	unless the receiver is empty, in which case answer the receiver."

	^ self isEmpty
		ifTrue: [ self ]
		ifFalse: [ aBlock cull: self ]
]

{ #category : #'t - observable collection accessing' }
TToObservableCollection >> indexOf: anObject [


	^ list indexOf: anObject
]

{ #category : #'t - observable collection initialization' }
TToObservableCollection >> initializeObservableCollection [

	list := OrderedCollection new
]

{ #category : #'t - observable collection testing' }
TToObservableCollection >> isEmpty [

	^ list isEmpty 
]

{ #category : #'t - observable collection testing' }
TToObservableCollection >> isNotEmpty [

	^ self isEmpty not
]

{ #category : #'t - observable collection accessing' }
TToObservableCollection >> last [

	^ list last
]

{ #category : #'t - observable collection accessing' }
TToObservableCollection >> last: n [
	"Answer the last n elements of the receiver.  
	Raise an error if there are not enough elements."

	| size |
	size := self size.
	^ self copyFrom: size - n + 1 to: size
]

{ #category : #'t - observable collection copying' }
TToObservableCollection >> postCopy [
	list := list copy
]

{ #category : #'t - observable collection removing' }
TToObservableCollection >> remove: anObject [

	| idx |
	idx := self indexOf: anObject.
	self removeAt: idx

	
]

{ #category : #'t - observable collection removing' }
TToObservableCollection >> removeAll [

	| s |
	s := list size.
	list removeAll.
	self announce: (ToCollectionRemoveChange new interval: (1 to: s))
]

{ #category : #'t - observable collection removing' }
TToObservableCollection >> removeAt: removedIndex [

	list removeAt: removedIndex.
	self announce: (ToCollectionRemoveChange new interval: (removedIndex to: removedIndex))
]

{ #category : #'t - observable collection removing' }
TToObservableCollection >> removeFirst [

	list removeFirst.
	self announce: (ToCollectionRemoveChange new interval: (1 to: 1)).

]

{ #category : #'t - observable collection removing' }
TToObservableCollection >> removeFirst: n [ 

	list removeFirst: n. 
	self announce: (ToCollectionRemoveChange new interval: (1 to: n))
]

{ #category : #'t - observable collection removing' }
TToObservableCollection >> removeFrom: start to: stop [

	| idx |
	idx := start.
	[ idx > stop ] whileFalse: [ 
		list removeAt: start.
		idx := idx + 1 ].
	self announce: (ToCollectionRemoveChange new interval: (start to: stop))
]

{ #category : #'t - observable collection removing' }
TToObservableCollection >> removeLast [

	list removeLast.
	self announce: (ToCollectionRemoveChange new interval:
			 (self size + 1 to: self size + 1))
]

{ #category : #'t - observable collection removing' }
TToObservableCollection >> removeLast: n [

	| s |
	s := self size.
	list removeLast: n.
	self announce: (ToCollectionRemoveChange new interval: (s - n + 1 to: s))
]

{ #category : #'t - observable collection accessing' }
TToObservableCollection >> replaceFrom: start to: stop with: replacement [ 

	self replaceFrom: start to: stop with: replacement startingAt: 1.
]

{ #category : #'t - observable collection accessing' }
TToObservableCollection >> replaceFrom: start to: stop with: replacement startingAt: repStart [ 

	(replacement size - repStart) = (stop - start)
		ifFalse: [self error: 'Size of replacement doesnt match'].

	list replaceFrom: start to: stop with: replacement startingAt: repStart.
	
	self announce: (ToCollectionUpdateChange new interval: (start to: stop))
]

{ #category : #'t - observable collection enumerating' }
TToObservableCollection >> reverseDo: aBlock [

	list reverseDo: aBlock
]

{ #category : #'t - observable collection copying' }
TToObservableCollection >> reversed [

	"Answer a copy of the receiver with element order reversed.  "

	^ self species newFrom: list reversed
]

{ #category : #'t - observable collection accessing' }
TToObservableCollection >> size [

	^ list size
]

{ #category : #'t - observable collection event management' }
TToObservableCollection >> whenAddChangeDo: aBlock [

	self whenAnnouncement: ToCollectionAddChange  do: [ :ann | aBlock cull: ann ] 
]

{ #category : #'t - observable collection event management' }
TToObservableCollection >> whenAddChangeSend: aSelector to: anObject [

	self whenAnnouncement: ToCollectionAddChange  send: aSelector to: anObject
]

{ #category : #'t - observable collection event management' }
TToObservableCollection >> whenRemoveChangeDo: aBlock [

	self whenAnnouncement: ToCollectionRemoveChange  do: [ :ann | aBlock cull: ann ] 
]

{ #category : #'t - observable collection event management' }
TToObservableCollection >> whenRemoveChangeSend: aSelector to: anObject [

	self whenAnnouncement: ToCollectionRemoveChange  send: aSelector to: anObject
]

{ #category : #'t - observable collection event management' }
TToObservableCollection >> whenUpdateChangeDo: aBlock [

	self whenAnnouncement: ToCollectionUpdateChange  do: [ :ann | aBlock cull: ann ] 
]

{ #category : #'t - observable collection event management' }
TToObservableCollection >> whenUpdateChangeSend: aSelector to: anObject [

	self whenAnnouncement: ToCollectionUpdateChange  send: aSelector to: anObject
]
