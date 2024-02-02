Class {
	#name : #ToListElementSelecter,
	#superclass : #Object,
	#traits : 'TToListSelectionOperator',
	#classTraits : 'TToListSelectionOperator classTrait',
	#instVars : [
		'currentIndex',
		'eventTarget',
		'distance',
		'pivot'
	],
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #'instance creation' }
ToListElementSelecter class >> on: anEventTargetWithDataSourceAndselectionModel [

	^ self new onInstalledIn: anEventTargetWithDataSourceAndselectionModel
]

{ #category : #'private - command handling' }
ToListElementSelecter >> addIndexesSelectionCommand: aCommand [

	self markPointedPosition: aCommand indexes first
]

{ #category : #'private - command handling' }
ToListElementSelecter >> addIntervalSelectionCommand: aCommand [

	self markPointedPosition: aCommand interval first
]

{ #category : #'other selection commands' }
ToListElementSelecter >> addOrRemoveNext [

	self currentIndex = self dataSource itemCount ifTrue: [ ^ self ].
	self addOrRemoveWithGap: 1
]

{ #category : #'other selection commands' }
ToListElementSelecter >> addOrRemovePrevious [

	self currentIndex <= 1 ifTrue: [ ^ self ].
	self addOrRemoveWithGap: -1
]

{ #category : #'private - other selection commands' }
ToListElementSelecter >> addOrRemoveWithGap: aGap [

	| nextIdx prevDistance deselect |
	self checkPivot.

	prevDistance := self distance.
	nextIdx := self currentIndex + aGap.
	self distance: self pivot - nextIdx.

	deselect := prevDistance abs - self distance abs ~= -1.
	deselect
		ifTrue: [
			| idx |
			idx := nextIdx - aGap.
			self deselectIndex: idx ]
		ifFalse: [
			[
			self selectIndex: nextIdx.
			nextIdx < self dataSource itemCount and: [
				nextIdx > 1 and: [ self selectionModel containsIndex: nextIdx + aGap ] ] ] whileTrue: [
				nextIdx := nextIdx + aGap.
				self distance: self distance - aGap ] ].

	self currentIndex: nextIdx
]

{ #category : #'private - command handling' }
ToListElementSelecter >> addWholeSelectionCommand: aCommand [

	self markPointedPosition: 0
]

{ #category : #'private - other selection commands' }
ToListElementSelecter >> checkPivot [

	self pivot ifNil: [
		self pivot: self currentIndex.
		self distance: 0 ]
]

{ #category : #accessing }
ToListElementSelecter >> currentIndex [

	^ currentIndex 
]

{ #category : #accessing }
ToListElementSelecter >> currentIndex: anIndex [

	currentIndex := anIndex
]

{ #category : #'t - list selection operator - accessing' }
ToListElementSelecter >> dataSource [

	^ self eventTarget dataSource
]

{ #category : #'t - list selection operator - event dispatching' }
ToListElementSelecter >> dispatchCommandResult: aCommand [

	self eventTarget dispatchEvent:
		(ToSelectionResultEvent new command: aCommand)
]

{ #category : #'private - other selection commands' }
ToListElementSelecter >> distance [
	
	^ distance
]

{ #category : #'private - other selection commands' }
ToListElementSelecter >> distance: aGap [
	
	distance := aGap
]

{ #category : #'t - list selection operator - accessing' }
ToListElementSelecter >> eventTarget [

	^ eventTarget
]

{ #category : #accessing }
ToListElementSelecter >> eventTarget: anEventTargetWithDataSourceAndselectionModel [

	eventTarget := anEventTargetWithDataSourceAndselectionModel
]

{ #category : #'private - other selection commands' }
ToListElementSelecter >> goTowardNext [ 

	self currentIndex isZero
		ifTrue: [
			self dataSource data ifEmpty: [ ^ false ].
			self markPointedPosition: 1 ]
		ifFalse: [
			self currentIndex < self dataSource data size ifFalse: [
				self markPointedPosition: 1.
				^ true ].
			self markPointedPosition: self currentIndex + 1 ].
	^ true
]

{ #category : #'private - other selection commands' }
ToListElementSelecter >> goTowardPrevious [

	self currentIndex isZero
		ifTrue: [
			self dataSource data ifEmpty: [ ^ false ].
			self markPointedPosition: self dataSource itemCount ]
		ifFalse: [
			self currentIndex > 1 ifFalse: [
				self markPointedPosition: self dataSource itemCount.
				^ true ].
			self markPointedPosition: self currentIndex - 1 ].
	^ true
]

{ #category : #initialization }
ToListElementSelecter >> initialize [

	super initialize.
	currentIndex := 0
]

{ #category : #'private - other selection commands' }
ToListElementSelecter >> markPointedPosition: anInteger [

	" pivot and distance are used for shift-arrow-up and down management "
	self pivot: nil.
	self distance: nil.
	
	self currentIndex: anInteger.

]

{ #category : #initialization }
ToListElementSelecter >> onInstalledIn: anEventTargetWithDataSourceAndselectionModel [

	eventTarget := anEventTargetWithDataSourceAndselectionModel.
	self installStrategy: anEventTargetWithDataSourceAndselectionModel selectionStrategy
]

{ #category : #'t - list selection operator - event dispatching' }
ToListElementSelecter >> onSelectionRequestSuccess: aSelectionRequestEvent [


	aSelectionRequestEvent command applyOn: self.
	self dispatchCommandResult: aSelectionRequestEvent command
]

{ #category : #initialization }
ToListElementSelecter >> onUninstalledIn: anEventTargetWithDataSourceAndselectionModel [

	self uninstallStrategy: anEventTargetWithDataSourceAndselectionModel selectionStrategy.
	eventTarget := nil
]

{ #category : #'private - other selection commands' }
ToListElementSelecter >> pivot [

	^ pivot
]

{ #category : #'private - other selection commands' }
ToListElementSelecter >> pivot: anIndex [

	pivot := anIndex
]

{ #category : #'private - command handling' }
ToListElementSelecter >> removeIndexesSelectionCommand: aCommand [

	self markPointedPosition: aCommand indexes first
]

{ #category : #'private - command handling' }
ToListElementSelecter >> removeIntervalSelectionCommand: aCommand [

	self markPointedPosition: aCommand interval first
]

{ #category : #'private - command handling' }
ToListElementSelecter >> removeWholeSelectionCommand: aCommand [

	self markPointedPosition: 0
]

{ #category : #'other selection commands' }
ToListElementSelecter >> selectNext [

	self goTowardNext ifTrue: [ self selectOnlyIndex: self currentIndex ]
]

{ #category : #'other selection commands' }
ToListElementSelecter >> selectPrevious [

	self goTowardPrevious ifTrue: [
		self selectOnlyIndex: self currentIndex ]
]

{ #category : #'other selection commands' }
ToListElementSelecter >> selectToIndex: index [

	| curr |
	curr := self currentIndex.
	self markPointedPosition: index.
	self pivot: curr.
	self distance: index - curr.
	curr < index
		ifTrue: [ self selectIndex: curr - 1 to: index ]
		ifFalse: [ self selectIndex: index - 1 to: curr ]
]

{ #category : #'t - list selection operator - accessing' }
ToListElementSelecter >> selectionModel [

	^ self eventTarget selectionModel
]
