Trait {
	#name : #TToProtectedCollection,
	#category : #'Toplo-Core-Collection'
}

{ #category : #'t - protected collection - copying' }
TToProtectedCollection >> , otherCollection [ 
	"Concatenate two Strings or Collections."
	
	self dataCritical: [ ^ self collection, otherCollection ]
]

{ #category : #'t - protected collection - adding' }
TToProtectedCollection >> add: newObject [

	self dataCritical: [ self collection add: newObject ]
]

{ #category : #'t - protected collection - adding' }
TToProtectedCollection >> add: newObject after: oldObject [
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just succeeding oldObject. Answer newObject.
	Raises an error if oldObject is not found"

	self dataCritical: [
		self collection add: newObject after: oldObject ]
]

{ #category : #'t - protected collection - adding' }
TToProtectedCollection >> add: newObject afterIndex: index [
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just after index. Answer newObject."

	self dataCritical: [ self collection add: newObject afterIndex: index ]
]

{ #category : #'t - protected collection - private' }
TToProtectedCollection >> add: newObject before: oldObject [
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just preceding oldObject. Answer newObject."

	self dataCritical: [
		self collection add: newObject before: oldObject ]
]

{ #category : #'t - protected collection - private' }
TToProtectedCollection >> add: newObject beforeIndex: index [
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just before index. Answer newObject."

	self dataCritical: [
		self collection add: newObject beforeIndex: index ]
]

{ #category : #'t - protected collection - adding' }
TToProtectedCollection >> addAll: aCollection [ 
	"Add each element of aCollection at my end. Answer aCollection."

	self dataCritical: [ ^ self collection addAll: aCollection ]
]

{ #category : #'t - protected collection - adding' }
TToProtectedCollection >> addAllFirst: aCollection [

	self dataCritical: [ self collection addAllFirst: aCollection ]
]

{ #category : #'t - protected collection - adding' }
TToProtectedCollection >> addAllLast: aCollection [

	self dataCritical: [
		self collection addAllLast: aCollection  ]
]

{ #category : #'t - protected collection - adding' }
TToProtectedCollection >> addFirst: newObject [

	"Add newObject to the end of the receiver. Answer newObject."
	self dataCritical: [ self collection addFirst: newObject ]
]

{ #category : #'t - protected collection - adding' }
TToProtectedCollection >> addLast: newObject [

	"Add newObject to the end of the receiver. Answer newObject."
	self dataCritical: [ self collection addLast: newObject ]
]

{ #category : #'t - protected collection - enumerating' }
TToProtectedCollection >> allSatisfy: aBlock [

	self dataCritical: [ ^ self collection allSatisfy: aBlock ]
]

{ #category : #'t - protected collection - converting' }
TToProtectedCollection >> asArray [

	self dataCritical: [ ^ self collection asArray ]
]

{ #category : #'t - protected collection - converting' }
TToProtectedCollection >> asOrderedCollection [

	self dataCritical: [ ^ self collection asOrderedDictionary ]
]

{ #category : #'t - protected collection - accessing' }
TToProtectedCollection >> at: anInteger [ 

	self dataCritical: [ ^ self collection at: anInteger ]
]

{ #category : #'t - protected collection - accessing' }
TToProtectedCollection >> at: anInteger put: anObject [

	self dataCritical: [ self collection at: anInteger put: anObject ]
]

{ #category : #'t - protected collection - enumerating' }
TToProtectedCollection >> collect: aBlock [

	self dataCritical: [ ^ self collection collect: aBlock ]
]

{ #category : #'t - protected collection - accessing' }
TToProtectedCollection >> collection [

	^ self explicitRequirement

]

{ #category : #'t - protected collection - copying' }
TToProtectedCollection >> copyFrom: startIndex to: endIndex [
	"Answer a copy of the receiver that contains elements from position
	startIndex to endIndex."

	| l |
	self dataCritical: [
		l := self collection copyFrom: startIndex to: endIndex.
		^ self species newFrom: l ]
]

{ #category : #'t - protected collection - copying' }
TToProtectedCollection >> copyReplaceFrom: start to: stop with: replacementCollection [
	"Concatenate two Strings or Collections."

	| l n |
	self dataCritical: [
		l := self collection
			     copyReplaceFrom: start
			     to: stop
			     with: replacementCollection.
		n := self species newFrom: l.
		^ n ]
]

{ #category : #'t - protected collection - private' }
TToProtectedCollection >> dataCritical: aBlock [

	self explicitRequirement 
]

{ #category : #'t - protected collection - enumerating' }
TToProtectedCollection >> detect: aBlock ifNone: exceptionBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument.
	Answer the first element for which aBlock evaluates to true. If none
	evaluate to true, then evaluate the argument, exceptionBlock."
	
	self dataCritical: [ ^ self collection detect: aBlock ifNone: exceptionBlock ]
]

{ #category : #'t - protected collection - enumerating' }
TToProtectedCollection >> detectIndex: aBlock [ 

	"Return index of first element that satisfies aBlock.
	If no matching element is found, raise an error."
	
	self dataCritical: [ ^ self collection detectIndex: aBlock ]
]

{ #category : #'t - protected collection - enumerating' }
TToProtectedCollection >> detectIndex: aBlock ifNone: exceptionBlock [

	"Return index of first element that satisfies aBlock.
	If no matching element is found, evaluate exceptionBlock."

	"(#(1 5 10) detectIndex: [ :each | each > 3 ] ifNone: ['Not found']) >>> 2"
	"(#(1 5 10) detectIndex: [ :each | each > 15 ] ifNone: ['Not found']) >>> 'Not found'"
	
	self dataCritical: [ ^ self collection detectIndex: aBlock ifNone: exceptionBlock ]
]

{ #category : #'t - protected collection - enumerating' }
TToProtectedCollection >> do: aBlock [

	self dataCritical: [ self collection do: aBlock ]
]

{ #category : #'t - protected collection - private' }
TToProtectedCollection >> ensureNewMutex [

	self explicitRequirement 
]

{ #category : #'t - protected collection - accessing' }
TToProtectedCollection >> fifth [

	self dataCritical: [ ^ self collection fifth ]
]

{ #category : #'t - protected collection - accessing' }
TToProtectedCollection >> first [

	self dataCritical: [ ^ self collection first ]
]

{ #category : #'t - protected collection - copying' }
TToProtectedCollection >> first: n [
	"Answer the first n elements of the receiver.
	Raise an error if there are not enough elements."

	self dataCritical: [ ^ self collection first: n ]
]

{ #category : #'t - protected collection - accessing' }
TToProtectedCollection >> fourth [

	self dataCritical: [ ^ self collection fourth ]
]

{ #category : #'t - protected collection - testing' }
TToProtectedCollection >> ifEmpty: aBlock [
	"Evaluate the given block with the receiver as argument, answering its value
	unless the receiver is not empty, in which case answer the receiver."

	self dataCritical: [ self collection ifEmpty: aBlock ]
]

{ #category : #'t - protected collection - testing' }
TToProtectedCollection >> ifEmpty: emptyBlock ifNotEmpty: notEmptyBlock [
	"Evaluate the given block with the receiver as argument, answering its value
	unless the receiver is empty, in which case answer the receiver."

	self dataCritical: [
		self collection ifEmpty: emptyBlock ifNotEmpty: notEmptyBlock ]
]

{ #category : #'t - protected collection - testing' }
TToProtectedCollection >> ifNotEmpty: aBlock [
	"Evaluate the given block with the receiver as argument, answering its value
	unless the receiver is empty, in which case answer the receiver."

	self dataCritical: [ self collection ifNotEmpty: aBlock ]
]

{ #category : #'t - protected collection - testing' }
TToProtectedCollection >> ifNotEmpty: notEmptyBlock ifEmpty: emptyBlock [
	"Evaluate the given block with the receiver as argument, answering its value
	unless the receiver is empty, in which case answer the receiver."

	self dataCritical: [
		self collection ifNotEmpty: notEmptyBlock ifEmpty: emptyBlock ]
]

{ #category : #'t - protected collection - testing' }
TToProtectedCollection >> includes: anObject [

	self dataCritical: [ ^ self collection includes: anObject ]
]

{ #category : #'t - protected collection - accessing' }
TToProtectedCollection >> indexOf: anElement [
	"Answer the index of the first occurrence of anElement within the
	receiver. If the receiver does not contain anElement, answer 0."
	"(#(a b c d e) indexOf: #c) >>> 3"
	"(#(a b c d e) indexOf: #x) >>> 0"

	self dataCritical: [ ^ self collection indexOf: anElement ifAbsent: 0 ]
]

{ #category : #'t - protected collection - accessing' }
TToProtectedCollection >> indexOf: anElement ifAbsent: exceptionBlock [
	"Answer the index of the first occurrence of anElement within the
	receiver. If the receiver does not contain anElement, answer the
	result of evaluating the argument, exceptionBlock."

	"(#(a b c d e) indexOf: #c ifAbsent: 7) >>> 3"

	"(#(a b c d e) indexOf: #x ifAbsent: 7) >>> 7"

	self dataCritical: [
		^ self collection indexOf: anElement ifAbsent: exceptionBlock ]
]

{ #category : #'t - protected collection - accessing' }
TToProtectedCollection >> indexOf: anElement startingAt: start ifAbsent: exceptionBlock [
	"Answer the index of the first occurrence of anElement after start
	within the receiver. If the receiver does not contain anElement,
	answer the 	result of evaluating the argument, exceptionBlock."

	"(#(a b c d e) indexOf: #c startingAt: 2 ifAbsent: 7) >>> 3"

	"(#(a b c d e) indexOf: #c startingAt: 4 ifAbsent: 7) >>> 7"

	self dataCritical: [
		^ self collection
			  indexOf: anElement
			  startingAt: start
			  ifAbsent: exceptionBlock ]
]

{ #category : #'t - protected collection - testing' }
TToProtectedCollection >> isEmpty [

	self dataCritical: [ ^ self collection isEmpty ]
]

{ #category : #'t - protected collection - testing' }
TToProtectedCollection >> isNotEmpty [

	self dataCritical: [ ^ self collection isNotEmpty ]
]

{ #category : #'t - protected collection - accessing' }
TToProtectedCollection >> last [

	self dataCritical: [ ^ self collection last ]
]

{ #category : #'t - protected collection - accessing' }
TToProtectedCollection >> last: n [
	"Answer the last n elements of the receiver.  
	Raise an error if there are not enough elements."

	self dataCritical: [
		^ self collection last: n ]
]

{ #category : #'t - protected collection - accessing' }
TToProtectedCollection >> newMirror [

	^ ToCollectionMirror new
		  mirroredTo: self;
		  yourself
]

{ #category : #'t - protected collection - enumerating' }
TToProtectedCollection >> noneSatisfy: aBlock [

	self dataCritical: [ ^ self collection noneSatisfy: aBlock ]
]

{ #category : #'t - protected collection - copying' }
TToProtectedCollection >> postCopy [

	self collection: self collection copy.
	self ensureNewMutex
]

{ #category : #'t - protected collection - enumerating' }
TToProtectedCollection >> reject: aBlock [

	self dataCritical: [ ^ self collection reject: aBlock ]
]

{ #category : #'t - protected collection - removing' }
TToProtectedCollection >> remove: anObject [

	self dataCritical: [
		self collection remove: anObject ]
]

{ #category : #'t - protected collection - removing' }
TToProtectedCollection >> removeAll [

	self dataCritical: [ self collection removeAll ]
]

{ #category : #'t - protected collection - removing' }
TToProtectedCollection >> removeAt: removedIndex [

	self dataCritical: [ self collection removeAt: removedIndex ]
]

{ #category : #'t - protected collection - removing' }
TToProtectedCollection >> removeFirst [

	self dataCritical: [ self collection removeFirst ]
]

{ #category : #'t - protected collection - removing' }
TToProtectedCollection >> removeFirst: n [ 

	self dataCritical: [ self collection removeFirst: n ]
]

{ #category : #'t - protected collection - removing' }
TToProtectedCollection >> removeFrom: start to: stop [

	self dataCritical: [ self collection removeFrom:  start to: stop ]
]

{ #category : #'t - protected collection - removing' }
TToProtectedCollection >> removeLast [

	self dataCritical: [ self collection removeLast ]
]

{ #category : #'t - protected collection - removing' }
TToProtectedCollection >> removeLast: n [

	self dataCritical: [ self collection removeLast: n ]
]

{ #category : #'t - protected collection - accessing' }
TToProtectedCollection >> replaceFrom: start to: stop with: replacement [

	self dataCritical: [
		self collection replaceFrom: start to: stop with: replacement ]
]

{ #category : #'t - protected collection - accessing' }
TToProtectedCollection >> replaceFrom: start to: stop with: replacement startingAt: repStart [

	self dataCritical: [
		self collection
			replaceFrom: start
			to: stop
			with: replacement
			startingAt: repStart ]
]

{ #category : #'t - protected collection - enumerating' }
TToProtectedCollection >> reverseDo: aBlock [

	self dataCritical: [ self collection reverseDo: aBlock ]
]

{ #category : #'t - protected collection - copying' }
TToProtectedCollection >> reversed [

	"Answer a copy of the receiver with element order reversed.  "

	self dataCritical: [ ^ self species newFrom: self collection reversed ]
]

{ #category : #'t - protected collection - accessing' }
TToProtectedCollection >> second [

	self dataCritical: [ ^ self collection second ]
]

{ #category : #'t - protected collection - enumerating' }
TToProtectedCollection >> select: aBlock [

	self dataCritical: [ ^ self collection select: aBlock ]
]

{ #category : #'t - protected collection - accessing' }
TToProtectedCollection >> size [

	self dataCritical: [ ^ self collection size ]
]

{ #category : #'t - protected collection - accessing' }
TToProtectedCollection >> third [

	self dataCritical: [ ^ self collection third ]
]

{ #category : #'t - protected collection - enumerating' }
TToProtectedCollection >> with: aCollection do: aBlock [
	"aCollection must support #at:at: and be at least as large as the receiver."

	self dataCritical: [ self collection with: aCollection do: aBlock ]
]

{ #category : #'t - protected collection - enumerating' }
TToProtectedCollection >> withIndexCollect: elementAndIndexBlock [
	"Just like with:collect: except that the iteration index supplies the second argument to the block."

	"(#(10 20 30) withIndexCollect: [:each :index | each + (index * 2)]) >>> #(12 24 36)"

	self dataCritical: [ ^ self collection withIndexCollect: elementAndIndexBlock ]
]

{ #category : #'t - protected collection - enumerating' }
TToProtectedCollection >> withIndexDo: elementAndIndexBlock [
	"Just like do: except that the iteration index supplies the second argument to the block"
	"Support collection enumeration with a counter, even though not ordered"

	"|s|s:=0. #(4 2 1) withIndexDo: [:e :i| s:=s + (e * (10 ** (i-1)))]. s >>> 124"

	"|a|a:= Array new: 3. #(10 20 30) withIndexDo: [:e :i| a at: 4-i put: e+1]. a >>> #(31 21 11)"

	self dataCritical: [ self collection withIndexDo: elementAndIndexBlock ]
]

{ #category : #'t - protected collection - enumerating' }
TToProtectedCollection >> withIndexSelect: elementAndIndexBlock [
	"select elements from the receiver that the block evaluates true with the element and its index."

	"(#('We' 'love' 'pharo!') withIndexSelect: [:value :index | value size - 1 <= index]) >>> #('We')"
	
	self dataCritical: [ ^ self collection withIndexSelect: elementAndIndexBlock ]
]
