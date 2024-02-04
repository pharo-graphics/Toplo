Class {
	#name : #ToSelectionModel,
	#superclass : #Object,
	#instVars : [
		'underlyingModel',
		'dataSource'
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
	self ensureCompositeModel.
	aCommand indexes do: [ :idx |
			self underlyingModel selectIndex: idx ]
]

{ #category : #'command handling' }
ToSelectionModel >> addIntervalSelectionCommand: aCommand [

	self ensureCompositeModel.
	self underlyingModel 
		select: aCommand interval first - 1
		to: aCommand interval last
]

{ #category : #'command handling' }
ToSelectionModel >> addWholeSelectionCommand: aCommand [

	self underlyingModel: ToUnderlyingSelectionModel whole
]

{ #category : #'command handling' }
ToSelectionModel >> checkEmptiness [

	self underlyingModel isEmpty ifTrue: [
		self underlyingModel: ToUnderlyingSelectionModel empty ].
]

{ #category : #accessing }
ToSelectionModel >> dataSource [

	^ dataSource 
]

{ #category : #accessing }
ToSelectionModel >> dataSource: aDataSource [

	dataSource := aDataSource
]

{ #category : #private }
ToSelectionModel >> ensureCompositeModel [

	self underlyingModel isComposite ifTrue: [ ^ self ].
	self underlyingModel: ToUnderlyingSelectionModel composite
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
ToSelectionModel >> isEmpty [

	^ self underlyingModel isEmpty
]

{ #category : #testing }
ToSelectionModel >> isNotEmpty [

	^ self isEmpty not
]

{ #category : #testing }
ToSelectionModel >> isWhole [

	^ self underlyingModel isWhole
]

{ #category : #accessing }
ToSelectionModel >> itemCount [

	^ self dataSource itemCount
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
