Class {
	#name : #ToObservableCollection,
	#superclass : #Object,
	#traits : 'TBlAnnouncerProvider',
	#classTraits : 'TBlAnnouncerProvider classTrait',
	#instVars : [
		'list'
	],
	#category : #'Toplo-Core-Infinite'
}

{ #category : #'instance creation' }
ToObservableCollection class >> newFrom: aCollection [

	| l |
	l := self new.
	l unplugAnnouncerWhile: [ l addAll: aCollection ].
	^ l
]

{ #category : #copying }
ToObservableCollection >> , otherCollection [ 
	"Concatenate two Strings or Collections."
	
	^ self copyReplaceFrom: self size + 1
		  to: self size
		  with: otherCollection
]

{ #category : #adding }
ToObservableCollection >> add: newObject [

	self addLast: newObject 
]

{ #category : #adding }
ToObservableCollection >> add: newObject after: oldObject [

	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just succeeding oldObject. Answer newObject.
	Raises an error if oldObject is not found"

	| idx |
	idx := list indexOf: oldObject.
	self add: newObject afterIndex: idx
]

{ #category : #adding }
ToObservableCollection >> add: newObject afterIndex: index [ 
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just after index. Answer newObject."
	
	list add: newObject afterIndex: index.
	self announce: (ToCollectionAddChange new interval: (index + 1 to: index + 1 )).
	
]

{ #category : #private }
ToObservableCollection >> add: newObject before: oldObject [ 
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just preceding oldObject. Answer newObject."

	| idx |
	idx := self indexOf: oldObject.
	self add: newObject beforeIndex: idx
]

{ #category : #private }
ToObservableCollection >> add: newObject beforeIndex: index [ 
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just before index. Answer newObject."

	list add: newObject beforeIndex: index.
	self announce: (ToCollectionAddChange new interval: (index to: index )).
	
]

{ #category : #adding }
ToObservableCollection >> addAll: aCollection [ 
	"Add each element of aCollection at my end. Answer aCollection."

	^ self addAllLast: aCollection
]

{ #category : #adding }
ToObservableCollection >> addAllFirst: aCollection [

	list addAllFirst: aCollection.
	aCollection ifNotEmpty: [ 
		self announce: (ToCollectionAddChange new interval: (1 to: aCollection size)) ]
]

{ #category : #adding }
ToObservableCollection >> addAllLast: aCollection [

	| idx |
	idx := list size.
	list addAllLast: aCollection.
	aCollection ifNotEmpty: [ 
		self announce: (ToCollectionAddChange new interval:
				 (idx + 1 to: idx + aCollection size)) ]
]

{ #category : #adding }
ToObservableCollection >> addFirst: newObject [

	"Add newObject to the end of the receiver. Answer newObject."

	list addFirst: newObject.
	self announce: (ToCollectionAddChange new interval: (1 to: 1))
]

{ #category : #adding }
ToObservableCollection >> addLast: newObject [

	"Add newObject to the end of the receiver. Answer newObject."

	list addLast: newObject.
	self announce:
		(ToCollectionAddChange new interval: (self size to: self size))
]

{ #category : #converting }
ToObservableCollection >> asArray [

	^ list asArray
]

{ #category : #converting }
ToObservableCollection >> asOrderedCollection [

	^ OrderedCollection newFrom: list
]

{ #category : #accessing }
ToObservableCollection >> at: anInteger [ 

	^ list at: anInteger
]

{ #category : #accessing }
ToObservableCollection >> at: anInteger put: anObject [

	list at: anInteger put: anObject.
	self announce: (ToCollectionUpdateChange new interval: (anInteger to: anInteger))
]

{ #category : #copying }
ToObservableCollection >> copyFrom: startIndex to: endIndex [ 
	"Answer a copy of the receiver that contains elements from position
	startIndex to endIndex."

	| l |
	l := list copyFrom: startIndex to: endIndex.
	^ self species newFrom: l
]

{ #category : #copying }
ToObservableCollection >> copyReplaceFrom: start to: stop with: replacementCollection [

	"Concatenate two Strings or Collections."

	| l n |
	l := list copyReplaceFrom: start to: stop with: replacementCollection.
	n := self species newFrom: l.
	^ n
]

{ #category : #enumerating }
ToObservableCollection >> detect: aBlock ifNone: exceptionBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument.
	Answer the first element for which aBlock evaluates to true. If none
	evaluate to true, then evaluate the argument, exceptionBlock."
	
	^ list detect: aBlock ifNone: exceptionBlock
]

{ #category : #enumerating }
ToObservableCollection >> do: aBlock [

	list do: aBlock
]

{ #category : #accessing }
ToObservableCollection >> first [

	^ list first
]

{ #category : #copying }
ToObservableCollection >> first: n [
	"Answer the first n elements of the receiver.
	Raise an error if there are not enough elements."

	^ self copyFrom: 1 to: n
]

{ #category : #testing }
ToObservableCollection >> ifEmpty: aBlock [
	"Evaluate the given block with the receiver as argument, answering its value
	unless the receiver is not empty, in which case answer the receiver."

	^ self isEmpty
		ifFalse: [ self ]
		ifTrue: [ aBlock value ]
]

{ #category : #testing }
ToObservableCollection >> ifNotEmpty: aBlock [
	"Evaluate the given block with the receiver as argument, answering its value
	unless the receiver is empty, in which case answer the receiver."

	^ self isEmpty
		ifTrue: [ self ]
		ifFalse: [ aBlock cull: self ]
]

{ #category : #private }
ToObservableCollection >> indexOf: anObject [


	^ list indexOf: anObject
]

{ #category : #initialization }
ToObservableCollection >> initialize [

	super initialize.
	list := OrderedCollection new
]

{ #category : #testing }
ToObservableCollection >> isEmpty [

	^ list isEmpty 
]

{ #category : #testing }
ToObservableCollection >> isNotEmpty [

	^ self isEmpty not
]

{ #category : #accessing }
ToObservableCollection >> last [

	^ list last
]

{ #category : #accessing }
ToObservableCollection >> last: n [
	"Answer the last n elements of the receiver.  
	Raise an error if there are not enough elements."

	| size |
	size := self size.
	^ self copyFrom: size - n + 1 to: size
]

{ #category : #copying }
ToObservableCollection >> postCopy [
	list := list copy
]

{ #category : #removing }
ToObservableCollection >> remove: anObject [

	| idx |
	idx := self indexOf: anObject.
	self removeAt: idx

	
]

{ #category : #removing }
ToObservableCollection >> removeAll [

	| s |
	s := list size.
	list removeAll.
	self announce: (ToCollectionRemoveChange new interval: (1 to: s))
]

{ #category : #removing }
ToObservableCollection >> removeAt: removedIndex [

	list removeAt: removedIndex.
	self announce: (ToCollectionRemoveChange new interval: (removedIndex to: removedIndex))
]

{ #category : #removing }
ToObservableCollection >> removeFirst [

	list removeFirst.
	self announce: (ToCollectionRemoveChange new interval: (1 to: 1)).

]

{ #category : #removing }
ToObservableCollection >> removeFirst: n [ 

	list removeFirst: n. 
	self announce: (ToCollectionRemoveChange new interval: (1 to: n))
]

{ #category : #removing }
ToObservableCollection >> removeFrom: start to: stop [

	| idx |
	idx := start.
	[ idx > stop ] whileFalse: [ 
		list removeAt: start.
		idx := idx + 1 ].
	self announce: (ToCollectionRemoveChange new interval: (start to: stop))
]

{ #category : #removing }
ToObservableCollection >> removeLast [

	list removeLast.
	self announce: (ToCollectionRemoveChange new interval:
			 (self size + 1 to: self size + 1))
]

{ #category : #removing }
ToObservableCollection >> removeLast: n [

	| s |
	s := self size.
	list removeLast: n.
	self announce: (ToCollectionRemoveChange new interval: (s - n + 1 to: s))
]

{ #category : #accessing }
ToObservableCollection >> replaceFrom: start to: stop with: replacement [ 

	self replaceFrom: start to: stop with: replacement startingAt: 1.
]

{ #category : #accessing }
ToObservableCollection >> replaceFrom: start to: stop with: replacement startingAt: repStart [ 

	(replacement size - repStart) = (stop - start)
		ifFalse: [self error: 'Size of replacement doesnt match'].

	list replaceFrom: start to: stop with: replacement startingAt: repStart.
	
	self announce: (ToCollectionUpdateChange new interval: (start to: stop))
]

{ #category : #enumerating }
ToObservableCollection >> reverseDo: aBlock [

	list reverseDo: aBlock
]

{ #category : #copying }
ToObservableCollection >> reversed [

	"Answer a copy of the receiver with element order reversed.  "

	^ self species newFrom: list reversed
]

{ #category : #accessing }
ToObservableCollection >> size [

	^ list size
]

{ #category : #'event management' }
ToObservableCollection >> whenAddChangeDo: aBlock [

	self whenAnnouncement: ToCollectionAddChange  do: [ :ann | aBlock cull: ann ] 
]

{ #category : #'event management' }
ToObservableCollection >> whenAddChangeSend: aSelector to: anObject [

	self whenAnnouncement: ToCollectionAddChange  send: aSelector to: anObject
]

{ #category : #'event management' }
ToObservableCollection >> whenRemoveChangeDo: aBlock [

	self whenAnnouncement: ToCollectionRemoveChange  do: [ :ann | aBlock cull: ann ] 
]

{ #category : #'event management' }
ToObservableCollection >> whenRemoveChangeSend: aSelector to: anObject [

	self whenAnnouncement: ToCollectionRemoveChange  send: aSelector to: anObject
]

{ #category : #'event management' }
ToObservableCollection >> whenUpdateChangeDo: aBlock [

	self whenAnnouncement: ToCollectionUpdateChange  do: [ :ann | aBlock cull: ann ] 
]

{ #category : #'event management' }
ToObservableCollection >> whenUpdateChangeSend: aSelector to: anObject [

	self whenAnnouncement: ToCollectionUpdateChange  send: aSelector to: anObject
]
