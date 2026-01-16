Trait {
	#name : #TToDataSourceWrapper,
	#category : #'Toplo-Core-Collection'
}

{ #category : #'t - data source wrapper - copying' }
TToDataSourceWrapper >> , otherCollection [ 
	"Concatenate two Strings or Collections."
	
	^ self asOrderedCollection, otherCollection
]

{ #category : #'t - data source wrapper - adding' }
TToDataSourceWrapper >> add: newObject [

	self addLast: newObject 
]

{ #category : #'t - data source wrapper - adding' }
TToDataSourceWrapper >> add: newObject after: oldObject [

	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just succeeding oldObject. Answer newObject.
	Raises an error if oldObject is not found"

	| idx |
	idx := self indexOf: oldObject.
	self add: newObject afterIndex: idx
]

{ #category : #'t - data source wrapper - adding' }
TToDataSourceWrapper >> add: newObject afterIndex: index [
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just after index. Answer newObject."

	self dataSource
		add: (self newWrapperForDataItem: newObject)
		afterIndex: index
]

{ #category : #'t - data source wrapper - adding' }
TToDataSourceWrapper >> add: newObject before: oldObject [ 
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just preceding oldObject. Answer newObject."

	| idx |
	idx := self indexOf: oldObject.
	self add: newObject beforeIndex: idx
]

{ #category : #'t - data source wrapper - adding' }
TToDataSourceWrapper >> add: newObject beforeIndex: index [ 
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just before index. Answer newObject."

	self dataSource
		add: (self newWrapperForDataItem: newObject)
		beforeIndex: index
]

{ #category : #'t - data source wrapper - adding' }
TToDataSourceWrapper >> addAll: aCollection [ 
	"Add each element of aCollection at my end. Answer aCollection."

	^ self addAllLast: aCollection
]

{ #category : #'t - data source wrapper - adding' }
TToDataSourceWrapper >> addAll: aCollection afterIndex: index [

	self dataSource
		addAll: (aCollection collect: [ :e | self newWrapperForDataItem: e ])
		afterIndex: index
]

{ #category : #'t - data source wrapper - adding' }
TToDataSourceWrapper >> addAllFirst: aCollection [

	aCollection reverseDo: [ :each | self addFirst: each ].
	^ aCollection
]

{ #category : #'t - data source wrapper - adding' }
TToDataSourceWrapper >> addAllLast: aCollection [

	self dataSource addAllLast:
		(aCollection collect: [ :o | self newWrapperForDataItem: o ])
]

{ #category : #'t - data source wrapper - adding' }
TToDataSourceWrapper >> addFirst: newObject [
	"Add newObject to the end of the receiver. Answer newObject."

	self dataSource addFirst: (self newWrapperForDataItem: newObject)
]

{ #category : #'t - data source wrapper - adding' }
TToDataSourceWrapper >> addLast: newObject [
	"Add newObject to the end of the receiver. Answer newObject."

	self dataSource addLast: (self newWrapperForDataItem: newObject)
]

{ #category : #'t - data source wrapper - enumerating' }
TToDataSourceWrapper >> allSatisfy: aBlock [

	self do: [ :each | (aBlock value: each) ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #'t - data source wrapper - enumerating' }
TToDataSourceWrapper >> anySatisfy: aBlock [

	self do: [ :each | (aBlock value: each) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'t - data source wrapper - converting' }
TToDataSourceWrapper >> asArray [

	^ self dataSource asArray collect: [ :w | w unwrappedDataItem ]
]

{ #category : #'t - data source wrapper - converting' }
TToDataSourceWrapper >> asOrderedCollection [

	^ self dataSource asOrderedCollection collect: [ :w | w unwrappedDataItem ]
]

{ #category : #'t - data source wrapper - accessing' }
TToDataSourceWrapper >> at: anInteger [ 

	^ 	self unwrappedDataItemAt: anInteger
]

{ #category : #'t - data source wrapper - accessing' }
TToDataSourceWrapper >> at: anInteger put: anObject [

	self dataSource
		at: anInteger
		put: (self newWrapperForDataItem: anObject)
]

{ #category : #'t - data source wrapper - enumerating' }
TToDataSourceWrapper >> collect: aBlock [

	| newCollection |
	newCollection := self species new.
	self do: [:each | newCollection add: (aBlock value: each)].
	^ newCollection
]

{ #category : #'t - data source wrapper - copying' }
TToDataSourceWrapper >> copyFrom: start to: stop [
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

{ #category : #'t - data source wrapper - copying' }
TToDataSourceWrapper >> copyReplaceFrom: start to: stop with: replacementCollection [
	"Concatenate two Strings or Collections."

	^ self asOrderedCollection
		  copyReplaceFrom: start
		  to: stop
		  with: replacementCollection
]

{ #category : #'t - data source wrapper - accessing dataSource' }
TToDataSourceWrapper >> dataSource [

	^ self listElement dataSource
]

{ #category : #'t - data source wrapper - enumerating' }
TToDataSourceWrapper >> detect: aBlock ifFound: foundBlock ifNone: exceptionBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument.
	Answer the first element for which aBlock evaluates to true. If none
	evaluate to true, then evaluate the argument, exceptionBlock."
	
	self
		do: [ :each |
			(aBlock value: each)
				ifTrue: [ ^ foundBlock cull: each ] ].
	^ exceptionBlock value
]

{ #category : #'t - data source wrapper - enumerating' }
TToDataSourceWrapper >> detect: aBlock ifNone: exceptionBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument.
	Answer the first element for which aBlock evaluates to true. If none
	evaluate to true, then evaluate the argument, exceptionBlock."
	
	^ self detect: aBlock ifFound: [ :element | element ] ifNone: exceptionBlock
]

{ #category : #'t - data source wrapper - enumerating' }
TToDataSourceWrapper >> detectIndex: aBlock [ 

	"Return index of first element that satisfies aBlock.
	If no matching element is found, raise an error."
	
	^ self detectIndex: aBlock ifNone: [ ]
]

{ #category : #'t - data source wrapper - enumerating' }
TToDataSourceWrapper >> detectIndex: aBlock ifNone: exceptionBlock [

	"Return index of first element that satisfies aBlock.
	If no matching element is found, evaluate exceptionBlock."

	"(#(1 5 10) detectIndex: [ :each | each > 3 ] ifNone: ['Not found']) >>> 2"
	"(#(1 5 10) detectIndex: [ :each | each > 15 ] ifNone: ['Not found']) >>> 'Not found'"
	
	self doWithIndex: [:each :index | (aBlock value: each) ifTrue: [^ index]].
	^ exceptionBlock value
]

{ #category : #'t - data source wrapper - enumerating' }
TToDataSourceWrapper >> do: aBlock [

	self dataSource do: [ :w | aBlock value: w unwrappedDataItem ]
]

{ #category : #'t - data source wrapper - enumerating' }
TToDataSourceWrapper >> doWithIndex: aBlock [

	self dataSource doWithIndex: [ :w :idx | aBlock value: w unwrappedDataItem value: idx ]
]

{ #category : #'t - data source wrapper - accessing' }
TToDataSourceWrapper >> fifth [

	^ self at: 5
]

{ #category : #'t - data source wrapper - accessing' }
TToDataSourceWrapper >> first [

	^ self at: 1
]

{ #category : #'t - data source wrapper - accessing' }
TToDataSourceWrapper >> first: n [
	"Answer the first n elements of the receiver.
	Raise an error if there are not enough elements."

	^ self copyFrom: 1 to: n
]

{ #category : #'t - data source wrapper - accessing' }
TToDataSourceWrapper >> fourth [

	^ self at: 4
]

{ #category : #'t - data source wrapper - testing' }
TToDataSourceWrapper >> ifEmpty: aBlock [
	"Evaluate the given block with the receiver as argument, answering its value
	unless the receiver is not empty, in which case answer the receiver."

	^ self isEmpty
		ifFalse: [ self ]
		ifTrue: [ aBlock value ]
]

{ #category : #'t - data source wrapper - testing' }
TToDataSourceWrapper >> ifEmpty: emptyBlock ifNotEmpty: notEmptyBlock [
	"Evaluate the given block with the receiver as argument, answering its value
	unless the receiver is empty, in which case answer the receiver."

	^ self isEmpty
		ifTrue: [ emptyBlock cull: self ]
		ifFalse: [ notEmptyBlock cull: self ]
]

{ #category : #'t - data source wrapper - testing' }
TToDataSourceWrapper >> ifNotEmpty: aBlock [
	"Evaluate the given block with the receiver as argument, answering its value
	unless the receiver is empty, in which case answer the receiver."

	^ self isEmpty
		ifTrue: [ self ]
		ifFalse: [ aBlock cull: self ]
]

{ #category : #'t - data source wrapper - testing' }
TToDataSourceWrapper >> ifNotEmpty: notEmptyBlock ifEmpty: emptyBlock [ 
	"Evaluate the given block with the receiver as argument, answering its value
	unless the receiver is empty, in which case answer the receiver."

	^ self isEmpty
		ifTrue: [ emptyBlock cull: self ]
		ifFalse: [ notEmptyBlock cull: self ]
]

{ #category : #'t - data source wrapper - testing' }
TToDataSourceWrapper >> includes: anObject [

	^ (self indexOf: anObject) ~= 0
]

{ #category : #'t - data source wrapper - accessing' }
TToDataSourceWrapper >> indexOf: anElement [
	"Answer the index of the first occurrence of anElement within the
	receiver. If the receiver does not contain anElement, answer 0."
	"(#(a b c d e) indexOf: #c) >>> 3"
	"(#(a b c d e) indexOf: #x) >>> 0"

	^ self indexOf: anElement ifAbsent: 0
]

{ #category : #'t - data source wrapper - accessing' }
TToDataSourceWrapper >> indexOf: anElement ifAbsent: exceptionBlock [
	"Answer the index of the first occurrence of anElement within the
	receiver. If the receiver does not contain anElement, answer the
	result of evaluating the argument, exceptionBlock."
	"(#(a b c d e) indexOf: #c ifAbsent: 7) >>> 3"
	"(#(a b c d e) indexOf: #x ifAbsent: 7) >>> 7"

	^ self indexOf: anElement startingAt: 1 ifAbsent: exceptionBlock
]

{ #category : #'t - data source wrapper - accessing' }
TToDataSourceWrapper >> indexOf: anElement startingAt: start ifAbsent: exceptionBlock [
	"Answer the index of the first occurrence of anElement after start
	within the receiver. If the receiver does not contain anElement,
	answer the 	result of evaluating the argument, exceptionBlock."

	"(#(a b c d e) indexOf: #c startingAt: 2 ifAbsent: 7) >>> 3"

	"(#(a b c d e) indexOf: #c startingAt: 4 ifAbsent: 7) >>> 7"

	| ds |
	ds := self dataSource.
	start to: ds size do: [ :idx |
	(self unwrappedDataItemAt: idx) = anElement ifTrue: [ ^ idx ] ].
	^ exceptionBlock value
]

{ #category : #'t - data source wrapper - initialization' }
TToDataSourceWrapper >> initializeWith: aCollection [

	self dataSource initializeWith:
		(aCollection collect: [ :o | self newWrapperForDataItem: o ])
]

{ #category : #'t - data source wrapper - testing' }
TToDataSourceWrapper >> isEmpty [

	^ self size isZero
]

{ #category : #'t - data source wrapper - testing' }
TToDataSourceWrapper >> isNotEmpty [

	^ self isEmpty not
]

{ #category : #'t - data source wrapper - accessing' }
TToDataSourceWrapper >> itemCount [ 

	^ self size
]

{ #category : #'t - data source wrapper - accessing' }
TToDataSourceWrapper >> last [

	^ self at: self size
]

{ #category : #'t - data source wrapper - accessing' }
TToDataSourceWrapper >> last: n [
	"Answer the last n elements of the receiver.  
	Raise an error if there are not enough elements."

	| size |
	size := self size.
	^ self copyFrom: size - n + 1 to: size
]

{ #category : #'t - data source wrapper - accessing' }
TToDataSourceWrapper >> lastIndexOf: anElement [ 
	"Answer the index of the first occurrence of anElement within the
	receiver. If the receiver does not contain anElement, answer the
	result of evaluating the argument, exceptionBlock."

	^ self lastIndexOf: anElement startingAt: self size ifAbsent: [0]
]

{ #category : #'t - data source wrapper - accessing' }
TToDataSourceWrapper >> lastIndexOf: anElement ifAbsent: exceptionBlock [
	"Answer the index of the first occurrence of anElement within the
	receiver. If the receiver does not contain anElement, answer the
	result of evaluating the argument, exceptionBlock."

	^ self lastIndexOf: anElement startingAt: self size ifAbsent: exceptionBlock
]

{ #category : #'t - data source wrapper - accessing' }
TToDataSourceWrapper >> lastIndexOf: anElement startingAt: lastIndex ifAbsent: exceptionBlock [
	"Answer the index of the last occurrence of anElement within the
	receiver. If the receiver does not contain anElement, answer the
	result of evaluating the argument, exceptionBlock."

	| ds |
	ds := self dataSource.
	lastIndex to: 1 by: -1 do:
		[:index |
		(ds at: index) unwrappedDataItem = anElement ifTrue: [^ index]].
	^ exceptionBlock value
]

{ #category : #'t - data source wrapper - accessing' }
TToDataSourceWrapper >> listElement [ 

	^ self subclassResponsibility 
]

{ #category : #'t - data source wrapper - accessing' }
TToDataSourceWrapper >> listElement: aListElement [

	^ self subclassResponsibility 
]

{ #category : #'t - data source wrapper - accessing' }
TToDataSourceWrapper >> newMirror [

	^ ToCollectionMirror new
		  mirroredTo: self;
		  yourself
]

{ #category : #'t - data source wrapper - accessing dataSource' }
TToDataSourceWrapper >> newWrapperForDataItem: anObject [

	^ anObject
]

{ #category : #'t - data source wrapper - enumerating' }
TToDataSourceWrapper >> noneSatisfy: aBlock [

	self do: [:item | (aBlock value: item) ifTrue: [^ false]].
	^ true
]

{ #category : #'t - data source wrapper - enumerating' }
TToDataSourceWrapper >> reject: aBlock [

	^ self select: [ :element | (aBlock value: element) == false ]
]

{ #category : #'t - data source wrapper - removing' }
TToDataSourceWrapper >> remove: anObject [

	| idx |
	idx := self indexOf: anObject.
	^ self removeAt: idx

	
]

{ #category : #'t - data source wrapper - removing' }
TToDataSourceWrapper >> removeAll [

	self dataSource removeAll
]

{ #category : #'t - data source wrapper - removing' }
TToDataSourceWrapper >> removeAll: aCollection [

	aCollection do: [ :e | self remove: e ]
]

{ #category : #'t - data source wrapper - removing' }
TToDataSourceWrapper >> removeAllSuchThat: aBlock [

	self asArray do: [:each | (aBlock value: each) ifTrue: [self remove: each]]
]

{ #category : #'t - data source wrapper - removing' }
TToDataSourceWrapper >> removeAt: removedIndex [

	^ (self dataSource removeAt: removedIndex) unwrappedDataItem
]

{ #category : #'t - data source wrapper - removing' }
TToDataSourceWrapper >> removeFirst [

	^ self removeAt: 1
]

{ #category : #'t - data source wrapper - removing' }
TToDataSourceWrapper >> removeFirst: n [

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

{ #category : #'t - data source wrapper - removing' }
TToDataSourceWrapper >> removeFrom: start to: stop [

	self dataSource removeFrom: start to: stop
]

{ #category : #'t - data source wrapper - removing' }
TToDataSourceWrapper >> removeLast [

	^ self removeAt: self size
]

{ #category : #'t - data source wrapper - removing' }
TToDataSourceWrapper >> removeLast: n [

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

{ #category : #'t - data source wrapper - accessing' }
TToDataSourceWrapper >> replaceFrom: start to: stop with: replacement [ 

	self replaceFrom: start to: stop with: replacement startingAt: 1.
]

{ #category : #'t - data source wrapper - accessing' }
TToDataSourceWrapper >> replaceFrom: start to: stop with: replacement startingAt: repStart [
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

{ #category : #'t - data source wrapper - initialization' }
TToDataSourceWrapper >> reset [

	self dataSource reset
]

{ #category : #'t - data source wrapper - enumerating' }
TToDataSourceWrapper >> reverseDo: aBlock [

	self dataSource reverseDo: [ :w | aBlock value: w unwrappedDataItem ]
]

{ #category : #'t - data source wrapper - copying' }
TToDataSourceWrapper >> reversed [

	"Answer a copy of the receiver with element order reversed.  "

	^ self asOrderedCollection reversed
]

{ #category : #'t - data source wrapper - accessing' }
TToDataSourceWrapper >> second [

	^ self at: 2
]

{ #category : #'t - data source wrapper - enumerating' }
TToDataSourceWrapper >> select: aBlock [

	| newCollection |
	newCollection := self species new.
	self do: [ :each |
		(aBlock value: each) ifTrue: [ newCollection add: each ] ].
	^ newCollection
]

{ #category : #'t - data source wrapper - accessing' }
TToDataSourceWrapper >> size [

	^ self dataSource size
]

{ #category : #'t - data source wrapper - private' }
TToDataSourceWrapper >> species [ 

	^ OrderedCollection 
]

{ #category : #'t - data source wrapper - accessing' }
TToDataSourceWrapper >> third [

	^ self at: 3
]

{ #category : #'t - data source wrapper - accessing dataSource' }
TToDataSourceWrapper >> unwrappedDataItemAt: anInteger [ 

	^ (self dataSource at: anInteger) unwrappedDataItem
]

{ #category : #'t - data source wrapper - initialization' }
TToDataSourceWrapper >> updateAllWith: aCollection [

	self removeAll.
	self addAll: aCollection
]

{ #category : #'t - data source wrapper - enumerating' }
TToDataSourceWrapper >> with: otherCollection do: twoArgBlock [
	"aCollection must support #at:at: and be at least as large as the receiver."

	otherCollection size = self size ifFalse: [self errorSizeMismatch].
	1 to: self size do:
		[:index |
		twoArgBlock value: (self at: index)
				value: (otherCollection at: index)]
]

{ #category : #'t - data source wrapper - enumerating' }
TToDataSourceWrapper >> withIndexCollect: elementAndIndexBlock [
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

{ #category : #'t - data source wrapper - enumerating' }
TToDataSourceWrapper >> withIndexDo: elementAndIndexBlock [
	"Just like do: except that the iteration index supplies the second argument to the block"
	"Support collection enumeration with a counter, even though not ordered"

	"|s|s:=0. #(4 2 1) withIndexDo: [:e :i| s:=s + (e * (10 ** (i-1)))]. s >>> 124"

	"|a|a:= Array new: 3. #(10 20 30) withIndexDo: [:e :i| a at: 4-i put: e+1]. a >>> #(31 21 11)"

	1 to: self size do: [ :index | elementAndIndexBlock value: (self at: index) value: index ]
]

{ #category : #'t - data source wrapper - enumerating' }
TToDataSourceWrapper >> withIndexSelect: elementAndIndexBlock [
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
