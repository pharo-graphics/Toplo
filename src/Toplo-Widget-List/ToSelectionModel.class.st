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

{ #category : #private }
ToSelectionModel >> checkEmptiness [

	self underlyingModel isEmpty ifTrue: [
		self ensureEmptySelectionModel ].
]

{ #category : #'api - testing' }
ToSelectionModel >> containsIndex: anIndex [

	^ self underlyingModel containsIndex: anIndex
]

{ #category : #updating }
ToSelectionModel >> deselectAll [

	self ensureEmptySelectionModel 
]

{ #category : #updating }
ToSelectionModel >> deselectAllIndexes: anArray [

	| wasWhole |
	wasWhole := self isWholeSelectionModel.
	self ensureCompositeSelectionModel.
	wasWhole ifTrue: [ self underlyingModel select: 0 to: self itemCount ].
	anArray do: [ :idx |
		self underlyingModel deselectIndex: idx ].
	self checkEmptiness
]

{ #category : #updating }
ToSelectionModel >> deselectIndex: anIndex [

	| wasWhole |
	wasWhole := self isWholeSelectionModel.
	self ensureCompositeSelectionModel.
	wasWhole ifTrue: [
		self underlyingModel select: 0 to: self itemCount ].
	self underlyingModel deselect: anIndex - 1 to: anIndex.
	self checkEmptiness
]

{ #category : #updating }
ToSelectionModel >> deselectIndex: aFirstIndex to: aSecondIndex [

	self ensureCompositeSelectionModel.
	self underlyingModel 
		deselect: aFirstIndex - 1
		to: aSecondIndex
]

{ #category : #private }
ToSelectionModel >> ensureCompositeSelectionModel [

	self underlyingModel isCompositeSelectionModel ifTrue: [ ^ self ].
	self underlyingModel: ToUnderlyingSelectionModel composite
]

{ #category : #private }
ToSelectionModel >> ensureEmptySelectionModel [

	self isEmptySelectionModel ifTrue: [ ^ self ].
	self underlyingModel: ToUnderlyingSelectionModel empty
]

{ #category : #private }
ToSelectionModel >> ensureWholeSelectionModel [

	self isWholeSelectionModel ifTrue: [ ^ self ].
	self underlyingModel: ToUnderlyingSelectionModel whole
]

{ #category : #accessing }
ToSelectionModel >> firstIndex [

	^ self underlyingModel firstIndexAmong: self itemCount
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
	underlyingModel := ToUnderlyingSelectionModel empty
]

{ #category : #'private testing' }
ToSelectionModel >> isCompositeSelectionModel [

	^ self underlyingModel isCompositeSelectionModel
]

{ #category : #testing }
ToSelectionModel >> isEmpty [

	^ self underlyingModel isEmpty
]

{ #category : #'private testing' }
ToSelectionModel >> isEmptySelectionModel [

	^ self underlyingModel isEmptySelectionModel
]

{ #category : #testing }
ToSelectionModel >> isNotEmpty [

	^ self isEmpty not
]

{ #category : #'private testing' }
ToSelectionModel >> isWholeSelectionModel [

	^ self underlyingModel isWholeSelectionModel
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

	^ self underlyingModel lastIndexAmong: self itemCount
]

{ #category : #'instance creation' }
ToSelectionModel >> newOperator [

	^ ToListElementSelecter new 
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

	self ensureWholeSelectionModel 
]

{ #category : #updating }
ToSelectionModel >> selectAllIndexes: anArray [

	anArray ifEmpty: [ ^ self ].
	self ensureCompositeSelectionModel.
	anArray do: [ :idx |
			self underlyingModel selectIndex: idx ]
]

{ #category : #updating }
ToSelectionModel >> selectIndex: anIndex [

	self ensureCompositeSelectionModel.
	self underlyingModel 
		select: anIndex - 1
		to: anIndex 
]

{ #category : #updating }
ToSelectionModel >> selectIndex: aFirstIndex to: aSecondIndex [

	self ensureCompositeSelectionModel.
	self underlyingModel 
		select: aFirstIndex - 1
		to: aSecondIndex
]

{ #category : #accessing }
ToSelectionModel >> selectedIndexes [

	^ self underlyingModel selectedIndexesAmong: self itemCount
]

{ #category : #enumerating }
ToSelectionModel >> selectedIndexesCollect: aBlock [

	^ self underlyingModel selectedIndexesCollect: aBlock among: self itemCount
]

{ #category : #accessing }
ToSelectionModel >> selectedIndexesCount [

	^ self underlyingModel selectedIndexesCountAmong: self itemCount
]

{ #category : #enumerating }
ToSelectionModel >> selectedIndexesDo: aBlock [

	^ self underlyingModel selectedIndexesDo: aBlock among: self itemCount
]

{ #category : #updating }
ToSelectionModel >> shift: aGap from: aStartIndex [

	self isEmpty ifTrue: [ ^ self ].
	self isWholeSelectionModel ifTrue: [
		self ensureCompositeSelectionModel.
		self selectIndex: 1 to: self itemCount ].
	self underlyingModel
		shift: aGap
		from: aStartIndex
		among: self itemCount.
	self checkEmptiness 
]

{ #category : #accessing }
ToSelectionModel >> underlyingModel [

	^ underlyingModel
]

{ #category : #accessing }
ToSelectionModel >> underlyingModel: anUnderlyingModel [

	underlyingModel := anUnderlyingModel
]
