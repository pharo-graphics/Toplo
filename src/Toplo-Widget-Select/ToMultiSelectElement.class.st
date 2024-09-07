Class {
	#name : #ToMultiSelectElement,
	#superclass : #ToSelectElement,
	#instVars : [
		'hideSelected',
		'maxSelectedCount',
		'keepPickOrder'
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

{ #category : #accessing }
ToMultiSelectElement >> barElement [ 

	^ self innerContainer
]

{ #category : #'accessing - selection' }
ToMultiSelectElement >> checkHideSelectionFromListElement [

	self innerContainer checkHideSelectionFromListElement
]

{ #category : #'accessing - selection' }
ToMultiSelectElement >> checkMaxSelectedCountFromListElement [

	self innerContainer checkMaxSelectedCountFromListElement
]

{ #category : #accessing }
ToMultiSelectElement >> fakeDataItem: aDataItem [

	self innerContainer fakeDataItem: aDataItem
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

{ #category : #'instance creation' }
ToMultiSelectElement >> innerContainerClass [

	^ ToMultiSelectBarElement
]

{ #category : #accessing }
ToMultiSelectElement >> keepPickOrder [

	^ keepPickOrder ifNil: [ keepPickOrder := false ]
]

{ #category : #accessing }
ToMultiSelectElement >> keepPickOrder: aBoolean [

	keepPickOrder := aBoolean
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

{ #category : #skin }
ToMultiSelectElement >> newRawSkin [ 

	^ ToMultiSelectElementSkin new
]

{ #category : #'instance creation' }
ToMultiSelectElement >> newWindowManager [

	^ ToMultiSelectListWindowManager new
]

{ #category : #accessing }
ToMultiSelectElement >> nodeAutoDistribution: aBoolean [

	self innerContainer nodeAutoDistribution: aBoolean
]

{ #category : #accessing }
ToMultiSelectElement >> nodeBuilder: aValuable [

	self innerContainer nodeBuilder: aValuable
]

{ #category : #accessing }
ToMultiSelectElement >> nodeScrolling: aBoolean [

	self innerContainer nodeScrolling: aBoolean
]

{ #category : #accessing }
ToMultiSelectElement >> nodeWrapping: aBoolean [

	self innerContainer nodeWrapping: aBoolean
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
