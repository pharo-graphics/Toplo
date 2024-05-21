Class {
	#name : #ToSelectNodeContainerElement,
	#superclass : #ToElement,
	#instVars : [
		'fakeNode',
		'fakeDataItem',
		'node',
		'nodeHolder',
		'nodeBuilder',
		'nodeFactory'
	],
	#category : #'Toplo-Widget-Select-Single'
}

{ #category : #initialization }
ToSelectNodeContainerElement >> defaultLayout [

	^ BlLinearLayout new
]

{ #category : #initialization }
ToSelectNodeContainerElement >> defaultNodeBuilder [

	^ [ :theNode :theHolder :theDataItem |
	  theNode selectedDataTextField text:
		  (theDataItem ifNil: [ '' ] ifNotNil: [ :d | d asString ]) ]
]

{ #category : #initialization }
ToSelectNodeContainerElement >> defaultNodeFactory [

	^ [ :holder | ToSelectNode new ]
]

{ #category : #accessing }
ToSelectNodeContainerElement >> filterString [ 

	^ self textInputElement filterString
]

{ #category : #initialization }
ToSelectNodeContainerElement >> initialize [

	super initialize.
	nodeFactory := self defaultNodeFactory.
	nodeBuilder := self defaultNodeBuilder.
]

{ #category : #accessing }
ToSelectNodeContainerElement >> inputTextField [

	^ self textInputElement inputTextField
]

{ #category : #initialization }
ToSelectNodeContainerElement >> installFakeNodeIn: aSelectElement [
	" the fake node is added when no data is selected to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	| fakeNodeHolder |
	fakeNode ifNotNil: [ :fn |
		fn onUninstalledIn: self.
		fn removeFromParent ].

	fakeNodeHolder:= ToSelectNodeHolder new.
	fakeNodeHolder selectElement: aSelectElement.
	fakeNode := self newNodeInHolder: fakeNodeHolder.
	fakeNode onInstalledIn: self.
	nodeBuilder cull: fakeNode cull: fakeNodeHolder cull: fakeDataItem.
	fakeNode id: #fakeNode.
	fakeNode width: 0.
	fakeNode constraintsDo: [ :c |
		c vertical matchParent.
		c linear vertical alignCenter ].

	" add the fake node (to keep a constant minimum height )"
	self addChild: fakeNode
]

{ #category : #testing }
ToSelectNodeContainerElement >> isSingleNode [

	^ true
]

{ #category : #initialization }
ToSelectNodeContainerElement >> newNodeInHolder: anHolder [

	| newNode infiniteConstraints |
	newNode := nodeFactory cull: nodeHolder.
	infiniteConstraints := newNode constraints infinite.
	infiniteConstraints holder: anHolder.
	^ newNode
]

{ #category : #accessing }
ToSelectNodeContainerElement >> nodeBuilder: aValuable [

	" aValuable takes 3 args: the node? its holder and the selected dataItem "
	nodeBuilder := aValuable
]

{ #category : #accessing }
ToSelectNodeContainerElement >> nodeFactory: aValuable [

	nodeFactory := aValuable
]

{ #category : #initialization }
ToSelectNodeContainerElement >> nodeHolderClass [ 

	^ ToElementBarNodeHolder
]

{ #category : #'api - hooks' }
ToSelectNodeContainerElement >> onInstalledIn: aSelectElement [

	nodeHolder := ToSelectNodeHolder new.
	nodeHolder selectElement: aSelectElement.
	self
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ].
	node := self newNodeInHolder: nodeHolder.
	node onInstalledIn: self.

	self refresh.

	self addChild: node.
	self installFakeNodeIn: aSelectElement
]

{ #category : #'api - hooks' }
ToSelectNodeContainerElement >> onUninstalledIn: aSelectElement [

	node onUninstalledIn: aSelectElement.
	node removeFromParent.
	node := nil.
	nodeHolder := nil.
	self uninstallFakeNodeIn: aSelectElement

]

{ #category : #window }
ToSelectNodeContainerElement >> onWindowClosed [

	self textInputElement onWindowClosed
]

{ #category : #window }
ToSelectNodeContainerElement >> onWindowOpened [

	self textInputElement onWindowOpened
]

{ #category : #accessing }
ToSelectNodeContainerElement >> refresh [

	| selectedIndex dataItem |
	selectedIndex := nodeHolder selectElement selectionModel isEmpty
		                 ifTrue: [ 0 ]
		                 ifFalse: [
		                 nodeHolder selectElement selectionModel firstIndex ].
	self inputTextField text: ''.
	nodeHolder position: selectedIndex.
	selectedIndex isZero ifFalse: [ dataItem := nodeHolder selectElement dataAccessor at: selectedIndex ].
	nodeBuilder cull: node cull: nodeHolder cull: dataItem
]

{ #category : #accessing }
ToSelectNodeContainerElement >> selectElement [

	^ nodeHolder selectElement
]

{ #category : #accessing }
ToSelectNodeContainerElement >> selectedDataTextField [

	^ self textInputElement selectedDataTextField
]

{ #category : #accessing }
ToSelectNodeContainerElement >> textInputElement [

	^ node textInputElement
]

{ #category : #initialization }
ToSelectNodeContainerElement >> uninstallFakeNodeIn: aSelectElement [
	" the fake node is added when no data is selected to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	fakeNode ifNotNil: [ :fn |
		fn onUninstalledIn: self.
		fn removeFromParent ].
	fakeNode := nil
]
