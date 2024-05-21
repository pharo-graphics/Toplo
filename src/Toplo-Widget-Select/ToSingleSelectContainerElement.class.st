Class {
	#name : #ToSingleSelectContainerElement,
	#superclass : #ToElement,
	#instVars : [
		'fakeNode',
		'fakeDataItem',
		'node',
		'selectElement',
		'selectedIndex'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #adding }
ToSingleSelectContainerElement >> addFakeNode [

	self addChild: fakeNode
]

{ #category : #initialization }
ToSingleSelectContainerElement >> defaultLayout [

	^ BlLinearLayout new
]

{ #category : #initialization }
ToSingleSelectContainerElement >> defaultNodeClass [ 

	^ ToSingleSelectNode
]

{ #category : #accessing }
ToSingleSelectContainerElement >> fakeDataItem: aData [

	fakeDataItem := aData.
	self uninstallFakeNode.
	self installFakeNode 
]

{ #category : #accessing }
ToSingleSelectContainerElement >> filterString [ 

	^ self textInputElement filterString
]

{ #category : #accessing }
ToSingleSelectContainerElement >> inputTextField [

	^ self textInputElement inputTextField
]

{ #category : #initialization }
ToSingleSelectContainerElement >> installFakeNode [
	" the fake node is added when no data is selected to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	fakeNode ifNotNil: [ :fn |
		fn onUninstalledIn: self.
		fn removeFromParent ].

	fakeNode := self newNode.
	fakeNode id: #fakeNode.
	fakeNode width: 0.
	fakeNode constraintsDo: [ :c |
		c vertical matchParent.
		c linear vertical alignCenter ].

	fakeNode margin: BlInsets empty.

	" add the fake node (to keep a constant minimum height )"
	self addFakeNode
]

{ #category : #testing }
ToSingleSelectContainerElement >> isSingleNode [

	^ true
]

{ #category : #initialization }
ToSingleSelectContainerElement >> newNode [

	| newNode nodeHolder |
	newNode := self nodeClass new.
	newNode onInstalledIn: self.
		
	^ newNode
]

{ #category : #accessing }
ToSingleSelectContainerElement >> nodeClass [ 

	^ self defaultNodeClass
]

{ #category : #initialization }
ToSingleSelectContainerElement >> nodeHolderClass [ 

	^ ToElementBarNodeHolder
]

{ #category : #'api - hooks' }
ToSingleSelectContainerElement >> onInstalledIn: aSelectElement [

	selectElement := aSelectElement.
	self
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ].
	node := self newNode.
	self addChild: node.
	self installFakeNode
]

{ #category : #'api - hooks' }
ToSingleSelectContainerElement >> onUninstalledIn: aSelectElement [

	node onUninstalledIn: aSelectElement.
	node removeFromParent.
	node := nil.
	self uninstallFakeNode.
	selectElement := nil.


]

{ #category : #window }
ToSingleSelectContainerElement >> onWindowClosed [

	self textInputElement onWindowClosed
]

{ #category : #window }
ToSingleSelectContainerElement >> onWindowOpened [

	self textInputElement onWindowOpened
]

{ #category : #accessing }
ToSingleSelectContainerElement >> refresh [

	| nodeHolder  |
	selectedIndex := selectElement selectionModel isEmpty
		ifTrue: [
			0 ]
		ifFalse: [
			selectElement selectionModel firstIndex].
	self refreshInputTextElementWithSelectedData
]

{ #category : #accessing }
ToSingleSelectContainerElement >> refreshInputTextElementWithSelectedData [

	| t |
	self inputTextField text: ''.
	t := selectedIndex isZero ifTrue: [ '' ] ifFalse: [ selectElement dataAccessor at: selectedIndex ].
	self selectedDataTextField text: t
]

{ #category : #accessing }
ToSingleSelectContainerElement >> selectElement [

	^ selectElement
]

{ #category : #accessing }
ToSingleSelectContainerElement >> selectedDataTextField [

	^ self textInputElement selectedDataTextField
]

{ #category : #accessing }
ToSingleSelectContainerElement >> textInputElement [

	^ node textInputElement
]

{ #category : #initialization }
ToSingleSelectContainerElement >> uninstallFakeNode [
	" the fake node is added when no data is selected to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	fakeNode ifNotNil: [ :fn |
		fn onUninstalledIn: self.
		fn removeFromParent ].
	fakeNode := nil
]
