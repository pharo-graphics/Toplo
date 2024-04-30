Class {
	#name : #ToSelectHeaderNode,
	#superclass : #ToElement,
	#instVars : [
		'triplet',
		'mouseUpHandler',
		'headerNodeHolder'
	],
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #accessing }
ToSelectHeaderNode >> endContainer [

	^ triplet endContainer
]

{ #category : #accessing }
ToSelectHeaderNode >> headerNodeHolder [

	^ headerNodeHolder 
]

{ #category : #accessing }
ToSelectHeaderNode >> headerNodeHolder: aHeaderNodeHolder [

	headerNodeHolder := aHeaderNodeHolder
]

{ #category : #initialization }
ToSelectHeaderNode >> initialize [

	super initialize.

	self applySkinInstallerOnFirstRequest: true.
	self layout: BlLinearLayout horizontal.
	triplet := ToTripletElement new.
	triplet hMatchParent.
	self addChild: triplet.
	self childrenDo: [ :child |
		child constraintsDo: [ :c | c linear vertical alignCenter ] ].

	self fitContent
]

{ #category : #testing }
ToSelectHeaderNode >> isRemovable [

	^ false
]

{ #category : #accessing }
ToSelectHeaderNode >> middleContainer [

	^ triplet middleContainer
]

{ #category : #'api - hooks' }
ToSelectHeaderNode >> onInstalledIn: aSelect [

	" to avoid unwanted window closing (because of the flow 
	layout that can enlarge the select height when a node is added)"
	mouseUpHandler := BlEventHandler
			 on: BlMouseUpEvent
			 do: [ :event | event consume ].
	self addEventHandler: mouseUpHandler
]

{ #category : #'api - hooks' }
ToSelectHeaderNode >> onUninstalledIn: aSelectHeaderNodeContainer [

	self removeEventHandler: mouseUpHandler.
	mouseUpHandler := nil


]

{ #category : #'private configurating' }
ToSelectHeaderNode >> removeFromSelect [
	" 
	First, try to remove the node by deselecting the corresponding list node in the list (if found). 
	Second, if the data is not one of the actual list element data, remove the data through the select "

	| sieve headerElement originalIndex |
	headerElement := self headerNodeHolder headerElement.
	sieve := headerElement sieve.
	originalIndex := sieve dataPositionIndex at:
		                 self headerNodeHolder data.
	headerElement selectionModel deselectIndex: originalIndex.
	headerElement fireEvent: ToSelectSelectionChanged new
]

{ #category : #accessing }
ToSelectHeaderNode >> startContainer [

	^ triplet startContainer
]
