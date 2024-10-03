Class {
	#name : #ToMultiSelectElement,
	#superclass : #ToSelectElement,
	#instVars : [
		'hideSelected',
		'nodesWithCloseButton'
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
ToMultiSelectElement >> checkMaxSelectedCount [

	self innerContainer checkMaxSelectedCount
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
	super iconContainer: anIconContainer.
	anIconContainer selectionModel: self selectionModel
]

{ #category : #initialization }
ToMultiSelectElement >> initialize [

	super initialize.
	hideSelected := false
]

{ #category : #'instance creation' }
ToMultiSelectElement >> innerContainerClass [

	^ ToMultiSelectBarElement
]

{ #category : #accessing }
ToMultiSelectElement >> keepPickOrder: aBoolean [

	self innerContainer keepPickOrder: aBoolean
]

{ #category : #accessing }
ToMultiSelectElement >> maxSelectedCount: aNumber [

	self iconContainer maxSelectedCount: aNumber.
	self innerContainer maxSelectedCount: aNumber.

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

{ #category : #accessing }
ToMultiSelectElement >> nodesWithCloseButton [

	^ nodesWithCloseButton ifNil: [ nodesWithCloseButton := true ]
]

{ #category : #accessing }
ToMultiSelectElement >> nodesWithCloseButton: aBoolean [

	nodesWithCloseButton := aBoolean
]

{ #category : #'accessing - list' }
ToMultiSelectElement >> setGroupIndex: anIndex [

	self popupListElement groupSelecter selectIndex: anIndex.
	self popupListElement unselectableSelecter selectIndex: anIndex
]

{ #category : #private }
ToMultiSelectElement >> updateSelectedCountLabel [

	self iconContainer updateSelectedCountLabel
]
