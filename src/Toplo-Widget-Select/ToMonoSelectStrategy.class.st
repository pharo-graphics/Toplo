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

	| node holder |
	anElement
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ].
	select mode configureMonoSelectNodeContainer: anElement.
	node := self newNode.
	holder := self newNodeHolder.
	node selectHolder: holder.
	self nodeHolders add: holder.
	holder
		node: node;
		position: 0;
		select: select;
		data: nil.
	self nodeBuilder value: node value: holder.
	self addDataNode: node
]

{ #category : #initialization }
ToMonoSelectStrategy >> defaultNodeBuilder [

	^ [ :aSelectNode :aNodeHolder |
	  | inputTextField selectedDataTextField |
	  aSelectNode beUnremovable.
	  aSelectNode hMatchParent.
	  selectedDataTextField := select mode newTextField.
	  selectedDataTextField beReadonlyWithSelection.
	  selectedDataTextField withLineWrapping.
	  selectedDataTextField hMatchParent.
	  inputTextField := select mode newInputTextField.
	  aNodeHolder data ifNotNil: [
		  selectedDataTextField text: aNodeHolder data asString ].
	  inputTextField withLineWrapping.
	  inputTextField hMatchParent.
	  " the id is set here to avoid that a fake node with a text field with the same id "
	  selectedDataTextField id: #selectedDataTextField.
	  aSelectNode middleContainer addChild: selectedDataTextField.
	  aSelectNode middleContainer addChild: inputTextField ]
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

]

{ #category : #enumerating }
ToMonoSelectStrategy >> refreshNodeContainer [

	| node holder idx selectedData |
	node := select nodeContainer firstChild.
	holder := node selectHolder.

	holder position isZero ifFalse: [ 
		" directly deselection in the selection model works.
		using the listElement selectionStrategy do not works because of the shared event distributor.
		Indeed, this method is invoked from the event handler added in ToSelectReadOnlyMode>>onInstalledIn: ".
		self flag: 'used case to fix ToListElement event handling'. 
		select selectionModel deselectIndex: holder position.
		select listElement dispatchEvent: ToInfiniteSelectionDirtyEvent new 
		"select listElement selectionStrategy deselectIndex: holder position" ].

	select selectionModel indices
		ifEmpty: [
			idx := 0.
			selectedData := nil ]
		ifNotEmpty: [ :idxes |
			idx := idxes first.
			selectedData := select data at: idx ].

	holder
		position: idx;
		data: selectedData.
	select inputTextField text: ''.
	selectedData
		ifNil: [ self selectedDataTextField text: '' ]
		ifNotNil: [ self selectedDataTextField text: selectedData asString ]
]

{ #category : #accessing }
ToMonoSelectStrategy >> selectedDataTextField [

	^ select nodeContainer childWithId: #selectedDataTextField 
]
