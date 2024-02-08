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

{ #category : #'command operations' }
ToSelectionModel >> addIndexesSelectionCommand: aCommand [

	aCommand indexes ifEmpty: [ ^ self ].
	self ensureCompositeSelectionModel.
	aCommand indexes do: [ :idx |
			self underlyingModel selectIndex: idx ]
]

{ #category : #'command operations' }
ToSelectionModel >> addIntervalSelectionCommand: aCommand [

	| interval |
	interval := aCommand computedInterval.
	interval ifEmpty: [ ^ self ].
	self ensureCompositeSelectionModel.
	self underlyingModel 
		select: interval first - 1
		to: interval last
]

{ #category : #'command operations' }
ToSelectionModel >> addSelectionHolderCommand: aCommand [

]

{ #category : #'command operations' }
ToSelectionModel >> addWholeSelectionCommand: aCommand [

	self ensureWholeSelectionModel 
]

{ #category : #updating }
ToSelectionModel >> adoptSelectedIndexesFrom: aSelectionModel [

	self underlyingModel: aSelectionModel underlyingModel copy.
]

{ #category : #'command operations' }
ToSelectionModel >> applyCommand: aCommand [

	aCommand applyOn: self
]

{ #category : #'command operations' }
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
ToSelectionModel >> deselectAllIndexes: anArray among: anInteger [

	| wasWhole |
	wasWhole := self isWholeSelectionModel.
	self ensureCompositeSelectionModel.
	wasWhole ifTrue: [ self underlyingModel select: 0 to: anInteger ].
	anArray do: [ :idx |
		self underlyingModel deselectIndex: idx ].
	self checkEmptiness
]

{ #category : #updating }
ToSelectionModel >> deselectIndex: anIndex among: anInteger [

	| wasWhole |
	wasWhole := self isWholeSelectionModel.
	self ensureCompositeSelectionModel.
	wasWhole ifTrue: [
		self underlyingModel select: 0 to: anInteger ].
	self underlyingModel deselect: anIndex - 1 to: anIndex.
	self checkEmptiness
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

{ #category : #testing }
ToSelectionModel >> isCompositeSelectionModel [

	^ self underlyingModel isCompositeSelectionModel
]

{ #category : #testing }
ToSelectionModel >> isEmpty [

	^ self underlyingModel isEmpty
]

{ #category : #testing }
ToSelectionModel >> isEmptySelectionModel [

	^ self underlyingModel isEmptySelectionModel
]

{ #category : #testing }
ToSelectionModel >> isNotEmpty [

	^ self isEmpty not
]

{ #category : #testing }
ToSelectionModel >> isWholeSelectionModel [

	^ self underlyingModel isWholeSelectionModel
]

{ #category : #accessing }
ToSelectionModel >> itemCount [

	^ itemCountGetter value
]

{ #category : #accessing }
ToSelectionModel >> itemCountGetter [

	^ itemCountGetter 
]

{ #category : #accessing }
ToSelectionModel >> itemCountGetter: aValuable [

	" aValuable takes no args and return the number of items (typically, a datasource items count) "
	itemCountGetter := aValuable
]

{ #category : #'instance creation' }
ToSelectionModel >> newOperator [

	^ ToSelectionModelOperator new 
]

{ #category : #'instance creation' }
ToSelectionModel >> newUpdater [

	^ ToSelectionModelUpdater new selectionModel: self
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

{ #category : #'command operations' }
ToSelectionModel >> removeIndexesSelectionCommand: aCommand [

	| wasWhole |
	wasWhole := self isWholeSelectionModel.
	self ensureCompositeSelectionModel.
	wasWhole ifTrue: [ self underlyingModel select: 0 to: self itemCount ].
	aCommand indexes do: [ :idx |
		self underlyingModel deselectIndex: idx ].
	self checkEmptiness
]

{ #category : #'command operations' }
ToSelectionModel >> removeIntervalSelectionCommand: aCommand [

	| interval wasWhole |
	wasWhole := self isWholeSelectionModel.
	self ensureCompositeSelectionModel.
	wasWhole ifTrue: [
		self underlyingModel select: 0 to: self itemCount ].
	interval := aCommand computedInterval.
	self underlyingModel deselect: interval first - 1 to: interval last.
	self checkEmptiness
]

{ #category : #'command operations' }
ToSelectionModel >> removeWholeSelectionCommand: aCommand [

	self underlyingModel: ToUnderlyingSelectionModel empty
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

{ #category : #accessing }
ToSelectionModel >> underlyingModel [

	^ underlyingModel
]

{ #category : #accessing }
ToSelectionModel >> underlyingModel: anUnderlyingModel [

	underlyingModel := anUnderlyingModel
]
