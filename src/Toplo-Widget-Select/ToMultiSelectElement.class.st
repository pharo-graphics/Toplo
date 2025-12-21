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
	self innerElement toConfiguration isFlowable: isFlowable.
	self innerElement keepPickOrder: keepPickOrder.
	self endContainer maxSelectedCount: maxSelectedCount.
	self innerElement maxSelectedCount: maxSelectedCount
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
ToMultiSelectElement >> barInnerElement [ 

	^ self barElement innerElement
]

{ #category : #accessing }
ToMultiSelectElement >> barTrackElement [ 

	^ self barElement innerElement trackElement
]

{ #category : #'accessing - selection' }
ToMultiSelectElement >> checkHideSelectionFromListElement [

	self innerElement checkHideSelectionFromListElement
]

{ #category : #'accessing - selection' }
ToMultiSelectElement >> checkMaxSelectedCountInHeader [

	self endContainer updateSelectedCountLabelWith:
		self header selectedDataItems size
]

{ #category : #'accessing - selection' }
ToMultiSelectElement >> checkMaxSelectedCountInPopupList [

	self popupListElement postponeAction: [
		self innerElement checkMaxSelectedCount ]
]

{ #category : #'accessing - window' }
ToMultiSelectElement >> closeOnItemPicking [

	^ false
]

{ #category : #'accessing - selection' }
ToMultiSelectElement >> haveMaxSelectedCount [

	^ maxSelectedCount ~= -1
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

{ #category : #initialization }
ToMultiSelectElement >> initialize [

	super initialize.
	self initializeListSelectionChecker.
	hideSelected := false.
	withGroups := false.
	isFlowable := false.
	keepPickOrder := false.
	maxSelectedCount := -1
]

{ #category : #initialization }
ToMultiSelectElement >> initializeListSelectionChecker [

	" add the checked to check the selection command "
	self addEventHandler:
		ToMultiSelectHeaderSelectionChecker new.
	" add the handler in my sieve so that I can receive the selecter command application event  "
	self sieve
		addEventHandlerOn: ToListSelecterCommandApplicationRequestEvent
		do: [ :event | | copiedEvent |
			copiedEvent := event copy.
			self dispatchEvent: copiedEvent.
			event authorized: copiedEvent authorized ].

]

{ #category : #'instance creation' }
ToMultiSelectElement >> innerElementClass [

	^ ToMultiSelectHeaderListElement
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
ToMultiSelectElement >> maxSelectedCount [

	^ maxSelectedCount 
]

{ #category : #accessing }
ToMultiSelectElement >> maxSelectedCount: aNumber [

	maxSelectedCount := aNumber.
	self requestConfiguration
]

{ #category : #'t - triplet container - instance creation' }
ToMultiSelectElement >> newEndContainer [

	^ ToMultiSelectHeaderEndContainer new
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
ToMultiSelectElement >> nodeBuilder: aValuable [
	"aValuable takes 3 optional args: first, the node to build, second, the dataItem and third, the holder in the list element "

	self nodeManager nodeBuilder: aValuable
]

{ #category : #accessing }
ToMultiSelectElement >> nodeManager [

	^ self innerElement nodeManager
]

{ #category : #window }
ToMultiSelectElement >> onPopupWindowOpened [

	super onPopupWindowOpened.
	self checkMaxSelectedCountInPopupList 
]

{ #category : #'accessing - list' }
ToMultiSelectElement >> setGroupIndex: anIndex [

	self popupListElement groupSelecter selectIndex: anIndex
]

{ #category : #accessing }
ToMultiSelectElement >> withGroups [

	^ withGroups 
]

{ #category : #accessing }
ToMultiSelectElement >> withGroups: aBoolean [

	withGroups := aBoolean
]
