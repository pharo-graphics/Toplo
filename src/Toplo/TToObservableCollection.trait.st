Trait {
	#name : #TToObservableCollection,
	#category : #'Toplo-Core-Collection'
}

{ #category : #'t - observable collection - copying' }
TToObservableCollection >> , otherCollection [ 
	"Concatenate two Strings or Collections."
	
	^ self copyReplaceFrom: self size + 1
		  to: self size
		  with: otherCollection
]

{ #category : #'t - observable collection - adding' }
TToObservableCollection >> add: newObject [

	self addLast: newObject 
]

{ #category : #'t - observable collection - adding' }
TToObservableCollection >> add: newObject after: oldObject [

	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just succeeding oldObject. Answer newObject.
	Raises an error if oldObject is not found"

	| idx |
	idx := self collection indexOf: oldObject.
	self add: newObject afterIndex: idx
]

{ #category : #'t - observable collection - adding' }
TToObservableCollection >> add: newObject afterIndex: index [
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just after index. Answer newObject."

	| interval |
	interval := index + 1 to: index + 1.
	self
		notifyAddChangeAround: [
			self collection add: newObject afterIndex: index.
			self dispatchEvent: (ToCollectionAddEvent new interval: interval) ]
		candidates: (Array with: newObject)
		interval: interval
]

{ #category : #'t - observable collection - adding' }
TToObservableCollection >> add: newObject before: oldObject [ 
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just preceding oldObject. Answer newObject."

	| idx |
	idx := self indexOf: oldObject.
	self add: newObject beforeIndex: idx
]

{ #category : #'t - observable collection - adding' }
TToObservableCollection >> add: newObject beforeIndex: index [ 
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just before index. Answer newObject."

	| interval |
	interval := index to: index .
	self
		notifyAddChangeAround: [
			self collection add: newObject beforeIndex: index.
			self dispatchEvent: (ToCollectionAddEvent new interval: interval) ]
		candidates: (Array with: newObject)
		interval: interval
]

{ #category : #'t - observable collection - adding' }
TToObservableCollection >> addAll: aCollection [ 
	"Add each element of aCollection at my end. Answer aCollection."

	^ self addAllLast: aCollection
]

{ #category : #'t - observable collection - adding' }
TToObservableCollection >> addAllFirst: aCollection [

	| interval |
	aCollection ifEmpty: [ ^ self ].
	interval := 1 to: aCollection size.
	self
		notifyAddChangeAround: [
			self collection addAllFirst: aCollection.
			self dispatchEvent: (ToCollectionAddEvent new interval: interval) ]
		candidates: aCollection
		interval: interval
]

{ #category : #'t - observable collection - adding' }
TToObservableCollection >> addAllLast: aCollection [

	| idx interval |
	aCollection ifEmpty: [ ^ self ].
	idx := self collection size.
	interval := idx + 1 to: idx + aCollection size.
	self
		notifyAddChangeAround: [
			self collection addAllLast: aCollection.
			self dispatchEvent: (ToCollectionAddEvent new interval: interval) ]
		candidates: aCollection
		interval: interval
]

{ #category : #'t - observable collection - adding' }
TToObservableCollection >> addFirst: newObject [
	"Add newObject to the end of the receiver. Answer newObject."

	| interval |
	interval := 1 to: 1.
	self
		notifyAddChangeAround: [
			self collection addFirst: newObject.
			self dispatchEvent: (ToCollectionAddEvent new interval: interval) ]
		candidates: (Array with: newObject)
		interval: interval
]

{ #category : #'t - observable collection - adding' }
TToObservableCollection >> addLast: newObject [

	"Add newObject to the end of the receiver. Answer newObject."
	| interval |
	interval := self size + 1 to: self size + 1.
	self
		notifyAddChangeAround: [
			self collection addLast: newObject.
			self dispatchEvent: (ToCollectionAddEvent new interval: interval) ]
		candidates: (Array with: newObject)
		interval: interval
]

{ #category : #'t - observable collection - enumerating' }
TToObservableCollection >> allSatisfy: aBlock [

	^ self collection allSatisfy: aBlock
]

{ #category : #'t - observable collection - enumerating' }
TToObservableCollection >> anySatisfy: aBlock [

	^ self collection anySatisfy: aBlock
]

{ #category : #'t - observable collection - converting' }
TToObservableCollection >> asArray [

	^ self collection asArray
]

{ #category : #'t - observable collection - converting' }
TToObservableCollection >> asOrderedCollection [

	^ OrderedCollection newFrom: self collection
]

{ #category : #'t - observable collection - accessing' }
TToObservableCollection >> at: anInteger [ 

	^ self collection at: anInteger
]

{ #category : #'t - observable collection - accessing' }
TToObservableCollection >> at: anInteger put: anObject [

	| interval |
	interval := anInteger to: anInteger.
	self
		notifyUpdateChangeAround: [
			self collection at: anInteger put: anObject.
			self dispatchEvent: (ToCollectionUpdateEvent new
					 interval: interval;
					 yourself) ]
		interval: interval
]

{ #category : #'t - observable collection - enumerating' }
TToObservableCollection >> collect: aBlock [

	^ self collection collect: aBlock
]

{ #category : #'t - observable collection - accessing' }
TToObservableCollection >> collection [

	^ self explicitRequirement

]

{ #category : #'t - observable collection - copying' }
TToObservableCollection >> copyFrom: startIndex to: endIndex [ 
	"Answer a copy of the receiver that contains elements from position
	startIndex to endIndex."

	| l |
	l := self collection copyFrom: startIndex to: endIndex.
	^ self species newFrom: l
]

{ #category : #'t - observable collection - copying' }
TToObservableCollection >> copyReplaceFrom: start to: stop with: replacementCollection [

	"Concatenate two Strings or Collections."

	| l n |
	l := self collection copyReplaceFrom: start to: stop with: replacementCollection.
	n := self species newFrom: l.
	^ n
]

{ #category : #'t - observable collection - enumerating' }
TToObservableCollection >> detect: aBlock ifNone: exceptionBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument.
	Answer the first element for which aBlock evaluates to true. If none
	evaluate to true, then evaluate the argument, exceptionBlock."
	
	^ self collection detect: aBlock ifNone: exceptionBlock
]

{ #category : #'t - observable collection - enumerating' }
TToObservableCollection >> detectIndex: aBlock [ 

	"Return index of first element that satisfies aBlock.
	If no matching element is found, raise an error."
	
	^ self collection detectIndex: aBlock 
]

{ #category : #'t - observable collection - enumerating' }
TToObservableCollection >> detectIndex: aBlock ifNone: exceptionBlock [

	"Return index of first element that satisfies aBlock.
	If no matching element is found, evaluate exceptionBlock."

	"(#(1 5 10) detectIndex: [ :each | each > 3 ] ifNone: ['Not found']) >>> 2"
	"(#(1 5 10) detectIndex: [ :each | each > 15 ] ifNone: ['Not found']) >>> 'Not found'"
	
	^ self collection detectIndex: aBlock ifNone: exceptionBlock
]

{ #category : #'t - observable collection - enumerating' }
TToObservableCollection >> do: aBlock [

	self collection do: aBlock
]

{ #category : #'t - observable collection - accessing' }
TToObservableCollection >> fifth [

	^ self collection fifth
]

{ #category : #'t - observable collection - removing' }
TToObservableCollection >> filterResult: aCollection [

	| interval |
	interval := 1 to: aCollection size.
	self
		notifyFilterAround: [
			self collection reset.
			self collection addAll: aCollection.
			self dispatchEvent:
				(ToCollectionFilteredEvent new interval: interval) ]
		interval: interval
]

{ #category : #'t - observable collection - accessing' }
TToObservableCollection >> first [

	^ self collection first
]

{ #category : #'t - observable collection - copying' }
TToObservableCollection >> first: n [
	"Answer the first n elements of the receiver.
	Raise an error if there are not enough elements."

	^ self copyFrom: 1 to: n
]

{ #category : #'t - observable collection - accessing' }
TToObservableCollection >> fourth [

	^ self collection fourth
]

{ #category : #'t - observable collection - testing' }
TToObservableCollection >> ifEmpty: aBlock [
	"Evaluate the given block with the receiver as argument, answering its value
	unless the receiver is not empty, in which case answer the receiver."

	^ self isEmpty
		ifFalse: [ self ]
		ifTrue: [ aBlock value ]
]

{ #category : #'t - observable collection - testing' }
TToObservableCollection >> ifEmpty: emptyBlock ifNotEmpty: notEmptyBlock [
	"Evaluate the given block with the receiver as argument, answering its value
	unless the receiver is empty, in which case answer the receiver."

	^ self isEmpty
		ifTrue: [ emptyBlock cull: self ]
		ifFalse: [ notEmptyBlock cull: self ]
]

{ #category : #'t - observable collection - testing' }
TToObservableCollection >> ifNotEmpty: aBlock [
	"Evaluate the given block with the receiver as argument, answering its value
	unless the receiver is empty, in which case answer the receiver."

	^ self isEmpty
		ifTrue: [ self ]
		ifFalse: [ aBlock cull: self ]
]

{ #category : #'t - observable collection - testing' }
TToObservableCollection >> ifNotEmpty: notEmptyBlock ifEmpty: emptyBlock [ 
	"Evaluate the given block with the receiver as argument, answering its value
	unless the receiver is empty, in which case answer the receiver."

	^ self isEmpty
		ifTrue: [ emptyBlock cull: self ]
		ifFalse: [ notEmptyBlock cull: self ]
]

{ #category : #'t - observable collection - testing' }
TToObservableCollection >> includes: anObject [

	^ self collection includes: anObject 
]

{ #category : #'t - observable collection - accessing' }
TToObservableCollection >> indexOf: anElement [
	"Answer the index of the first occurrence of anElement within the
	receiver. If the receiver does not contain anElement, answer 0."
	"(#(a b c d e) indexOf: #c) >>> 3"
	"(#(a b c d e) indexOf: #x) >>> 0"

	^ self indexOf: anElement ifAbsent: 0
]

{ #category : #'t - observable collection - accessing' }
TToObservableCollection >> indexOf: anElement ifAbsent: exceptionBlock [
	"Answer the index of the first occurrence of anElement within the
	receiver. If the receiver does not contain anElement, answer the
	result of evaluating the argument, exceptionBlock."
	"(#(a b c d e) indexOf: #c ifAbsent: 7) >>> 3"
	"(#(a b c d e) indexOf: #x ifAbsent: 7) >>> 7"

	^ self indexOf: anElement startingAt: 1 ifAbsent: exceptionBlock
]

{ #category : #'t - observable collection - accessing' }
TToObservableCollection >> indexOf: anElement startingAt: start ifAbsent: exceptionBlock [
	"Answer the index of the first occurrence of anElement after start
	within the receiver. If the receiver does not contain anElement,
	answer the 	result of evaluating the argument, exceptionBlock."
	"(#(a b c d e) indexOf: #c startingAt: 2 ifAbsent: 7) >>> 3"
	"(#(a b c d e) indexOf: #c startingAt: 4 ifAbsent: 7) >>> 7"

	^ self collection indexOf: anElement startingAt: start ifAbsent: exceptionBlock
]

{ #category : #'t - observable collection - initialization' }
TToObservableCollection >> initializeWith: aCollection [

		self collection removeAll.
		self collection addAll: aCollection
]

{ #category : #'t - observable collection - testing' }
TToObservableCollection >> isEmpty [

	^ self collection isEmpty 
]

{ #category : #'t - observable collection - testing' }
TToObservableCollection >> isNotEmpty [

	^ self isEmpty not
]

{ #category : #'t - observable collection - accessing' }
TToObservableCollection >> itemCount [ 

	^ self size
]

{ #category : #'t - observable collection - accessing' }
TToObservableCollection >> last [

	^ self collection last
]

{ #category : #'t - observable collection - accessing' }
TToObservableCollection >> last: n [
	"Answer the last n elements of the receiver.  
	Raise an error if there are not enough elements."

	| size |
	size := self size.
	^ self copyFrom: size - n + 1 to: size
]

{ #category : #'t - observable collection - accessing' }
TToObservableCollection >> newMirror [

	^ ToCollectionMirror new
		  mirroredTo: self;
		  yourself
]

{ #category : #'t - observable collection - enumerating' }
TToObservableCollection >> noneSatisfy: aBlock [

	^ self collection noneSatisfy: aBlock
]

{ #category : #'t - observable collection - notifications' }
TToObservableCollection >> notifyAddChangeAround: aBlock candidates: aCollection interval: anInterval [

	self notifyEmptinessChangeAfter: [
		self dispatchAuthorisationRequest: (ToCollectionAddRequest new
				 interval: anInterval;
				 candidates: aCollection;
				 requestedAction: aBlock;
				 yourself) ]
]

{ #category : #'t - observable collection - notifications' }
TToObservableCollection >> notifyEmptinessChangeAfter: aBlock [

	| wasEmpty |
	wasEmpty := self collection isEmpty.
	aBlock value.
	wasEmpty = self collection isEmpty ifFalse: [
		self dispatchEvent: ToCollectionEmptinessEvent new ]
]

{ #category : #'t - observable collection - notifications' }
TToObservableCollection >> notifyFilterAround: aBlock interval: anInterval [

	self notifyEmptinessChangeAfter: [
		self dispatchAuthorisationRequest: (ToCollectionFilterRequest new
				 interval: (1 to: self size);
				 requestedAction: aBlock;
				 yourself) ]
]

{ #category : #'t - observable collection - notifications' }
TToObservableCollection >> notifyRemoveChangeAround: aBlock removed: aCollection interval: anInterval [

	self notifyEmptinessChangeAfter: [
		self dispatchAuthorisationRequest: (ToCollectionRemoveRequest new
				 interval: anInterval;
				 requestedAction: aBlock;
				 yourself) ]
]

{ #category : #'t - observable collection - notifications' }
TToObservableCollection >> notifySievedWith: aSieve around: aBlock interval: anInterval [

	self notifyEmptinessChangeAfter: [
		self dispatchAuthorisationRequest: (ToCollectionFilterRequest new
				 interval: (1 to: self size);
				 requestedAction: aBlock;
				 yourself) ]
]

{ #category : #'t - observable collection - notifications' }
TToObservableCollection >> notifyUpdateAllChangeAround: aBlock [

	self notifyEmptinessChangeAfter: [
		| interval |
		interval := 1 to: self size.
		self dispatchAuthorisationRequest:
			(ToCollectionUpdateAllRequest new
				 interval: interval;
				 requestedAction: aBlock;
				 yourself) ]
]

{ #category : #'t - observable collection - notifications' }
TToObservableCollection >> notifyUpdateChangeAround: aBlock interval: anInterval [

	self dispatchAuthorisationRequest: (ToCollectionUpdateRequest new
			 interval: anInterval;
			 requestedAction: aBlock;
			 yourself)
]

{ #category : #'t - observable collection - removing' }
TToObservableCollection >> onSievedWith: aSieve [

	| interval |
	interval := 1 to: aSieve currentData size.
	self
		notifySievedWith: aSieve
		around: [
			self initializeWith: aSieve currentData.
			self dispatchEvent: (ToCollectionSievedEvent new
					 interval: interval;
					 sieve: aSieve;
					 yourself) ]
		interval: interval
]

{ #category : #'t - observable collection - copying' }
TToObservableCollection >> postCopy [

	self explicitRequirement 
]

{ #category : #'t - observable collection - enumerating' }
TToObservableCollection >> reject: aBlock [

	^ self collection reject: aBlock
]

{ #category : #'t - observable collection - removing' }
TToObservableCollection >> remove: anObject [

	| idx |
	idx := self indexOf: anObject.
	self removeAt: idx

	
]

{ #category : #'t - observable collection - removing' }
TToObservableCollection >> removeAll [

	| s interval removed |
	s := self collection size.
	s isZero ifTrue: [ ^ self ].
	removed := self collection asArray.
	interval := 1 to: s.
	self
		notifyRemoveChangeAround: [
			self collection removeAll.
			self dispatchEvent: (ToCollectionRemoveEvent new
					 interval: interval;
					 removed: removed;
					 yourself) ]
		removed: removed
		interval: interval
]

{ #category : #'t - observable collection - removing' }
TToObservableCollection >> removeAll: aCollection [

	aCollection do: [ :e | self remove: e ]
]

{ #category : #'t - observable collection - removing' }
TToObservableCollection >> removeAllSuchThat: aBlock [

	| s indexes |
	s := self collection size.
	s isZero ifTrue: [ ^ self ].
	indexes := Array streamContents: [ :stream |
		           self collection withIndexDo: [ :elem :idx |
			           (aBlock value: elem) ifTrue: [ stream nextPut: idx ] ] ].
	indexes do: [ :idx | self removeAt: idx ]
]

{ #category : #'t - observable collection - removing' }
TToObservableCollection >> removeAt: removedIndex [

	| interval removed |
	interval := removedIndex to: removedIndex.
	removed := Array with: (self collection at: removedIndex).
	self
		notifyRemoveChangeAround: [
			self collection removeAt: removedIndex.
			self dispatchEvent: (ToCollectionRemoveEvent new
					 interval: interval;
					 removed: removed;
					 yourself) ]
		removed: removed
		interval: interval
]

{ #category : #'t - observable collection - removing' }
TToObservableCollection >> removeFirst [

	| interval removed |
	interval := 1 to: 1.
	removed := Array with: self collection first.
	self
		notifyRemoveChangeAround: [
			self collection removeFirst.
			self dispatchEvent: (ToCollectionRemoveEvent new
					 interval: interval;
					 removed: removed;
					 yourself) ]
		removed: removed
		interval: interval
]

{ #category : #'t - observable collection - removing' }
TToObservableCollection >> removeFirst: n [

	| interval removed |
	interval := 1 to: n.
	removed := Array withAll: (self collection copyFrom: 1 to: n).
	self
		notifyRemoveChangeAround: [
			self collection removeFirst: n.
			self dispatchEvent: (ToCollectionRemoveEvent new
					 interval: interval;
					 removed: removed;
					 yourself) ]
		removed: removed
		interval: interval
]

{ #category : #'t - observable collection - removing' }
TToObservableCollection >> removeFrom: start to: stop [

	| interval removed |
	interval := start to: stop.
	removed := Array withAll: (self collection copyFrom: start to: stop).
	self
		notifyRemoveChangeAround: [
			| idx |
			idx := start.
			[ idx > stop ] whileFalse: [
				self collection removeAt: start.
				idx := idx + 1 ].
			self dispatchEvent: (ToCollectionRemoveEvent new
					 interval: interval;
					 removed: removed;
					 yourself) ]
		removed: removed
		interval: interval
]

{ #category : #'t - observable collection - removing' }
TToObservableCollection >> removeLast [

	| interval removed |
	interval := self size + 1 to: self size + 1.
	removed := Array with: self collection last.
	self
		notifyRemoveChangeAround: [
			self collection removeLast.
			self dispatchEvent: (ToCollectionRemoveEvent new
					 interval: interval;
					 removed: removed;
					 yourself) ]
		removed: removed
		interval: interval
]

{ #category : #'t - observable collection - removing' }
TToObservableCollection >> removeLast: n [

	| s interval removed |
	s := self size.
	s isZero ifTrue: [ ^ self ].

	interval := s - n + 1 to: s.
	removed := Array withAll: (self collection copyFrom: s - n + 1 to: s).
	self
		notifyRemoveChangeAround: [
			self collection removeLast: n.
			self dispatchEvent: (ToCollectionRemoveEvent new
					 interval: interval;
					 removed: removed;
					 yourself) ]
		removed: removed
		interval: interval
]

{ #category : #'t - observable collection - accessing' }
TToObservableCollection >> replaceFrom: start to: stop with: replacement [ 

	self replaceFrom: start to: stop with: replacement startingAt: 1.
]

{ #category : #'t - observable collection - accessing' }
TToObservableCollection >> replaceFrom: start to: stop with: replacement startingAt: repStart [

	| interval |
	replacement size - repStart = (stop - start) ifFalse: [
		self error: 'Size of replacement doesnt match' ].
	interval := start to: stop.
	self
		notifyUpdateChangeAround: [
			self collection
				replaceFrom: start
				to: stop
				with: replacement
				startingAt: repStart.
			self dispatchEvent: (ToCollectionUpdateEvent new
					 interval: interval;
					 yourself) ]
		interval: interval
]

{ #category : #'t - observable collection - initialization' }
TToObservableCollection >> reset [

		self collection reset
]

{ #category : #'t - observable collection - enumerating' }
TToObservableCollection >> reverseDo: aBlock [

	self collection reverseDo: aBlock
]

{ #category : #'t - observable collection - copying' }
TToObservableCollection >> reversed [

	"Answer a copy of the receiver with element order reversed.  "

	^ self species newFrom: self collection reversed
]

{ #category : #'t - observable collection - accessing' }
TToObservableCollection >> second [

	^ self collection second
]

{ #category : #'t - observable collection - enumerating' }
TToObservableCollection >> select: aBlock [

	^ self collection select: aBlock
]

{ #category : #'t - observable collection - accessing' }
TToObservableCollection >> size [

	^ self collection size
]

{ #category : #'t - observable collection - accessing' }
TToObservableCollection >> third [

	^ self collection third
]

{ #category : #'t - observable collection - initialization' }
TToObservableCollection >> updateAllWith: aCollection [

	| interval |
	interval := 1 to: aCollection size.
	self notifyUpdateAllChangeAround: [
		self initializeWith: aCollection.
		self dispatchEvent: (ToCollectionAllUpdatedEvent new
				 interval: interval;
				 yourself) ]
]

{ #category : #'t - observable collection - enumerating' }
TToObservableCollection >> with: aCollection do: aBlock [
	"aCollection must support #at:at: and be at least as large as the receiver."

	self collection with: aCollection do: aBlock
]

{ #category : #'t - observable collection - enumerating' }
TToObservableCollection >> withIndexCollect: elementAndIndexBlock [
	"Just like with:collect: except that the iteration index supplies the second argument to the block."

	"(#(10 20 30) withIndexCollect: [:each :index | each + (index * 2)]) >>> #(12 24 36)"

	^ self collection withIndexCollect: elementAndIndexBlock
]

{ #category : #'t - observable collection - enumerating' }
TToObservableCollection >> withIndexDo: elementAndIndexBlock [
	"Just like do: except that the iteration index supplies the second argument to the block"
	"Support collection enumeration with a counter, even though not ordered"

	"|s|s:=0. #(4 2 1) withIndexDo: [:e :i| s:=s + (e * (10 ** (i-1)))]. s >>> 124"

	"|a|a:= Array new: 3. #(10 20 30) withIndexDo: [:e :i| a at: 4-i put: e+1]. a >>> #(31 21 11)"

	self collection withIndexDo: elementAndIndexBlock
]

{ #category : #'t - observable collection - enumerating' }
TToObservableCollection >> withIndexSelect: elementAndIndexBlock [
	"select elements from the receiver that the block evaluates true with the element and its index."

	"(#('We' 'love' 'pharo!') withIndexSelect: [:value :index | value size - 1 <= index]) >>> #('We')"
	
	^ self collection withIndexSelect: elementAndIndexBlock
]
