Class {
	#name : #ToSelectStrategy,
	#superclass : #Object,
	#instVars : [
		'select',
		'headerNodeBuilder',
		'headerNodeClass',
		'installedSelectionModeShortcuts'
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

	" lazy because asking for it may require the mode to be set "
	^ headerNodeClass ifNil: [ 	headerNodeClass := self defaultHeaderNodeClass ]
]

{ #category : #accessing }
ToSelectStrategy >> headerNodeClass: aNodeClass [

	headerNodeClass := aNodeClass.
	self initializeFakeNode
]

{ #category : #private }
ToSelectStrategy >> headerNodeContainerLayout [

	^ self subclassResponsibility 
]

{ #category : #'accessing nodes' }
ToSelectStrategy >> headerNodeHolderClass [ 

	^ ToSelectHeaderNodeHolder
]

{ #category : #initialization }
ToSelectStrategy >> initialize [ 

	super initialize.
	headerNodeBuilder := self defaultHeaderNodeBuilder.


]

{ #category : #initialization }
ToSelectStrategy >> initializeFakeNode [
	" the fake node is added when no data is selected to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	| fakeHolder fakeNode |
	select fakeNode ifNotNil: [ :fn |
		fn onUninstalledIn: select headerNodeContainer.
		fn removeFromParent ].
	fakeNode := self newHeaderNode.
	fakeNode id: #fakeNode.
	fakeHolder := self newHeaderNodeHolder.
	fakeNode selectHolder: fakeHolder.
	fakeNode onInstalledIn: select.
	fakeHolder
		node: fakeNode;
		data: select fakeDataItem.
	self headerNodeBuilder value: fakeNode value: fakeHolder.
	fakeNode width: 0.
	fakeNode constraintsDo: [ :c |
		c flow vertical alignCenter.
		c linear vertical alignCenter ].
	" add the fake node if the selection is empty (to keep a constant minimum height )"
	select headerNodeContainer addChild: fakeNode
]

{ #category : #accessing }
ToSelectStrategy >> inputTextField [

	^ self textInputElement inputTextField
]

{ #category : #testing }
ToSelectStrategy >> isMultipleSelection [

	^ false
]

{ #category : #'accessing nodes' }
ToSelectStrategy >> newHeaderNode [

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
ToSelectStrategy >> newHeaderNodeContainer [

	^ ToElement new
		  id: #headerNodeContainer;
		  layout: self headerNodeContainerLayout;
		  yourself
]

{ #category : #'accessing nodes' }
ToSelectStrategy >> newHeaderNodeHolder [

	^ self headerNodeHolderClass new select: select; yourself
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
	self refreshHeaderNodeContainer.
	aSelect listElement selectionMode selectOnMouseDown: true.
	aSelect listElement selectionMode requestFocusOnMouseDown: false.
	installedSelectionModeShortcuts := select listElement
		                                   secondarySelectionMode
		                                   shortcutsIn: self.
	aSelect isFiltrable
		ifTrue: [
			installedSelectionModeShortcuts do: [ :s |
				self inputTextField addEditorShortcut: s ] ]
		ifFalse: [
		installedSelectionModeShortcuts do: [ :s | select addShortcut: s ] ]
]

{ #category : #'api - hooks' }
ToSelectStrategy >> onUninstalledIn: aSelect [


	aSelect isFiltrable 
		ifTrue: [ installedSelectionModeShortcuts do: [ :s | self inputTextField removeEditorShortcut: s ] ] 
		ifFalse: [ installedSelectionModeShortcuts do: [ :s | select removeShortcut: s ] ].
	select headerElement removeChild: select headerNodeContainer.

	select := nil
]

{ #category : #window }
ToSelectStrategy >> onWindowClosed [

	self textInputElement onWindowClosed
]

{ #category : #window }
ToSelectStrategy >> onWindowOpened [

	self textInputElement onWindowOpened
]

{ #category : #'api - hooks' }
ToSelectStrategy >> reInstall [

	| s |
	s := select.
	self onUninstalledIn: s.
	self onInstalledIn: s
]

{ #category : #private }
ToSelectStrategy >> refreshHeaderNodeContainer [

	self subclassResponsibility 
]

{ #category : #accessing }
ToSelectStrategy >> select: aSelect [

	select := aSelect
]

{ #category : #accessing }
ToSelectStrategy >> selectedDataTextField [

	^ self textInputElement selectedDataTextField
]

{ #category : #accessing }
ToSelectStrategy >> textInputElement [

	^ self subclassResponsibility 
]
