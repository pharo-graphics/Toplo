Class {
	#name : #ToElementBarNodeContainerElement,
	#superclass : #ToElement,
	#instVars : [
		'fakeNode',
		'fakeDataItem',
		'elementBar',
		'nodeBuilder',
		'nodeClass'
	],
	#category : #'Toplo-Widget-ElementBar'
}

{ #category : #adding }
ToElementBarNodeContainerElement >> addFakeNode [

	self subclassResponsibility 
]

{ #category : #initialization }
ToElementBarNodeContainerElement >> defaultNodeBuilder [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToElementBarNodeContainerElement >> defaultNodeClass [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToElementBarNodeContainerElement >> fakeDataItem: aData [

	fakeDataItem := aData.
	self installFakeNode 
]

{ #category : #initialization }
ToElementBarNodeContainerElement >> installFakeNode [
	" the fake node is added when no data is selected to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."
 
	fakeNode ifNotNil: [ :fn |
		fn onUninstalledIn: self.
		fn removeFromParent ].

	fakeNode := self newNode.
	fakeNode id: #fakeNode.
	fakeNode onInstalledIn: elementBar.
	fakeNode barHolder
		data: fakeDataItem.

	self nodeBuilder value: fakeNode value: fakeNode barHolder.
	fakeNode width: 0.
	fakeNode margin: BlInsets empty.
	fakeNode constraintsDo: [ :c |
		c flow vertical alignCenter.
		c linear vertical alignCenter ].
	" add the fake node (to keep a constant minimum height )"
	self addFakeNode
]

{ #category : #initialization }
ToElementBarNodeContainerElement >> newNode [

	| node nodeHolder |
	node := self nodeClass new.
	nodeHolder := self newNodeHolder.
	node barHolder: nodeHolder.
	nodeHolder
		node: node;
		position: 0;
		elementBar: elementBar;
		data: nil.
		
	^ node
]

{ #category : #initialization }
ToElementBarNodeContainerElement >> newNodeHolder [

	^ self nodeHolderClass new elementBar: elementBar; yourself
]

{ #category : #accessing }
ToElementBarNodeContainerElement >> nodeBuilder [

	" see the mutator method  "
	
	^ nodeBuilder ifNil: [ nodeBuilder := self defaultNodeBuilder ]
]

{ #category : #accessing }
ToElementBarNodeContainerElement >> nodeBuilder: aValuable [

	" builds a select node element from list data. 
	aValuable take the select node element to build as first argument 
	and the select node holder as second argument"
	
	nodeBuilder := aValuable.
	self installFakeNode
]

{ #category : #accessing }
ToElementBarNodeContainerElement >> nodeClass [ 

	^ nodeClass ifNil: [ 	nodeClass := self defaultNodeClass ]
]

{ #category : #accessing }
ToElementBarNodeContainerElement >> nodeClass: aNodeClass [

	nodeClass := aNodeClass.
	self installFakeNode
]

{ #category : #initialization }
ToElementBarNodeContainerElement >> nodeHolderClass [ 

	^ ToSimpleElementBarNodeHolder
]

{ #category : #accessing }
ToElementBarNodeContainerElement >> nodeScrolling: aBoolean [

]

{ #category : #accessing }
ToElementBarNodeContainerElement >> nodeWrapping: aBoolean [

]

{ #category : #'api - hooks' }
ToElementBarNodeContainerElement >> onInstalledIn: anElementBar [

	elementBar := anElementBar
]

{ #category : #'api - hooks' }
ToElementBarNodeContainerElement >> onUninstalledIn: anElementBar [

	elementBar := nil
]

{ #category : #window }
ToElementBarNodeContainerElement >> onWindowClosed [

	self textInputElement onWindowClosed
]

{ #category : #window }
ToElementBarNodeContainerElement >> onWindowOpened [

	self textInputElement onWindowOpened
]

{ #category : #accessing }
ToElementBarNodeContainerElement >> refresh [

	self subclassResponsibility 
]

{ #category : #accessing }
ToElementBarNodeContainerElement >> selectedDataTextField [

	^ self textInputElement selectedDataTextField
]
