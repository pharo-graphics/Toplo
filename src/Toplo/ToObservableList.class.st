Class {
	#name : #ToObservableList,
	#superclass : #Object,
	#traits : 'TBlAnnouncerProvider',
	#classTraits : 'TBlAnnouncerProvider classTrait',
	#instVars : [
		'list'
	],
	#category : #'Toplo-Core'
}

{ #category : #'instance creation' }
ToObservableList class >> newFrom: aCollection [

	| l |
	l := self new.
	l unplugAnnouncerWhile: [ l addAll: aCollection ].
	^ l
]

{ #category : #copying }
ToObservableList >> , otherCollection [ 
	"Concatenate two Strings or Collections."
	
	^ self copyReplaceFrom: self size + 1
		  to: self size
		  with: otherCollection
]

{ #category : #adding }
ToObservableList >> add: newObject [

	self addLast: newObject 
]

{ #category : #adding }
ToObservableList >> add: newObject after: oldObject [

	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just succeeding oldObject. Answer newObject.
	Raises an error if oldObject is not found"

	| idx |
	idx := list indexOf: oldObject.
	self add: newObject afterIndex: idx
]

{ #category : #adding }
ToObservableList >> add: newObject afterIndex: index [ 
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just after index. Answer newObject."
	
	list add: newObject afterIndex: index.
	self announce: (ToObservableListAddChange new interval: (index + 1 to: index + 1 )).
	
]

{ #category : #private }
ToObservableList >> add: newObject before: oldObject [ 
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just preceding oldObject. Answer newObject."

	| idx |
	idx := self indexOf: oldObject.
	self add: newObject beforeIndex: idx
]

{ #category : #private }
ToObservableList >> add: newObject beforeIndex: index [ 
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just before index. Answer newObject."

	list add: newObject beforeIndex: index.
	self announce: (ToObservableListAddChange new interval: (index to: index )).
	
]

{ #category : #adding }
ToObservableList >> addAll: aCollection [ 
	"Add each element of aCollection at my end. Answer aCollection."

	^ self addAllLast: aCollection
]

{ #category : #adding }
ToObservableList >> addAllFirst: aCollection [

	list addAllFirst: aCollection.
	aCollection ifNotEmpty: [ 
		self announce: (ToObservableListAddChange new interval: (1 to: aCollection size)) ]
]

{ #category : #adding }
ToObservableList >> addAllLast: aCollection [

	| idx |
	idx := list size.
	list addAllLast: aCollection.
	aCollection ifNotEmpty: [ 
		self announce: (ToObservableListAddChange new interval:
				 (idx + 1 to: idx + aCollection size)) ]
]

{ #category : #adding }
ToObservableList >> addFirst: newObject [

	"Add newObject to the end of the receiver. Answer newObject."

	list addFirst: newObject.
	self announce: (ToObservableListAddChange new interval: (1 to: 1))
]

{ #category : #adding }
ToObservableList >> addLast: newObject [

	"Add newObject to the end of the receiver. Answer newObject."

	list addLast: newObject.
	self announce:
		(ToObservableListAddChange new interval: (self size to: self size))
]

{ #category : #converting }
ToObservableList >> asArray [

	^ list asArray
]

{ #category : #converting }
ToObservableList >> asOrderedCollection [

	^ OrderedCollection newFrom: list
]

{ #category : #accessing }
ToObservableList >> at: anInteger [ 

	^ list at: anInteger
]

{ #category : #accessing }
ToObservableList >> at: anInteger put: anObject [

	list at: anInteger put: anObject.
	self announce: (ToObservableListUpdateChange new interval: (anInteger to: anInteger))
]

{ #category : #copying }
ToObservableList >> copyFrom: startIndex to: endIndex [ 
	"Answer a copy of the receiver that contains elements from position
	startIndex to endIndex."

	| l |
	l := list copyFrom: startIndex to: endIndex.
	^ self species newFrom: l
]

{ #category : #copying }
ToObservableList >> copyReplaceFrom: start to: stop with: replacementCollection [

	"Concatenate two Strings or Collections."

	| l n |
	l := list copyReplaceFrom: start to: stop with: replacementCollection.
	n := self species newFrom: l.
	^ n
]

{ #category : #enumerating }
ToObservableList >> do: aBlock [

	list do: aBlock
]

{ #category : #accessing }
ToObservableList >> first [

	^ list first
]

{ #category : #copying }
ToObservableList >> first: n [
	"Answer the first n elements of the receiver.
	Raise an error if there are not enough elements."

	^ self copyFrom: 1 to: n
]

{ #category : #testing }
ToObservableList >> ifEmpty: aBlock [
	"Evaluate the given block with the receiver as argument, answering its value
	unless the receiver is not empty, in which case answer the receiver."

	^ self isEmpty
		ifFalse: [ self ]
		ifTrue: [ aBlock value ]
]

{ #category : #testing }
ToObservableList >> ifNotEmpty: aBlock [
	"Evaluate the given block with the receiver as argument, answering its value
	unless the receiver is empty, in which case answer the receiver."

	^ self isEmpty
		ifTrue: [ self ]
		ifFalse: [ aBlock cull: self ]
]

{ #category : #private }
ToObservableList >> indexOf: anObject [


	^ list indexOf: anObject
]

{ #category : #initialization }
ToObservableList >> initialize [

	super initialize.
	list := OrderedCollection new
]

{ #category : #testing }
ToObservableList >> isEmpty [

	^ list isEmpty 
]

{ #category : #testing }
ToObservableList >> isNotEmpty [

	^ self isEmpty not
]

{ #category : #accessing }
ToObservableList >> last [

	^ list last
]

{ #category : #accessing }
ToObservableList >> last: n [
	"Answer the last n elements of the receiver.  
	Raise an error if there are not enough elements."

	| size |
	size := self size.
	^ self copyFrom: size - n + 1 to: size
]

{ #category : #copying }
ToObservableList >> postCopy [
	list := list copy
]

{ #category : #removing }
ToObservableList >> remove: anObject [

	| idx |
	idx := self indexOf: anObject.
	self removeAt: idx

	
]

{ #category : #removing }
ToObservableList >> removeAll [

	| s |
	s := list size.
	list removeAll.
	self announce: (ToObservableListRemoveChange new interval: (1 to: s))
]

{ #category : #removing }
ToObservableList >> removeAt: removedIndex [

	list removeAt: removedIndex.
	self announce: (ToObservableListRemoveChange new interval: (removedIndex to: removedIndex))
]

{ #category : #removing }
ToObservableList >> removeFirst [

	list removeFirst.
	self announce: (ToObservableListRemoveChange new interval: (1 to: 1)).

]

{ #category : #removing }
ToObservableList >> removeFirst: n [ 

	list removeFirst: n. 
	self announce: (ToObservableListRemoveChange new interval: (1 to: n))
]

{ #category : #removing }
ToObservableList >> removeLast [

	list removeLast.
	self announce: (ToObservableListRemoveChange new interval:
			 (self size + 1 to: self size + 1))
]

{ #category : #removing }
ToObservableList >> removeLast: n [

	| s |
	s := self size.
	list removeLast: n.
	self announce: (ToObservableListRemoveChange new interval: (s - n + 1 to: s))
]

{ #category : #enumerating }
ToObservableList >> reverseDo: aBlock [

	list reverseDo: aBlock
]

{ #category : #copying }
ToObservableList >> reversed [

	"Answer a copy of the receiver with element order reversed.  "

	^ self species newFrom: list reversed
]

{ #category : #accessing }
ToObservableList >> size [

	^ list size
]

{ #category : #'event management' }
ToObservableList >> whenAddChangeDo: aBlock [

	self whenAnnouncement: ToObservableListAddChange  do: [ :ann | aBlock cull: ann ] 
]

{ #category : #'event management' }
ToObservableList >> whenAddChangeSend: aSelector to: anObject [

	self whenAnnouncement: ToObservableListAddChange  send: aSelector to: anObject
]

{ #category : #'event management' }
ToObservableList >> whenRemoveChangeDo: aBlock [

	self whenAnnouncement: ToObservableListRemoveChange  do: [ :ann | aBlock cull: ann ] 
]

{ #category : #'event management' }
ToObservableList >> whenRemoveChangeSend: aSelector to: anObject [

	self whenAnnouncement: ToObservableListRemoveChange  send: aSelector to: anObject
]

{ #category : #'event management' }
ToObservableList >> whenUpdateChangeDo: aBlock [

	self whenAnnouncement: ToObservableListUpdateChange  do: [ :ann | aBlock cull: ann ] 
]

{ #category : #'event management' }
ToObservableList >> whenUpdateChangeSend: aSelector to: anObject [

	self whenAnnouncement: ToObservableListUpdateChange  send: aSelector to: anObject
]
