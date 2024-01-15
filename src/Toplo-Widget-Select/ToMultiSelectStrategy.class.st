Class {
	#name : #ToMultiSelectStrategy,
	#superclass : #ToSelectStrategy,
	#instVars : [
		'nodeWrapping',
		'nodeHolders'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'accessing nodes' }
ToMultiSelectStrategy >> addAllDataNodes: aNodeCollection [

	aNodeCollection do: [ :n | self addDataNode: n ]
]

{ #category : #'accessing nodes' }
ToMultiSelectStrategy >> addDataNode: aNode [

	select nodeContainer addChild: aNode before: select textField
]

{ #category : #initialization }
ToMultiSelectStrategy >> buildNodeContainer: anElement [

	| textField |
	anElement
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ].
	" for the text field for the select input (whatever the mode for simplification) "
	textField := select newTextField.
	anElement addChild: textField.
	" In case of read-only mode, the textfield is set as read-only by the mode "
	select mode configureMultiSelectNodeContainer: anElement
]

{ #category : #'accessing nodes' }
ToMultiSelectStrategy >> dataNodesDo: aBlock [

	self nodeHolders do: [ :holder |	aBlock value: holder node ].
]

{ #category : #initialization }
ToMultiSelectStrategy >> defaultNodeBuilder [

	^ [ :aSelectNode :aNodeHolder |
	  aSelectNode beRemovable.
	  aSelectNode middleContainer addChild:
		  (ToLabel text: aNodeHolder data asString) ]
]

{ #category : #initialization }
ToMultiSelectStrategy >> defaultNodeWrapping [

	^ true
]

{ #category : #initialization }
ToMultiSelectStrategy >> initialize [

	super initialize.
	nodeHolders := OrderedCollection new.
	nodeWrapping := self defaultNodeWrapping.

	
]

{ #category : #testing }
ToMultiSelectStrategy >> isMultiSelection [

	^ true
]

{ #category : #'accessing nodes' }
ToMultiSelectStrategy >> newNode [

	^ self nodeClass new
]

{ #category : #private }
ToMultiSelectStrategy >> nodeContainerLayout [

	^ nodeWrapping
		ifTrue: [ BlFlowLayout horizontal ]
		ifFalse: [ BlLinearLayout horizontal ]
]

{ #category : #'accessing nodes' }
ToMultiSelectStrategy >> nodeHolders [

	^ nodeHolders
]

{ #category : #accessing }
ToMultiSelectStrategy >> nodeWrapping [

	^ nodeWrapping 
]

{ #category : #accessing }
ToMultiSelectStrategy >> nodeWrapping: aBoolean [

	nodeWrapping = aBoolean ifTrue: [ ^ self ].
	nodeWrapping := aBoolean.
	self onNodeWrappingChange.
]

{ #category : #'api - hooks' }
ToMultiSelectStrategy >> onInstalledIn: aSelect [

	super onInstalledIn: aSelect
]

{ #category : #private }
ToMultiSelectStrategy >> onNodeWrappingChange [

	select nodeContainer layout: self nodeContainerLayout
]

{ #category : #'api - hooks' }
ToMultiSelectStrategy >> onUninstalledIn: aSelect [

	super onUninstalledIn: aSelect
]

{ #category : #enumerating }
ToMultiSelectStrategy >> refreshNodeContainer [

	| nodes |

	" first remove all data nodes "
	self dataNodesDo: [ :node | node removeFromParent ].
	self nodeHolders reset.
	" then rebuild current nodes according to current selection "
	nodes := select selectionModel indices collect: [ :idx |
		         | node holder selectedData |
		         node := self newNode.
		         holder := self newNodeHolder.
		         node selectHolder: holder.
		         self nodeHolders add: holder.
		         selectedData := select data at: idx.
		         holder
			         node: node;
			         position: idx;
			         select: select;
			         data: selectedData.
		         self nodeBuilder value: node value: holder.
		         node ].
	self addAllDataNodes: nodes
]
