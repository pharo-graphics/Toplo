Class {
	#name : #ToMultiSelectElement,
	#superclass : #ToSelectElement,
	#instVars : [
		'hideSelected',
		'withCloseButton',
		'withGroups'
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

	^ self innerElement
]

{ #category : #'accessing - selection' }
ToMultiSelectElement >> checkHideSelectionFromListElement [

	self innerElement checkHideSelectionFromListElement
]

{ #category : #'accessing - selection' }
ToMultiSelectElement >> checkMaxSelectedCount [

	self innerElement checkMaxSelectedCount
]

{ #category : #accessing }
ToMultiSelectElement >> hideSelected [

	^ hideSelected 
]

{ #category : #accessing }
ToMultiSelectElement >> hideSelected: aBoolean [

	hideSelected := aBoolean.
	self windowManager checkPickOutside: aBoolean not
]

{ #category : #accessing }
ToMultiSelectElement >> iconContainer: anIconContainer [

	self iconContainer = anIconContainer ifTrue: [ ^ self ].
	self iconContainer ifNotNil: [
		self iconContainer onUninstalledIn: self ].
	super iconContainer: anIconContainer.
	anIconContainer selectionModel: self selectionModel
]

{ #category : #initialization }
ToMultiSelectElement >> initialize [

	super initialize.
	hideSelected := false.
	withGroups := false
]

{ #category : #'instance creation' }
ToMultiSelectElement >> innerElementClass [

	^ ToMultiSelectBarElement
]

{ #category : #accessing }
ToMultiSelectElement >> keepPickOrder: aBoolean [

	self innerElement keepPickOrder: aBoolean
]

{ #category : #accessing }
ToMultiSelectElement >> maxSelectedCount: aNumber [

	self iconContainer maxSelectedCount: aNumber.
	self innerElement maxSelectedCount: aNumber.

]

{ #category : #'instance creation' }
ToMultiSelectElement >> newIconContainer [

	^ ToMultiSelectIconContainer new forFiltering: self isFiltrable 
]

{ #category : #'instance creation' }
ToMultiSelectElement >> newPopupWindowManager [

	^ ToMultiSelectPopupWindowManager new
]

{ #category : #skin }
ToMultiSelectElement >> newRawSkin [ 

	^ ToMultiSelectElementSkin new
]

{ #category : #accessing }
ToMultiSelectElement >> nodeAutoDistribution: aBoolean [

	self innerElement nodeAutoDistribution: aBoolean
]

{ #category : #accessing }
ToMultiSelectElement >> nodeBuilder: aValuable [
	"aValuable takes 3 optional args: first, the node to build, second, the dataItem and third, the holder in the list element "

	self innerElement nodeBuilder: aValuable
]

{ #category : #accessing }
ToMultiSelectElement >> nodeScrolling: aBoolean [

	self innerElement nodeScrolling: aBoolean
]

{ #category : #accessing }
ToMultiSelectElement >> nodeWrapping: aBoolean [

	self innerElement nodeWrapping: aBoolean
]

{ #category : #'accessing - selection' }
ToMultiSelectElement >> onSelectionChangedInPopupListElement: anEvent [

	| selectedDataItems changedEvent |
	super onSelectionChangedInPopupListElement: anEvent.
	selectedDataItems := self selectionModel selectedIndexesCollect: [
		                     :idx | self sieve originalData at: idx ].
	changedEvent := ToSelectChangedEvent new.
	changedEvent selectedDataItems: selectedDataItems.
	changedEvent selectedIndexes: self selectionModel selectedIndexes.
	self dispatchEvent: changedEvent
]

{ #category : #'accessing - list' }
ToMultiSelectElement >> setGroupIndex: anIndex [

	self popupListElement groupSelecter selectIndex: anIndex
]

{ #category : #private }
ToMultiSelectElement >> updateSelectedCountLabel [

	self iconContainer updateSelectedCountLabel
]

{ #category : #accessing }
ToMultiSelectElement >> withCloseButton [

	^ withCloseButton ifNil: [ withCloseButton := true ]
]

{ #category : #accessing }
ToMultiSelectElement >> withCloseButton: aBoolean [

	withCloseButton := aBoolean
]

{ #category : #accessing }
ToMultiSelectElement >> withGroups [

	^ withGroups 
]

{ #category : #accessing }
ToMultiSelectElement >> withGroups: aBoolean [

	withGroups := aBoolean
]
