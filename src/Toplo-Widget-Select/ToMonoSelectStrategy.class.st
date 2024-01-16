Class {
	#name : #ToMonoSelectStrategy,
	#superclass : #ToSelectStrategy,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #adding }
ToMonoSelectStrategy >> addDataNode: aNode [

	select nodeContainer addChild: aNode 
]

{ #category : #initialization }
ToMonoSelectStrategy >> buildNodeContainer: anElement [

	anElement
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ].
	select mode configureMonoSelectNodeContainer: anElement

]

{ #category : #initialization }
ToMonoSelectStrategy >> defaultNodeBuilder [

	^ [ :aSelectNode :aNodeHolder |
	  | textField |
	  aSelectNode beUnremovable.
	  aSelectNode hMatchParent.
	  textField := select mode newTextField.
	  textField text: aNodeHolder data asString.
	  textField withoutLineWrapping.
	  aSelectNode middleContainer addChild: textField ]
]

{ #category : #initialization }
ToMonoSelectStrategy >> defaultNodeClass [ 

	^ ToMonoSelectNode
]

{ #category : #'instance creation' }
ToMonoSelectStrategy >> nodeContainerLayout [

	^ BlFrameLayout new
]

{ #category : #'api - hooks' }
ToMonoSelectStrategy >> onInstalledIn: aSelect [

	super onInstalledIn: aSelect.
	aSelect listElement selectionStrategy beSingleSelection
]

{ #category : #enumerating }
ToMonoSelectStrategy >> refreshNodeContainer [

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
	nodes ifEmpty: [ ^ self ].
	self addDataNode: nodes first
]
