Class {
	#name : #ToSelectHeaderNodeContainerElement,
	#superclass : #ToElement,
	#instVars : [
		'fakeNode',
		'headerNodeClass',
		'headerNodeBuilder',
		'holder',
		'fakeDataItem',
		'nodeWrapping'
	],
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #layout }
ToSelectHeaderNodeContainerElement >> checkVisibleNodes [
]

{ #category : #initialization }
ToSelectHeaderNodeContainerElement >> defaultHeaderNodeBuilder [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToSelectHeaderNodeContainerElement >> defaultHeaderNodeClass [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToSelectHeaderNodeContainerElement >> fakeDataItem: aData [

	fakeDataItem := aData.
	self initializeFakeNode 
]

{ #category : #accessing }
ToSelectHeaderNodeContainerElement >> filterString [ 

	^ self textInputElement filterString
]

{ #category : #accessing }
ToSelectHeaderNodeContainerElement >> headerNodeBuilder [

	" see the mutator method  "
	
	^ headerNodeBuilder ifNil: [ headerNodeBuilder := self defaultHeaderNodeBuilder ]
]

{ #category : #accessing }
ToSelectHeaderNodeContainerElement >> headerNodeBuilder: aValuable [

	" builds a select node element from list data. 
	aValuable take the select node element to build as first argument 
	and the select node holder as second argument"
	
	headerNodeBuilder := aValuable.
	self initializeFakeNode
]

{ #category : #accessing }
ToSelectHeaderNodeContainerElement >> headerNodeClass [ 

	" lazy because asking for it may require the mode to be set "
	^ headerNodeClass ifNil: [ 	headerNodeClass := self defaultHeaderNodeClass ]
]

{ #category : #accessing }
ToSelectHeaderNodeContainerElement >> headerNodeClass: aNodeClass [

	headerNodeClass := aNodeClass.
	self initializeFakeNode
]

{ #category : #initialization }
ToSelectHeaderNodeContainerElement >> headerNodeHolderClass [ 

	^ ToHeaderNodeHolder
]

{ #category : #initialization }
ToSelectHeaderNodeContainerElement >> initialize [

	super initialize.
	nodeWrapping := true

]

{ #category : #initialization }
ToSelectHeaderNodeContainerElement >> initializeFakeNode [
	" the fake node is added when no data is selected to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."
 
	fakeNode ifNotNil: [ :fn |
		fn onUninstalledIn: self.
		fn removeFromParent ].
	fakeNode := self newHeaderNode.
	fakeNode id: #fakeNode.
	fakeNode onInstalledIn: holder.
	fakeNode headerNodeHolder
		data: fakeDataItem.
	self headerNodeBuilder value: fakeNode value: fakeNode headerNodeHolder.
	fakeNode width: 0.
	fakeNode constraintsDo: [ :c |
		c flow vertical alignCenter.
		c linear vertical alignCenter ].
	" add the fake node if the selection is empty (to keep a constant minimum height )"
	self addChild: fakeNode
]

{ #category : #accessing }
ToSelectHeaderNodeContainerElement >> inputTextField [

	^ self textInputElement inputTextField
]

{ #category : #initialization }
ToSelectHeaderNodeContainerElement >> newHeaderNode [

	| node nodeHolder |
	node := self headerNodeClass new.
	nodeHolder := self newHeaderNodeHolder.
	node headerNodeHolder: nodeHolder.
	nodeHolder
		node: node;
		position: 0;
		headerElement: holder;
		data: nil.
		
	^ node
]

{ #category : #initialization }
ToSelectHeaderNodeContainerElement >> newHeaderNodeHolder [

	^ self headerNodeHolderClass new headerElement: holder; yourself
]

{ #category : #accessing }
ToSelectHeaderNodeContainerElement >> nodeWrapping: aBoolean [

	nodeWrapping := aBoolean.
	self onNodeWrappingChange  
]

{ #category : #'api - hooks' }
ToSelectHeaderNodeContainerElement >> onInstalledIn: anHolder [

	holder := anHolder
]

{ #category : #accessing }
ToSelectHeaderNodeContainerElement >> onNodeWrappingChange [ 
]

{ #category : #'api - hooks' }
ToSelectHeaderNodeContainerElement >> onUninstalledIn: aHolder [

	holder := nil
]

{ #category : #window }
ToSelectHeaderNodeContainerElement >> onWindowClosed [

	self textInputElement onWindowClosed
]

{ #category : #window }
ToSelectHeaderNodeContainerElement >> onWindowOpened [

	self textInputElement onWindowOpened
]

{ #category : #accessing }
ToSelectHeaderNodeContainerElement >> refresh [

	self subclassResponsibility 
]

{ #category : #accessing }
ToSelectHeaderNodeContainerElement >> selectedDataTextField [

	^ self textInputElement selectedDataTextField
]

{ #category : #accessing }
ToSelectHeaderNodeContainerElement >> textInputElement [ 

	^ self subclassResponsibility 
]
