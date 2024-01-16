Class {
	#name : #ToSelectStrategy,
	#superclass : #Object,
	#instVars : [
		'nodeClass',
		'select',
		'nodeHolders',
		'nodeBuilder'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #initialization }
ToSelectStrategy >> buildNodeContainer: anElement [

	self subclassResponsibility 
]

{ #category : #'accessing nodes' }
ToSelectStrategy >> dataNodesDo: aBlock [

	self nodeHolders do: [ :holder |	aBlock value: holder node ].
]

{ #category : #initialization }
ToSelectStrategy >> defaultNodeBuilder [ 

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToSelectStrategy >> defaultNodeClass [ 

	self subclassResponsibility 
]

{ #category : #initialization }
ToSelectStrategy >> initialize [ 

	super initialize.
	nodeClass := self defaultNodeClass.
	nodeHolders := OrderedCollection new.
	nodeBuilder := self defaultNodeBuilder.


]

{ #category : #initialization }
ToSelectStrategy >> initializeFakeNode [
	" the fake node is added when no data is selected to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	| fakeHolder fakeNode |
	select fakeNode ifNotNil: [ :fn | fn removeFromParent ].
	fakeNode := self newNode.
	fakeNode id: #fakeNode.
	fakeHolder := self newNodeHolder.
	fakeNode selectHolder: fakeHolder.
	fakeHolder
		node: fakeNode;
		data: select fakeData.
	self nodeBuilder value: fakeNode value: fakeHolder.
	fakeNode width: 0.
	fakeNode constraintsDo: [ :c |
		c flow vertical alignCenter.
		c linear vertical alignCenter ].
	" add the fake node if the selection is empty (to keep a constant minimum height )"
	select nodeContainer addChild: fakeNode
]

{ #category : #testing }
ToSelectStrategy >> isMultiSelection [

	^ false
]

{ #category : #accessing }
ToSelectStrategy >> maxCount [ 

	^ Error signal: 'Not applicable feature'
]

{ #category : #accessing }
ToSelectStrategy >> maxCount: aNumber [

	^ Error signal: 'Not applicable feature'
]

{ #category : #'accessing nodes' }
ToSelectStrategy >> newNode [

	^ self nodeClass new
]

{ #category : #initialization }
ToSelectStrategy >> newNodeContainer [

	^ ToElement new
		  id: #nodeContainer;
		  layout: self nodeContainerLayout;
		  yourself
]

{ #category : #'accessing nodes' }
ToSelectStrategy >> newNodeHolder [

	^ self nodeHolderClass new
]

{ #category : #accessing }
ToSelectStrategy >> nodeBuilder [

	" see the mutator method  "
	
	^ nodeBuilder 
]

{ #category : #accessing }
ToSelectStrategy >> nodeBuilder: aValuable [

	" builds a select node element from list data. 
	aValuable take the select node element to build as first argument 
	and the select node holder as second argument"
	
	nodeBuilder := aValuable.
	self initializeFakeNode
]

{ #category : #accessing }
ToSelectStrategy >> nodeClass [ 

	^ nodeClass 
]

{ #category : #accessing }
ToSelectStrategy >> nodeClass: aNodeClass [

	nodeClass := aNodeClass.
	self initializeFakeNode
]

{ #category : #'instance creation' }
ToSelectStrategy >> nodeContainerLayout [

	^ self subclassResponsibility 
]

{ #category : #'accessing nodes' }
ToSelectStrategy >> nodeHolderClass [ 

	^ ToSelectNodeHolder
]

{ #category : #'accessing nodes' }
ToSelectStrategy >> nodeHolders [

	^ nodeHolders
]

{ #category : #'api - hooks' }
ToSelectStrategy >> onInstalledIn: aSelect [

	| nodeContainer |
	select := aSelect.
	" the element that contains nodes + the text field "
	nodeContainer := self newNodeContainer.
	select contentElement addChild: nodeContainer.
	self buildNodeContainer: nodeContainer.
	self initializeFakeNode.
]

{ #category : #'api - hooks' }
ToSelectStrategy >> onUninstalledIn: aSelect [

	select := nil
]

{ #category : #enumerating }
ToSelectStrategy >> refreshNodeContainer [

	self subclassResponsibility 
]

{ #category : #accessing }
ToSelectStrategy >> select: aSelect [

	select := aSelect
]
