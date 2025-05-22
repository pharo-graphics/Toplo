Trait {
	#name : #TToOrderedCollectionLikeAPI,
	#category : #'Toplo-Core-Collection'
}

{ #category : #'t - collection api - copying' }
TToOrderedCollectionLikeAPI >> , otherCollection [ 
	"Concatenate two Strings or Collections."
	
	^ self subclassResponsibility 
]

{ #category : #'t - collection api - adding' }
TToOrderedCollectionLikeAPI >> add: newObject [

	self addLast: newObject 
]

{ #category : #'t - collection api - adding' }
TToOrderedCollectionLikeAPI >> add: newObject after: oldObject [

	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just succeeding oldObject. Answer newObject.
	Raises an error if oldObject is not found"

	| idx |
	idx := self indexOf: oldObject.
	self add: newObject afterIndex: idx
]

{ #category : #'t - collection api - adding' }
TToOrderedCollectionLikeAPI >> add: newObject afterIndex: index [
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just after index. Answer newObject."

	self subclassResponsibility 
]

{ #category : #'t - collection api - adding' }
TToOrderedCollectionLikeAPI >> add: newObject before: oldObject [ 
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just preceding oldObject. Answer newObject."

	| idx |
	idx := self indexOf: oldObject.
	self add: newObject beforeIndex: idx
]

{ #category : #'t - collection api - adding' }
TToOrderedCollectionLikeAPI >> add: newObject beforeIndex: index [ 
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just before index. Answer newObject."

	self subclassResponsibility 
]

{ #category : #'t - collection api - adding' }
TToOrderedCollectionLikeAPI >> addAll: aCollection [ 
	"Add each element of aCollection at my end. Answer aCollection."

	^ self addAllLast: aCollection
]

{ #category : #'t - collection api - adding' }
TToOrderedCollectionLikeAPI >> addAllFirst: aCollection [

	aCollection reverseDo: [ :each | self addFirst: each ].
	^ aCollection
]

{ #category : #'t - collection api - adding' }
TToOrderedCollectionLikeAPI >> addAllLast: aCollection [

	"Add each element of aCollection at the end of the receiver.
	Answer aCollection."

	aCollection do: [ :each | self addLast: each ].
	^ aCollection
]

{ #category : #'t - collection api - adding' }
TToOrderedCollectionLikeAPI >> addFirst: newObject [
	"Add newObject to the end of the receiver. Answer newObject."

	self subclassResponsibility 
]

{ #category : #'t - collection api - adding' }
TToOrderedCollectionLikeAPI >> addLast: newObject [

	"Add newObject to the end of the receiver. Answer newObject."
	self subclassResponsibility 
]

{ #category : #'t - collection api - enumerating' }
TToOrderedCollectionLikeAPI >> allSatisfy: aBlock [

	self do: [ :each | (aBlock value: each) ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #'t - collection api - enumerating' }
TToOrderedCollectionLikeAPI >> anySatisfy: aBlock [

	self do: [ :each | (aBlock value: each) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'t - collection api - converting' }
TToOrderedCollectionLikeAPI >> asArray [

	self subclassResponsibility 
]

{ #category : #'t - collection api - converting' }
TToOrderedCollectionLikeAPI >> asOrderedCollection [

	self subclassResponsibility 
]

{ #category : #'t - collection api - accessing' }
TToOrderedCollectionLikeAPI >> at: anInteger [ 

	^ 	self subclassResponsibility 
]

{ #category : #'t - collection api - accessing' }
TToOrderedCollectionLikeAPI >> at: anInteger put: anObject [

	self subclassResponsibility 
]

{ #category : #'t - collection api - enumerating' }
TToOrderedCollectionLikeAPI >> collect: aBlock [

	| newCollection |
	newCollection := self species new.
	self do: [:each | newCollection add: (aBlock value: each)].
	^ newCollection
]

{ #category : #'t - collection api - copying' }
TToOrderedCollectionLikeAPI >> copyFrom: start to: stop [
	"Answer a copy of a subset of the receiver, starting from element at
	index start until element at index stop."

	| newSize |
	newSize := stop - start + 1.
	^ (self species new: newSize)
		  replaceFrom: 1
		  to: newSize
		  with: self asArray
		  startingAt: start
]

{ #category : #'t - collection api - copying' }
TToOrderedCollectionLikeAPI >> copyReplaceFrom: start to: stop with: replacementCollection [

	"Concatenate two Strings or Collections."

	^ self subclassResponsibility 
]

{ #category : #'t - collection api - enumerating' }
TToOrderedCollectionLikeAPI >> detect: aBlock ifFound: foundBlock ifNone: exceptionBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument.
	Answer the first element for which aBlock evaluates to true. If none
	evaluate to true, then evaluate the argument, exceptionBlock."
	
	self
		do: [ :each |
			(aBlock value: each)
				ifTrue: [ ^ foundBlock cull: each ] ].
	^ exceptionBlock value
]

{ #category : #'t - collection api - enumerating' }
TToOrderedCollectionLikeAPI >> detect: aBlock ifNone: exceptionBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument.
	Answer the first element for which aBlock evaluates to true. If none
	evaluate to true, then evaluate the argument, exceptionBlock."
	
	^ self detect: aBlock ifFound: [ :element | element ] ifNone: exceptionBlock
]

{ #category : #'t - collection api - enumerating' }
TToOrderedCollectionLikeAPI >> detectIndex: aBlock [ 

	"Return index of first element that satisfies aBlock.
	If no matching element is found, raise an error."
	
	^ self detectIndex: aBlock ifNone: [ ]
]

{ #category : #'t - collection api - enumerating' }
TToOrderedCollectionLikeAPI >> detectIndex: aBlock ifNone: exceptionBlock [

	"Return index of first element that satisfies aBlock.
	If no matching element is found, evaluate exceptionBlock."

	"(#(1 5 10) detectIndex: [ :each | each > 3 ] ifNone: ['Not found']) >>> 2"
	"(#(1 5 10) detectIndex: [ :each | each > 15 ] ifNone: ['Not found']) >>> 'Not found'"
	
	self doWithIndex: [:each :index | (aBlock value: each) ifTrue: [^ index]].
	^ exceptionBlock value
]

{ #category : #'t - collection api - enumerating' }
TToOrderedCollectionLikeAPI >> do: aBlock [

	self subclassResponsibility 
]

{ #category : #'t - collection api - accessing' }
TToOrderedCollectionLikeAPI >> fifth [

	^ self at: 5
]

{ #category : #'t - collection api - accessing' }
TToOrderedCollectionLikeAPI >> first [

	^ self at: 1
]

{ #category : #'t - collection api - accessing' }
TToOrderedCollectionLikeAPI >> first: n [
	"Answer the first n elements of the receiver.
	Raise an error if there are not enough elements."

	^ self copyFrom: 1 to: n
]

{ #category : #'t - collection api - accessing' }
TToOrderedCollectionLikeAPI >> fourth [

	^ self at: 4
]

{ #category : #'t - collection api - testing' }
TToOrderedCollectionLikeAPI >> ifEmpty: aBlock [
	"Evaluate the given block with the receiver as argument, answering its value
	unless the receiver is not empty, in which case answer the receiver."

	^ self isEmpty
		ifFalse: [ self ]
		ifTrue: [ aBlock value ]
]

{ #category : #'t - collection api - testing' }
TToOrderedCollectionLikeAPI >> ifEmpty: emptyBlock ifNotEmpty: notEmptyBlock [
	"Evaluate the given block with the receiver as argument, answering its value
	unless the receiver is empty, in which case answer the receiver."

	^ self isEmpty
		ifTrue: [ emptyBlock cull: self ]
		ifFalse: [ notEmptyBlock cull: self ]
]

{ #category : #'t - collection api - testing' }
TToOrderedCollectionLikeAPI >> ifNotEmpty: aBlock [
	"Evaluate the given block with the receiver as argument, answering its value
	unless the receiver is empty, in which case answer the receiver."

	^ self isEmpty
		ifTrue: [ self ]
		ifFalse: [ aBlock cull: self ]
]

{ #category : #'t - collection api - testing' }
TToOrderedCollectionLikeAPI >> ifNotEmpty: notEmptyBlock ifEmpty: emptyBlock [ 
	"Evaluate the given block with the receiver as argument, answering its value
	unless the receiver is empty, in which case answer the receiver."

	^ self isEmpty
		ifTrue: [ emptyBlock cull: self ]
		ifFalse: [ notEmptyBlock cull: self ]
]

{ #category : #'t - collection api - testing' }
TToOrderedCollectionLikeAPI >> includes: anObject [

	^ (self indexOf: anObject) ~= 0
]

{ #category : #'t - collection api - accessing' }
TToOrderedCollectionLikeAPI >> indexOf: anElement [
	"Answer the index of the first occurrence of anElement within the
	receiver. If the receiver does not contain anElement, answer 0."
	"(#(a b c d e) indexOf: #c) >>> 3"
	"(#(a b c d e) indexOf: #x) >>> 0"

	^ self indexOf: anElement ifAbsent: 0
]

{ #category : #'t - collection api - accessing' }
TToOrderedCollectionLikeAPI >> indexOf: anElement ifAbsent: exceptionBlock [
	"Answer the index of the first occurrence of anElement within the
	receiver. If the receiver does not contain anElement, answer the
	result of evaluating the argument, exceptionBlock."
	"(#(a b c d e) indexOf: #c ifAbsent: 7) >>> 3"
	"(#(a b c d e) indexOf: #x ifAbsent: 7) >>> 7"

	^ self indexOf: anElement startingAt: 1 ifAbsent: exceptionBlock
]

{ #category : #'t - collection api - accessing' }
TToOrderedCollectionLikeAPI >> indexOf: anElement startingAt: start ifAbsent: exceptionBlock [
	"Answer the index of the first occurrence of anElement after start
	within the receiver. If the receiver does not contain anElement,
	answer the 	result of evaluating the argument, exceptionBlock."
	"(#(a b c d e) indexOf: #c startingAt: 2 ifAbsent: 7) >>> 3"
	"(#(a b c d e) indexOf: #c startingAt: 4 ifAbsent: 7) >>> 7"

	^ self subclassResponsibility 
]

{ #category : #'t - collection api - initialization' }
TToOrderedCollectionLikeAPI >> initializeWith: aCollection [

	self removeAll.
	self addAll: aCollection
]

{ #category : #'t - collection api - testing' }
TToOrderedCollectionLikeAPI >> isEmpty [

	^ self size isZero
]

{ #category : #'t - collection api - testing' }
TToOrderedCollectionLikeAPI >> isNotEmpty [

	^ self isEmpty not
]

{ #category : #'t - collection api - accessing' }
TToOrderedCollectionLikeAPI >> itemCount [ 

	^ self size
]

{ #category : #'t - collection api - accessing' }
TToOrderedCollectionLikeAPI >> last [

	^ self at: self size
]

{ #category : #'t - collection api - accessing' }
TToOrderedCollectionLikeAPI >> last: n [
	"Answer the last n elements of the receiver.  
	Raise an error if there are not enough elements."

	| size |
	size := self size.
	^ self copyFrom: size - n + 1 to: size
]

{ #category : #'t - collection api - accessing' }
TToOrderedCollectionLikeAPI >> newMirror [

	^ ToCollectionMirror new
		  mirroredTo: self;
		  yourself
]

{ #category : #'t - collection api - enumerating' }
TToOrderedCollectionLikeAPI >> noneSatisfy: aBlock [

	self do: [:item | (aBlock value: item) ifTrue: [^ false]].
	^ true
]

{ #category : #'t - collection api - enumerating' }
TToOrderedCollectionLikeAPI >> reject: aBlock [

	^ self select: [ :element | (aBlock value: element) == false ]
]

{ #category : #'t - collection api - removing' }
TToOrderedCollectionLikeAPI >> remove: anObject [

	| idx |
	idx := self indexOf: anObject.
	^ self removeAt: idx

	
]

{ #category : #'t - collection api - removing' }
TToOrderedCollectionLikeAPI >> removeAll [

	self subclassResponsibility 
]

{ #category : #'t - collection api - removing' }
TToOrderedCollectionLikeAPI >> removeAll: aCollection [

	aCollection do: [ :e | self remove: e ]
]

{ #category : #'t - collection api - removing' }
TToOrderedCollectionLikeAPI >> removeAllSuchThat: aBlock [

	self subclassResponsibility 
]

{ #category : #'t - collection api - removing' }
TToOrderedCollectionLikeAPI >> removeAt: removedIndex [

	self subclassResponsibility 
]

{ #category : #'t - collection api - removing' }
TToOrderedCollectionLikeAPI >> removeFirst [

	^ self removeAt: 1
]

{ #category : #'t - collection api - removing' }
TToOrderedCollectionLikeAPI >> removeFirst: n [

	| list |
	list := self species new: n.
	1
		to: n
		do:
			[ : i | list
				at: i
				put: self removeFirst ].
	^ list
]

{ #category : #'t - collection api - removing' }
TToOrderedCollectionLikeAPI >> removeFrom: start to: stop [

	self subclassResponsibility 
]

{ #category : #'t - collection api - removing' }
TToOrderedCollectionLikeAPI >> removeLast [

	^ self removeAt: self size
]

{ #category : #'t - collection api - removing' }
TToOrderedCollectionLikeAPI >> removeLast: n [

	| list |
	list := self species new: n.
	n
		to: 1
		by: -1
		do:
			[ : i | list
				at: i
				put: self removeLast ].
	^ list
]

{ #category : #'t - collection api - accessing' }
TToOrderedCollectionLikeAPI >> replaceFrom: start to: stop with: replacement [ 

	self replaceFrom: start to: stop with: replacement startingAt: 1.
]

{ #category : #'t - collection api - accessing' }
TToOrderedCollectionLikeAPI >> replaceFrom: start to: stop with: replacement startingAt: repStart [

	self subclassResponsibility 
]

{ #category : #'t - collection api - initialization' }
TToOrderedCollectionLikeAPI >> reset [

	self subclassResponsibility 
]

{ #category : #'t - collection api - enumerating' }
TToOrderedCollectionLikeAPI >> reverseDo: aBlock [

	self subclassResponsibility 
]

{ #category : #'t - collection api - copying' }
TToOrderedCollectionLikeAPI >> reversed [

	"Answer a copy of the receiver with element order reversed.  "

	^ self subclassResponsibility 
]

{ #category : #'t - collection api - accessing' }
TToOrderedCollectionLikeAPI >> second [

	^ self at: 2
]

{ #category : #'t - collection api - enumerating' }
TToOrderedCollectionLikeAPI >> select: aBlock [

	| newCollection |
	newCollection := self species new.
	self do: [ :each |
		(aBlock value: each) ifTrue: [ newCollection add: each ] ].
	^ newCollection
]

{ #category : #'t - collection api - accessing' }
TToOrderedCollectionLikeAPI >> size [

	^ self subclassResponsibility 
]

{ #category : #'t - collection api - accessing' }
TToOrderedCollectionLikeAPI >> third [

	^ self at: 3
]

{ #category : #'t - collection api - initialization' }
TToOrderedCollectionLikeAPI >> updateAllWith: aCollection [

	self removeAll.
	self addAll: aCollection
]

{ #category : #'t - collection api - enumerating' }
TToOrderedCollectionLikeAPI >> with: otherCollection do: twoArgBlock [
	"aCollection must support #at:at: and be at least as large as the receiver."

	otherCollection size = self size ifFalse: [self errorSizeMismatch].
	1 to: self size do:
		[:index |
		twoArgBlock value: (self at: index)
				value: (otherCollection at: index)]
]

{ #category : #'t - collection api - enumerating' }
TToOrderedCollectionLikeAPI >> withIndexCollect: elementAndIndexBlock [
	"Just like with:collect: except that the iteration index supplies the second argument to the block."

	"(#(10 20 30) withIndexCollect: [:each :index | each + (index * 2)]) >>> #(12 24 36)"

	| result |
	result := self species new: self size.
	1 to: self size do:
		[:index | result at: index put:
		(elementAndIndexBlock
			value: (self at: index)
			value: index)].
	^ result
]

{ #category : #'t - collection api - enumerating' }
TToOrderedCollectionLikeAPI >> withIndexDo: elementAndIndexBlock [
	"Just like do: except that the iteration index supplies the second argument to the block"
	"Support collection enumeration with a counter, even though not ordered"

	"|s|s:=0. #(4 2 1) withIndexDo: [:e :i| s:=s + (e * (10 ** (i-1)))]. s >>> 124"

	"|a|a:= Array new: 3. #(10 20 30) withIndexDo: [:e :i| a at: 4-i put: e+1]. a >>> #(31 21 11)"

	1 to: self size do: [ :index | elementAndIndexBlock value: (self at: index) value: index ]
]

{ #category : #'t - collection api - enumerating' }
TToOrderedCollectionLikeAPI >> withIndexSelect: elementAndIndexBlock [
	"select elements from the receiver that the block evaluates true with the element and its index."

	"(#('We' 'love' 'pharo!') withIndexSelect: [:value :index | value size - 1 <= index]) >>> #('We')"
	
	^ self species
		new: self size
		streamContents: [ :stream |
			1 to: self size do: [ :index |
				| each |
				(elementAndIndexBlock value: (each := self at: index) value: index)
					ifTrue: [ stream nextPut: each ] ] ]
]
