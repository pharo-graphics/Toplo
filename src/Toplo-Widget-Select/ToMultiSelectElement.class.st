Class {
	#name : #ToMultiSelectElement,
	#superclass : #ToSelectElement,
	#instVars : [
		'hideSelected',
		'withGroups',
		'keepPickOrder',
		'maxSelectedCount',
		'isFlowable'
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

{ #category : #configuration }
ToMultiSelectElement >> applyConfiguration [ 

	super applyConfiguration.
	self innerElement isFlowable: isFlowable.
	self innerElement keepPickOrder: keepPickOrder.

	self iconContainer maxSelectedCount: maxSelectedCount .
	self innerElement maxSelectedCount: maxSelectedCount.

]

{ #category : #accessing }
ToMultiSelectElement >> autoDistribute: aBoolean [

	self innerElement autoDistribute: aBoolean
]

{ #category : #accessing }
ToMultiSelectElement >> barElement [ 

	^ self innerElement
]

{ #category : #accessing }
ToMultiSelectElement >> barTrackElement [ 

	^ self barElement trackElement
]

{ #category : #'accessing - selection' }
ToMultiSelectElement >> checkHideSelectionFromListElement [

	self innerElement checkHideSelectionFromListElement
]

{ #category : #'accessing - selection' }
ToMultiSelectElement >> checkMaxSelectedCount [

	self innerElement checkMaxSelectedCount
]

{ #category : #'accessing - window' }
ToMultiSelectElement >> closeOnItemPicking [

	^ false
]

{ #category : #accessing }
ToMultiSelectElement >> hideSelected [

	^ hideSelected 
]

{ #category : #accessing }
ToMultiSelectElement >> hideSelected: aBoolean [

	hideSelected := aBoolean.
	self requestConfiguration
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
	withGroups := false.
	isFlowable := false.
	keepPickOrder := false.
	maxSelectedCount := 0
]

{ #category : #'instance creation' }
ToMultiSelectElement >> innerElementClass [

	^ ToMultiSelectBarElement
]

{ #category : #accessing }
ToMultiSelectElement >> isFlowable: aBoolean [

	isFlowable := aBoolean.
	self requestConfiguration
]

{ #category : #accessing }
ToMultiSelectElement >> isScrollable: aBoolean [

	self innerElement isScrollable: aBoolean
]

{ #category : #accessing }
ToMultiSelectElement >> keepPickOrder: aBoolean [

	keepPickOrder := aBoolean.
	self requestConfiguration
]

{ #category : #accessing }
ToMultiSelectElement >> maxSelectedCount: aNumber [

	maxSelectedCount := aNumber.
	self requestConfiguration
]

{ #category : #'instance creation' }
ToMultiSelectElement >> newIconContainer [

	^ ToMultiSelectIconContainer new
]

{ #category : #'instance creation' }
ToMultiSelectElement >> newPopupWindowManager [

	^ ToMultiSelectPopupManager new
]

{ #category : #skin }
ToMultiSelectElement >> newRawSkin [ 

	^ ToMultiSelectElementSkin new
]

{ #category : #accessing }
ToMultiSelectElement >> nodeBuilder: aValuable [
	"aValuable takes 3 optional args: first, the node to build, second, the dataItem and third, the holder in the list element "

	self innerElement nodeBuilder: aValuable
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

{ #category : #accessing }
ToMultiSelectElement >> tagBuilder: aValuable [
	"aValuable takes 3 optional args: first, the node to build, second, the dataItem and third, the holder in the list element "

	self innerElement tagBuilder: aValuable
]

{ #category : #private }
ToMultiSelectElement >> updateSelectedCountLabel [

	self iconContainer updateSelectedCountLabel
]

{ #category : #accessing }
ToMultiSelectElement >> withGroups [

	^ withGroups 
]

{ #category : #accessing }
ToMultiSelectElement >> withGroups: aBoolean [

	withGroups := aBoolean
]
