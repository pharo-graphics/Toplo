Trait {
	#name : 'TToObservableCollection',
	#instVars : [
		'list'
	],
	#category : 'Toplo-Core-Collection',
	#package : 'Toplo',
	#tag : 'Core-Collection'
}

{ #category : 't - observable collection - copying' }
TToObservableCollection >> , otherCollection [ 
	"Concatenate two Strings or Collections."
	
	^ self copyReplaceFrom: self size + 1
		  to: self size
		  with: otherCollection
]

{ #category : 't - observable collection - adding' }
TToObservableCollection >> add: newObject [

	self addLast: newObject 
]

{ #category : 't - observable collection - adding' }
TToObservableCollection >> add: newObject after: oldObject [

	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just succeeding oldObject. Answer newObject.
	Raises an error if oldObject is not found"

	| idx |
	idx := list indexOf: oldObject.
	self add: newObject afterIndex: idx
]

{ #category : 't - observable collection - adding' }
TToObservableCollection >> add: newObject afterIndex: index [
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just after index. Answer newObject."

	self
		notifyAddChangeAround: [ list add: newObject afterIndex: index ]
		candidates: (Array with: newObject)
		interval: (index + 1 to: index + 1)
]

{ #category : 't - observable collection - private' }
TToObservableCollection >> add: newObject before: oldObject [ 
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just preceding oldObject. Answer newObject."

	| idx |
	idx := self indexOf: oldObject.
	self add: newObject beforeIndex: idx
]

{ #category : 't - observable collection - private' }
TToObservableCollection >> add: newObject beforeIndex: index [ 
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just before index. Answer newObject."

	self
		notifyAddChangeAround: [ list add: newObject beforeIndex: index ]
		candidates: (Array with: newObject)
		interval: (index to: index)
]

{ #category : 't - observable collection - adding' }
TToObservableCollection >> addAll: aCollection [ 
	"Add each element of aCollection at my end. Answer aCollection."

	^ self addAllLast: aCollection
]

{ #category : 't - observable collection - adding' }
TToObservableCollection >> addAllFirst: aCollection [

	aCollection ifEmpty: [ ^ self ].
	self
		notifyAddChangeAround: [ list addAllFirst: aCollection ]
		candidates: aCollection
		interval: (1 to: aCollection size)
]

{ #category : 't - observable collection - adding' }
TToObservableCollection >> addAllLast: aCollection [

	| idx |
	aCollection ifEmpty: [ ^ self ].
	idx := list size.
	self
		notifyAddChangeAround: [ list addAllLast: aCollection ]
		candidates: aCollection
		interval: (idx + 1 to: idx + aCollection size)
]

{ #category : 't - observable collection - adding' }
TToObservableCollection >> addFirst: newObject [

	"Add newObject to the end of the receiver. Answer newObject."
	self
		notifyAddChangeAround: [ list addFirst: newObject ]
		candidates: (Array with: newObject)
		interval: (1 to: 1)
]

{ #category : 't - observable collection - adding' }
TToObservableCollection >> addLast: newObject [

	"Add newObject to the end of the receiver. Answer newObject."
	self
		notifyAddChangeAround: [ list addLast: newObject ]
		candidates: (Array with: newObject)
		interval: (self size + 1 to: self size + 1)
]

{ #category : 't - observable collection - enumerating' }
TToObservableCollection >> allSatisfy: aBlock [

	^ list allSatisfy: aBlock
]

{ #category : 't - observable collection - converting' }
TToObservableCollection >> asArray [

	^ list asArray
]

{ #category : 't - observable collection - converting' }
TToObservableCollection >> asOrderedCollection [

	^ OrderedCollection newFrom: list
]

{ #category : 't - observable collection - accessing' }
TToObservableCollection >> at: anInteger [ 

	^ list at: anInteger
]

{ #category : 't - observable collection - accessing' }
TToObservableCollection >> at: anInteger put: anObject [

	self
		notifyUpdateChangeAround: [ list at: anInteger put: anObject ]
		interval: (anInteger to: anInteger)
]

{ #category : 't - observable collection - enumerating' }
TToObservableCollection >> collect: aBlock [

	^ list collect: aBlock
]

{ #category : 't - observable collection - copying' }
TToObservableCollection >> copyFrom: startIndex to: endIndex [ 
	"Answer a copy of the receiver that contains elements from position
	startIndex to endIndex."

	| l |
	l := list copyFrom: startIndex to: endIndex.
	^ self species newFrom: l
]

{ #category : 't - observable collection - copying' }
TToObservableCollection >> copyReplaceFrom: start to: stop with: replacementCollection [

	"Concatenate two Strings or Collections."

	| l n |
	l := list copyReplaceFrom: start to: stop with: replacementCollection.
	n := self species newFrom: l.
	^ n
]

{ #category : 't - observable collection - enumerating' }
TToObservableCollection >> detect: aBlock ifNone: exceptionBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument.
	Answer the first element for which aBlock evaluates to true. If none
	evaluate to true, then evaluate the argument, exceptionBlock."
	
	^ list detect: aBlock ifNone: exceptionBlock
]

{ #category : 't - observable collection - enumerating' }
TToObservableCollection >> do: aBlock [

	list do: aBlock
]

{ #category : 't - observable collection - accessing' }
TToObservableCollection >> fifth [

	^ list fifth
]

{ #category : 't - observable collection - removing' }
TToObservableCollection >> filterResult: aCollection [

	self
		notifyFilterChangeAround: [
			list removeAll.
			list addAll: aCollection ]
		interval: (1 to: aCollection size)
]

{ #category : 't - observable collection - accessing' }
TToObservableCollection >> first [

	^ list first
]

{ #category : 't - observable collection - copying' }
TToObservableCollection >> first: n [
	"Answer the first n elements of the receiver.
	Raise an error if there are not enough elements."

	^ self copyFrom: 1 to: n
]

{ #category : 't - observable collection - accessing' }
TToObservableCollection >> fourth [

	^ list fourth
]

{ #category : 't - observable collection - testing' }
TToObservableCollection >> ifEmpty: aBlock [
	"Evaluate the given block with the receiver as argument, answering its value
	unless the receiver is not empty, in which case answer the receiver."

	^ self isEmpty
		ifFalse: [ self ]
		ifTrue: [ aBlock value ]
]

{ #category : 't - observable collection - testing' }
TToObservableCollection >> ifNotEmpty: aBlock [
	"Evaluate the given block with the receiver as argument, answering its value
	unless the receiver is empty, in which case answer the receiver."

	^ self isEmpty
		ifTrue: [ self ]
		ifFalse: [ aBlock cull: self ]
]

{ #category : 't - observable collection - testing' }
TToObservableCollection >> includes: anObject [

	^ list includes: anObject 
]

{ #category : 't - observable collection - accessing' }
TToObservableCollection >> indexOf: anElement [
	"Answer the index of the first occurrence of anElement within the
	receiver. If the receiver does not contain anElement, answer 0."
	"(#(a b c d e) indexOf: #c) >>> 3"
	"(#(a b c d e) indexOf: #x) >>> 0"

	^ self indexOf: anElement ifAbsent: 0
]

{ #category : 't - observable collection - accessing' }
TToObservableCollection >> indexOf: anElement ifAbsent: exceptionBlock [
	"Answer the index of the first occurrence of anElement within the
	receiver. If the receiver does not contain anElement, answer the
	result of evaluating the argument, exceptionBlock."
	"(#(a b c d e) indexOf: #c ifAbsent: 7) >>> 3"
	"(#(a b c d e) indexOf: #x ifAbsent: 7) >>> 7"

	^ self indexOf: anElement startingAt: 1 ifAbsent: exceptionBlock
]

{ #category : 't - observable collection - accessing' }
TToObservableCollection >> indexOf: anElement startingAt: start ifAbsent: exceptionBlock [
	"Answer the index of the first occurrence of anElement after start
	within the receiver. If the receiver does not contain anElement,
	answer the 	result of evaluating the argument, exceptionBlock."
	"(#(a b c d e) indexOf: #c startingAt: 2 ifAbsent: 7) >>> 3"
	"(#(a b c d e) indexOf: #c startingAt: 4 ifAbsent: 7) >>> 7"

	^ list indexOf: anElement startingAt: start ifAbsent: exceptionBlock
]

{ #category : 't - observable collection - initialization' }
TToObservableCollection >> initializeObservableCollection [

	list := OrderedCollection new
]

{ #category : 't - observable collection - testing' }
TToObservableCollection >> isEmpty [

	^ list isEmpty 
]

{ #category : 't - observable collection - testing' }
TToObservableCollection >> isNotEmpty [

	^ self isEmpty not
]

{ #category : 't - observable collection - accessing' }
TToObservableCollection >> last [

	^ list last
]

{ #category : 't - observable collection - accessing' }
TToObservableCollection >> last: n [
	"Answer the last n elements of the receiver.  
	Raise an error if there are not enough elements."

	| size |
	size := self size.
	^ self copyFrom: size - n + 1 to: size
]

{ #category : 't - observable collection - enumerating' }
TToObservableCollection >> noneSatisfy: aBlock [

	^ list noneSatisfy: aBlock
]

{ #category : 't - observable collection - notifications' }
TToObservableCollection >> notifyAddChangeAround: aBlock candidates: aCollection interval: anInterval [

	self notifyEmptinessChangeAfter: [
		self fireEvent: (ToCollectionBeforeAddEvent new
				 interval: anInterval;
				 candidates: aCollection;
				 yourself).
		aBlock value.
		self fireEvent: (ToCollectionAddEvent new interval: anInterval) ]
]

{ #category : 't - observable collection - notifications' }
TToObservableCollection >> notifyEmptinessChangeAfter: aBlock [ 

	| wasEmpty |
	wasEmpty := list isEmpty.
	aBlock value.
	wasEmpty = list isEmpty ifFalse: [ self fireEvent: ToCollectionEmptinessEvent new ]
]

{ #category : 't - observable collection - notifications' }
TToObservableCollection >> notifyFilterChangeAround: aBlock interval: anInterval [

	self notifyEmptinessChangeAfter: [
		self fireEvent: (ToCollectionBeforeFilterEvent new interval: (1 to: self size)).
		aBlock value.
		self fireEvent: (ToCollectionFilterEvent new interval: anInterval) ]
]

{ #category : 't - observable collection - notifications' }
TToObservableCollection >> notifyRemoveChangeAround: aBlock removed: aCollection interval: anInterval [

	self notifyEmptinessChangeAfter: [
		self fireEvent: (ToCollectionBeforeRemoveEvent new interval: anInterval).
		aBlock value.
		self fireEvent: (ToCollectionRemoveEvent new
				 interval: anInterval;
				 removed: aCollection;
				 yourself) ]
]

{ #category : 't - observable collection - notifications' }
TToObservableCollection >> notifyUpdateChangeAround: aBlock interval: anInterval [

	self fireEvent: (ToCollectionBeforeUpdateEvent new interval: anInterval).	
	aBlock value.
	self fireEvent: (ToCollectionUpdateEvent new interval: anInterval).
]

{ #category : 't - observable collection - copying' }
TToObservableCollection >> postCopy [
	list := list copy
]

{ #category : 't - observable collection - enumerating' }
TToObservableCollection >> reject: aBlock [

	^ list reject: aBlock
]

{ #category : 't - observable collection - removing' }
TToObservableCollection >> remove: anObject [

	| idx |
	idx := self indexOf: anObject.
	self removeAt: idx

	
]

{ #category : 't - observable collection - removing' }
TToObservableCollection >> removeAll [

	| s |
	s := list size.
	s isZero ifTrue: [ ^ self ].
	self notifyRemoveChangeAround: [ list removeAll ] removed: list interval: (1 to: s)
]

{ #category : 't - observable collection - removing' }
TToObservableCollection >> removeAt: removedIndex [

	self
		notifyRemoveChangeAround: [ list removeAt: removedIndex ]
		removed: (Array with: (list at: removedIndex)) 
		interval: (removedIndex to: removedIndex)
]

{ #category : 't - observable collection - removing' }
TToObservableCollection >> removeFirst [

	self
		notifyRemoveChangeAround: [ list removeFirst ]
		removed: (Array with: list first)
		interval: (1 to: 1)
]

{ #category : 't - observable collection - removing' }
TToObservableCollection >> removeFirst: n [ 

	self 
		notifyRemoveChangeAround: [ list removeFirst: n ] 		
		removed: (Array withAll: (list copyFrom: 1 to: n))
		interval: (1 to: n)
]

{ #category : 't - observable collection - removing' }
TToObservableCollection >> removeFrom: start to: stop [

	self
		notifyRemoveChangeAround: [
			| idx |
			idx := start.
			[ idx > stop ] whileFalse: [
				list removeAt: start.
				idx := idx + 1 ] ]
		removed: (Array withAll: (list copyFrom: start to: stop))
		interval: (start to: stop)
]

{ #category : 't - observable collection - removing' }
TToObservableCollection >> removeLast [

	self
		notifyRemoveChangeAround: [ list removeLast ]
		removed: (Array with: list last)
		interval: (self size + 1 to: self size + 1)
]

{ #category : 't - observable collection - removing' }
TToObservableCollection >> removeLast: n [

	| s |
	s := self size.
	s isZero ifTrue: [ ^ self ].
	self
		notifyRemoveChangeAround: [ list removeLast: n ]
		removed: (Array withAll: (list copyFrom: (s - n + 1) to: s))
		interval: (s - n + 1 to: s)
]

{ #category : 't - observable collection - accessing' }
TToObservableCollection >> replaceFrom: start to: stop with: replacement [ 

	self replaceFrom: start to: stop with: replacement startingAt: 1.
]

{ #category : 't - observable collection - accessing' }
TToObservableCollection >> replaceFrom: start to: stop with: replacement startingAt: repStart [ 

	(replacement size - repStart) = (stop - start)
		ifFalse: [self error: 'Size of replacement doesnt match'].

	self
		notifyUpdateChangeAround: [ list replaceFrom: start to: stop with: replacement startingAt: repStart ]
		interval: (start to: stop)
]

{ #category : 't - observable collection - enumerating' }
TToObservableCollection >> reverseDo: aBlock [

	list reverseDo: aBlock
]

{ #category : 't - observable collection - copying' }
TToObservableCollection >> reversed [

	"Answer a copy of the receiver with element order reversed.  "

	^ self species newFrom: list reversed
]

{ #category : 't - observable collection - accessing' }
TToObservableCollection >> second [

	^ list second
]

{ #category : 't - observable collection - enumerating' }
TToObservableCollection >> select: aBlock [

	^ list select: aBlock
]

{ #category : 't - observable collection - accessing' }
TToObservableCollection >> size [

	^ list size
]

{ #category : 't - observable collection - accessing' }
TToObservableCollection >> third [

	^ list third
]

{ #category : 't - observable collection - event management' }
TToObservableCollection >> whenAddChangeDo: aBlock [

	self when: ToCollectionAddEvent  do: [ :ann | aBlock cull: ann ] 
]

{ #category : 't - observable collection - event management' }
TToObservableCollection >> whenBeforeAddChangeDo: aBlock [

	self when: ToCollectionBeforeAddEvent  do: [ :ann | aBlock cull: ann ] 
]

{ #category : 't - observable collection - event management' }
TToObservableCollection >> whenBeforeFilterChangeDo: aBlock [

	self when: ToCollectionBeforeFilterEvent  do: [ :ann | aBlock cull: ann ] 
]

{ #category : 't - observable collection - event management' }
TToObservableCollection >> whenBeforeRemoveChangeDo: aBlock [

	self when: ToCollectionBeforeRemoveEvent  do: [ :ann | aBlock cull: ann ] 
]

{ #category : 't - observable collection - event management' }
TToObservableCollection >> whenBeforeUpdateChangeDo: aBlock [

	self when: ToCollectionBeforeUpdateEvent  do: [ :ann | aBlock cull: ann ] 
]

{ #category : 't - observable collection - event management' }
TToObservableCollection >> whenFilterChangeDo: aBlock [

	self when: ToCollectionFilterEvent  do: [ :event | aBlock cull: event ] 
]

{ #category : 't - observable collection - event management' }
TToObservableCollection >> whenRemoveChangeDo: aBlock [

	self when: ToCollectionRemoveEvent  do: [ :ann | aBlock cull: ann ] 
]

{ #category : 't - observable collection - event management' }
TToObservableCollection >> whenUpdateChangeDo: aBlock [

	self when: ToCollectionUpdateEvent  do: [ :ann | aBlock cull: ann ] 
]
