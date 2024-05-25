Class {
	#name : #ToMultiSelectElement,
	#superclass : #ToSelectElement,
	#instVars : [
		'hideSelected',
		'maxSelectedCount'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'accessing - list' }
ToMultiSelectElement >> addGroup: anObject withData: aCollection [

	| grpIdx |
	self dataAccessor add: anObject.
	grpIdx := self dataAccessor itemCount.
	self setGroupIndex: grpIdx.
	self dataAccessor addAll: aCollection
]

{ #category : #'accessing - selection' }
ToMultiSelectElement >> allowSelectedCount: aNumber [

	^ maxSelectedCount isZero or: [ aNumber <= maxSelectedCount ]
]

{ #category : #'accessing - selection' }
ToMultiSelectElement >> assertMaxSelectedCount: aNumber [

	(self allowSelectedCount: aNumber) ifFalse: [
		self enqueueTask: (BlTaskAction new action: [
				 Error signal: 'Max selected count reached' ]) ]
]

{ #category : #'accessing - selection' }
ToMultiSelectElement >> checkHideSelectionFromListElement [

	hideSelected ifFalse: [ ^ self ].
	self listElement dataAccessor withIndexDo: [ :d :localIndex |
		| originalIndex |
		originalIndex := self sieve dataPositionIndex at: d.
		(self listElement selectionModel containsIndex: localIndex)
			ifTrue: [ self listElement selectionModel hideIndex: localIndex ]
			ifFalse: [ self listElement selectionModel unhideIndex: localIndex ].
		self listElement selectionModel
			transferSelectionFromIndex: localIndex
			toIndex: originalIndex
			in: self selectionModel ].
	self listElement dataSource notifyChanged.
]

{ #category : #'accessing - selection' }
ToMultiSelectElement >> checkMaxSelectedCountFromListElement [

	| unselectableSM groupeSM |
	maxSelectedCount isZero ifTrue: [ ^ self ].
	
	unselectableSM := self listElement unselectableSelectionModel.
	groupeSM := self listElement groupSelectionModel.

	self updateSelectedCountLabel.

	self assertMaxSelectedCount: self selectionModel selectedIndexesCount.
	self listElement dataAccessor withIndexDo: [ :d :localIndex |
		| originalIndex |
		originalIndex := self sieve dataPositionIndex at: d.
		(groupeSM containsIndex: localIndex) ifFalse: [
			self selectionModel selectedIndexesCount < maxSelectedCount
				ifTrue: [ unselectableSM deselectIndex: localIndex ]
				ifFalse: [
					(self selectionModel containsIndex: originalIndex) ifFalse: [
						unselectableSM selectIndex: localIndex ] ] ].

		self listElement selectionModel
			transferSelectionFromIndex: localIndex
			toIndex: originalIndex
			in: self selectionModel ].
		
	self listElement dataSource notifyChanged
]

{ #category : #accessing }
ToMultiSelectElement >> hideSelected [

	^ hideSelected 
]

{ #category : #accessing }
ToMultiSelectElement >> hideSelected: aBoolean [

	hideSelected := aBoolean
]

{ #category : #accessing }
ToMultiSelectElement >> iconContainer: anIconContainer [

	self iconContainer = anIconContainer ifTrue: [ ^ self ].
	self iconContainer ifNotNil: [
		self iconContainer onUninstalledIn: self ].
	anIconContainer selectionModel: self selectionModel.
	self endElement: anIconContainer
]

{ #category : #initialization }
ToMultiSelectElement >> initialize [

	super initialize.
	hideSelected := false.
	maxSelectedCount := 0
]

{ #category : #initialization }
ToMultiSelectElement >> installNodeContainer [ 

	super installNodeContainer.
	self listElement selectionMode multiple: true.
	self requestNewSkin 
]

{ #category : #accessing }
ToMultiSelectElement >> maxSelectedCount [

	^ maxSelectedCount
]

{ #category : #accessing }
ToMultiSelectElement >> maxSelectedCount: aNumber [

	maxSelectedCount := aNumber.
	self iconContainer maxSelectedCount: aNumber
]

{ #category : #'instance creation' }
ToMultiSelectElement >> newIconContainer [

	^ ToMultiSelectIconContainer new forFiltering: self isFiltrable 
]

{ #category : #'instance creation' }
ToMultiSelectElement >> newNodeContainer [ 

	^ ToMultipleSelectBarElement new
]

{ #category : #'accessing - selection' }
ToMultiSelectElement >> onSelectionChanged [

	| listData |
	listData := self listElement dataAccessor.
	" update list according to my selection model"
	listData withIndexDo: [ :d :localIndex |
		| originalIndex |
		originalIndex := self sieve dataPositionIndex at: d.
		self selectionModel
			transferSelectionFromIndex: originalIndex
			toIndex: localIndex
			in: self listElement selectionModel ].
	self refresh.
	self listElement notifyPrimarySelectionDirty
]

{ #category : #'accessing - selection' }
ToMultiSelectElement >> onSelectionChangedInListElement [

	self showHidePlaceholder.
	self refresh.

	self checkHideSelectionFromListElement.
	self checkMaxSelectedCountFromListElement.

	self listElement notifyPrimarySelectionDirty.
	self nodeContainer requestLayout
]

{ #category : #'accessing - selection' }
ToMultiSelectElement >> selectionModel [

	^ self nodeContainer selectionModel
]

{ #category : #'accessing - list' }
ToMultiSelectElement >> setGroupIndex: anIndex [

	self listElement groupSelecter selectIndex: anIndex.
	self listElement unselectableSelecter selectIndex: anIndex
]

{ #category : #private }
ToMultiSelectElement >> updateSelectedCountLabel [

	self iconContainer updateSelectedCountLabel
]
