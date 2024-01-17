Class {
	#name : #ToSelectStrategy,
	#superclass : #Object,
	#instVars : [
		'select',
		'headerNodeBuilder',
		'headerNodeClass',
		'headerNodeHolders'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #initialization }
ToSelectStrategy >> buildHeaderNodeContainer: anElement [

	self subclassResponsibility 
]

{ #category : #initialization }
ToSelectStrategy >> defaultHeaderNodeBuilder [ 

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToSelectStrategy >> defaultHeaderNodeClass [ 

	self subclassResponsibility 
]

{ #category : #accessing }
ToSelectStrategy >> headerNodeBuilder [

	" see the mutator method  "
	
	^ headerNodeBuilder 
]

{ #category : #accessing }
ToSelectStrategy >> headerNodeBuilder: aValuable [

	" builds a select node element from list data. 
	aValuable take the select node element to build as first argument 
	and the select node holder as second argument"
	
	headerNodeBuilder := aValuable.
	self initializeFakeNode
]

{ #category : #accessing }
ToSelectStrategy >> headerNodeClass [ 

	^ headerNodeClass 
]

{ #category : #accessing }
ToSelectStrategy >> headerNodeClass: aNodeClass [

	headerNodeClass := aNodeClass.
	self initializeFakeNode
]

{ #category : #'instance creation' }
ToSelectStrategy >> headerNodeContainerLayout [

	^ self subclassResponsibility 
]

{ #category : #'accessing nodes' }
ToSelectStrategy >> headerNodeHolderClass [ 

	^ ToSelectHeaderNodeHolder
]

{ #category : #'accessing nodes' }
ToSelectStrategy >> headerNodeHolders [

	^ headerNodeHolders
]

{ #category : #initialization }
ToSelectStrategy >> initialize [ 

	super initialize.
	headerNodeClass := self defaultHeaderNodeClass.
	headerNodeHolders := OrderedCollection new.
	headerNodeBuilder := self defaultHeaderNodeBuilder.


]

{ #category : #initialization }
ToSelectStrategy >> initializeFakeNode [
	" the fake node is added when no data is selected to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	| fakeHolder fakeNode |
	select fakeNode ifNotNil: [ :fn | fn removeFromParent ].
	fakeNode := self newHeaderNode.
	fakeNode id: #fakeNode.
	fakeHolder := self newHeaderNodeHolder.
	fakeNode selectHolder: fakeHolder.
	fakeHolder
		node: fakeNode;
		data: select fakeData.
	self headerNodeBuilder value: fakeNode value: fakeHolder.
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
ToSelectStrategy >> newHeaderNode [

	^ self headerNodeClass new
]

{ #category : #initialization }
ToSelectStrategy >> newHeaderNodeContainer [

	^ ToElement new
		  id: #nodeContainer;
		  layout: self headerNodeContainerLayout;
		  yourself
]

{ #category : #'accessing nodes' }
ToSelectStrategy >> newHeaderNodeHolder [

	^ self headerNodeHolderClass new
]

{ #category : #'api - hooks' }
ToSelectStrategy >> onInstalledIn: aSelect [

	| nodeContainer |
	select := aSelect.
	" the element that contains nodes + the text field "
	nodeContainer := self newHeaderNodeContainer.
	select headerElement addChild: nodeContainer.
	self buildHeaderNodeContainer: nodeContainer.
	self initializeFakeNode.
]

{ #category : #'accessing list' }
ToSelectStrategy >> onListClosed [

	select mode onListClosed
]

{ #category : #'accessing list' }
ToSelectStrategy >> onListOpened [

	select mode onListOpened
]

{ #category : #'api - hooks' }
ToSelectStrategy >> onUninstalledIn: aSelect [

	select := nil
]

{ #category : #enumerating }
ToSelectStrategy >> refreshHeaderNodeContainer [

	self subclassResponsibility 
]

{ #category : #accessing }
ToSelectStrategy >> select: aSelect [

	select := aSelect
]
