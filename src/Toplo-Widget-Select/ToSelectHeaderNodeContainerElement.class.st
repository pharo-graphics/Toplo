Class {
	#name : #ToSelectHeaderNodeContainerElement,
	#superclass : #ToElement,
	#instVars : [
		'select',
		'fakeNode',
		'headerNodeClass',
		'headerNodeBuilder'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #accessing }
ToSelectHeaderNodeContainerElement >> defaultHeaderNodeBuilder [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToSelectHeaderNodeContainerElement >> defaultHeaderNodeClass [

	^ self subclassResponsibility 
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

	^ ToSelectHeaderNodeHolder
]

{ #category : #initialization }
ToSelectHeaderNodeContainerElement >> initializeFakeNode [
	" the fake node is added when no data is selected to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."
 
	fakeNode ifNotNil: [ :fn |
		fn onUninstalledIn: select.
		fn removeFromParent ].
	fakeNode := self newHeaderNode.
	fakeNode id: #fakeNode.
	fakeNode onInstalledIn: select.
	fakeNode selectHolder
		data: select fakeDataItem.
	self headerNodeBuilder value: fakeNode value: fakeNode selectHolder.
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

	| node holder |
	node := self headerNodeClass new.
	holder := self newHeaderNodeHolder.
	node selectHolder: holder.
	holder
		node: node;
		position: 0;
		select: select;
		data: nil.
		
	^ node
]

{ #category : #initialization }
ToSelectHeaderNodeContainerElement >> newHeaderNodeHolder [

	^ self headerNodeHolderClass new select: select; yourself
]

{ #category : #'api - hooks' }
ToSelectHeaderNodeContainerElement >> onInstalledIn: aSelect [

	self select: aSelect
]

{ #category : #accessing }
ToSelectHeaderNodeContainerElement >> onNodeWrappingChange [ 
]

{ #category : #'api - hooks' }
ToSelectHeaderNodeContainerElement >> onUninstalledIn: aSelect [

	select := nil
]

{ #category : #accessing }
ToSelectHeaderNodeContainerElement >> select: aSelect [

	select := aSelect
]

{ #category : #accessing }
ToSelectHeaderNodeContainerElement >> selectedDataTextField [

	^ self textInputElement selectedDataTextField
]

{ #category : #accessing }
ToSelectHeaderNodeContainerElement >> textInputElement [ 

	^ self subclassResponsibility 
]
