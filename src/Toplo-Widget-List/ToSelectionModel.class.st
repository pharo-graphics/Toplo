Class {
	#name : #ToSelectionModel,
	#superclass : #Object,
	#instVars : [
		'underlyingModel'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #comparing }
ToSelectionModel >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].

	^ self underlyingModel = anObject underlyingModel
]

{ #category : #'command handling' }
ToSelectionModel >> addIndexesSelectionCommand: aCommand [

	aCommand indexes ifEmpty: [ ^ self ].
	self ensureCompositeSelectionModel.
	aCommand indexes do: [ :idx |
			self underlyingModel selectIndex: idx ]
]

{ #category : #'command handling' }
ToSelectionModel >> addIntervalSelectionCommand: aCommand [

	aCommand interval ifEmpty: [ ^ self ].
	self ensureCompositeSelectionModel.
	self underlyingModel 
		select: aCommand interval first - 1
		to: aCommand interval last
]

{ #category : #'command handling' }
ToSelectionModel >> addWholeSelectionCommand: aCommand [

	self ensureWholeSelectionModel 
]

{ #category : #'command handling' }
ToSelectionModel >> checkEmptiness [

	self underlyingModel isEmpty ifTrue: [
		self ensureEmptySelectionModel ].
]

{ #category : #'api - testing' }
ToSelectionModel >> containsIndex: anIndex [

	^ self underlyingModel containsIndex: anIndex
]

{ #category : #private }
ToSelectionModel >> ensureCompositeSelectionModel [

	self isCompositeSelectionModel ifTrue: [ ^ self ].
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

{ #category : #accessing }
ToSelectionModel >> indices [

	^ self underlyingModel indices
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

{ #category : #'instance creation' }
ToSelectionModel >> newSelecter [

	^ ToSelectionModelOperator new 
]

{ #category : #'command handling' }
ToSelectionModel >> removeIndexesSelectionCommand: aCommand [

	aCommand indexes do: [ :idx |
		self underlyingModel deselectIndex: idx ].
	self checkEmptiness
]

{ #category : #'command handling' }
ToSelectionModel >> removeIntervalSelectionCommand: aCommand [
	
	self underlyingModel
		deselect: aCommand interval first - 1
		to: aCommand interval last.
	self checkEmptiness
]

{ #category : #'command handling' }
ToSelectionModel >> removeWholeSelectionCommand: aCommand [

	self underlyingModel: ToUnderlyingSelectionModel empty
]

{ #category : #accessing }
ToSelectionModel >> underlyingModel [

	^ underlyingModel
]

{ #category : #accessing }
ToSelectionModel >> underlyingModel: anUnderlyingModel [

	underlyingModel := anUnderlyingModel
]
