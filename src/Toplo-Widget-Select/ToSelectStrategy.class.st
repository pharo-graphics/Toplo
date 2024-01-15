Class {
	#name : #ToSelectStrategy,
	#superclass : #Object,
	#instVars : [
		'nodeClass',
		'select',
		'nodeBuilder'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #initialization }
ToSelectStrategy >> defaultNodeBuilder [

	self subclassResponsibility 
]

{ #category : #initialization }
ToSelectStrategy >> defaultNodeClass [ 

	^ ToSelectNode
]

{ #category : #initialization }
ToSelectStrategy >> initialize [ 

	super initialize.
	nodeClass := self defaultNodeClass.
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

{ #category : #initialization }
ToSelectStrategy >> newNode [ 

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToSelectStrategy >> newNodeContainer [

	^ ToElement new  id: #nodeContainer;
		             layout: self newNodeContainerLayout; yourself
]

{ #category : #'instance creation' }
ToSelectStrategy >> newNodeContainerLayout [

	^ self subclassResponsibility 
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

{ #category : #'accessing nodes' }
ToSelectStrategy >> nodeHolderClass [ 

	^ ToSelectNodeHolder
]

{ #category : #'api - hooks' }
ToSelectStrategy >> onInstalledIn: aSelect [

	select := aSelect
]

{ #category : #'api - hooks' }
ToSelectStrategy >> onUninstalledIn: aSelect [

	select := nil
]

{ #category : #accessing }
ToSelectStrategy >> select: aSelect [

	select := aSelect
]
