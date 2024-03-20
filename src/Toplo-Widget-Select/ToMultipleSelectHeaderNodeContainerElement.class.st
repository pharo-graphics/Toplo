Class {
	#name : #ToMultipleSelectHeaderNodeContainerElement,
	#superclass : #ToSelectHeaderNodeContainerElement,
	#instVars : [
		'textInputElement',
		'headerNodeHolders'
	],
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #adding }
ToMultipleSelectHeaderNodeContainerElement >> addAllDataNodes: aNodeCollection [

	aNodeCollection do: [ :n | self addDataNode: n ]
]

{ #category : #adding }
ToMultipleSelectHeaderNodeContainerElement >> addDataNode: aNode [

	self addChild: aNode before: self textInputElement
]

{ #category : #accessing }
ToMultipleSelectHeaderNodeContainerElement >> defaultHeaderNodeBuilder [

	^ [ :aSelectNode :aNodeHolder |
	  aSelectNode beRemovable.
	  aSelectNode middleContainer addChild:
		  (ToLabel text: aNodeHolder data asString) ]
]

{ #category : #accessing }
ToMultipleSelectHeaderNodeContainerElement >> defaultHeaderNodeClass [ 

	^ ToVisibleSelectHeaderNode
]

{ #category : #enumerating }
ToMultipleSelectHeaderNodeContainerElement >> headerDataNodesDo: aBlock [

	self headerNodeHolders do: [ :holder |	aBlock value: holder node ].
]

{ #category : #enumerating }
ToMultipleSelectHeaderNodeContainerElement >> headerDataNodesSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self headerNodeHolders do: [ :holder |
			  (aBlock value: holder node) ifTrue: [
				  stream nextPut: holder node ] ] ]
]

{ #category : #enumerating }
ToMultipleSelectHeaderNodeContainerElement >> headerNodeHolders [

	^ headerNodeHolders ifNil: [
		  headerNodeHolders := OrderedCollection new ]
]

{ #category : #'api - hooks' }
ToMultipleSelectHeaderNodeContainerElement >> onInstalledIn: aSelect [

	super onInstalledIn: aSelect.
	self layout: (aSelect nodeWrapping
			 ifTrue: [ BlFlowLayout horizontal ]
			 ifFalse: [ BlLinearLayout horizontal ]).
	self
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ].
	" The textField is added whatever the mode to draw the placeholder text if any.
	In case of read-only mode, the textfield is set as read-only by the mode "
	textInputElement := ToSelectTextInputElement new.
	textInputElement onInstalledIn: select.
	textInputElement hFitContent.
	self addChild: textInputElement.
	self initializeFakeNode
]

{ #category : #layout }
ToMultipleSelectHeaderNodeContainerElement >> onMeasure: anExtentMeasurementSpec [

	| invisibleNodes visibleNodes showerNode showerHolder |
	super onMeasure: anExtentMeasurementSpec.
	invisibleNodes := self headerDataNodesSelect: [ :n |
		                  n isFullyVisible not ].
	invisibleNodes ifEmpty: [ ^ self ].
	visibleNodes := self headerDataNodesSelect: [ :n | n isFullyVisible ].
	visibleNodes ifNotEmpty: [
		invisibleNodes := invisibleNodes copyWith: visibleNodes last ].
	invisibleNodes do: [ :node | node onUninstalledIn: select ].
	showerHolder := ToCompositeHeaderNodeHolder new select: select.
	showerHolder holders:
		(invisibleNodes collect: [ :node | node selectHolder ]).
	showerNode := ToInvisibleSelectHeaderNodesShower new.
	showerHolder node: showerNode.
	showerNode selectHolder: showerHolder.
	invisibleNodes do: [ :node |
		self detachChild: node.
		headerNodeHolders remove: node selectHolder ].
	showerNode middleContainer addChild:
		(ToLabel text: '+ ' , invisibleNodes size asString , ' ...').
	self addDataNode: showerNode
]

{ #category : #accessing }
ToMultipleSelectHeaderNodeContainerElement >> onNodeWrappingChange [

	self layout: (select nodeWrapping
			 ifTrue: [ BlFlowLayout horizontal ]
			 ifFalse: [ BlLinearLayout horizontal ])
]

{ #category : #'api - hooks' }
ToMultipleSelectHeaderNodeContainerElement >> onUninstalledIn: aSelect [

	self headerDataNodesDo: [ :node |
		node onUninstalledIn: select.
		node removeFromParent ].
	textInputElement onUninstalledIn: select.
	textInputElement removeFromParent.
	textInputElement := nil.
	self headerNodeHolders reset.
	fakeNode onUninstalledIn: select.
	fakeNode removeFromParent.
	fakeNode := nil.
	super onUninstalledIn: aSelect.

]

{ #category : #accessing }
ToMultipleSelectHeaderNodeContainerElement >> refresh [
	" first remove all data nodes "

	self headerDataNodesDo: [ :node |
		node onUninstalledIn: select.
		node removeFromParent ].
	self headerNodeHolders reset.
	" then rebuild current nodes according to current selection "
	select selectionModel selectedIndexesDo: [ :idx |
		| node selectedData |
		node := self newHeaderNode.
		selectedData := select dataAccessor at: idx.
		node selectHolder
			position: idx;
			data: selectedData.
		self headerNodeBuilder value: node value: node selectHolder.
		self headerNodeHolders add: node selectHolder.
		self addDataNode: node ]
]

{ #category : #accessing }
ToMultipleSelectHeaderNodeContainerElement >> textInputElement [ 

	^ textInputElement 
]
