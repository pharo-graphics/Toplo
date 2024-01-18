Class {
	#name : #ToMonoSelectStrategy,
	#superclass : #ToSelectStrategy,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #adding }
ToMonoSelectStrategy >> addDataNode: aNode [

	select headerNodeContainer addChild: aNode.
	aNode onInstalledIn: select headerNodeContainer
]

{ #category : #initialization }
ToMonoSelectStrategy >> buildHeaderNodeContainer: anElement [

	| node holder |
	anElement
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ].
	select mode configureMonoSelectNodeContainer: anElement.
	node := self newHeaderNode.
	holder := self newHeaderNodeHolder.
	node selectHolder: holder.
	self headerNodeHolders add: holder.
	holder
		node: node;
		position: 0;
		select: select;
		data: nil.
	self headerNodeBuilder value: node value: holder.
	self addDataNode: node
]

{ #category : #initialization }
ToMonoSelectStrategy >> defaultHeaderNodeBuilder [

	^ [ :aSelectNode :aNodeHolder |	  
	  aNodeHolder data ifNotNil: [
		  aSelectNode selectedDataTextField text: aNodeHolder data asString ] ]
]

{ #category : #initialization }
ToMonoSelectStrategy >> defaultHeaderNodeClass [ 

	^ select mode defaultMonoSelectHeaderNodeClass
]

{ #category : #private }
ToMonoSelectStrategy >> filterTextFieldUpdated: anEvent [

	super filterTextFieldUpdated: anEvent.
	select inputTextField text
		ifEmpty: [
		self selectedDataTextField text foreground: Color lightGray ]
		ifNotEmpty: [
		self selectedDataTextField visibility: BlVisibility hidden ]
]

{ #category : #'instance creation' }
ToMonoSelectStrategy >> headerNodeContainerLayout [

	^ BlFrameLayout new
]

{ #category : #'accessing list' }
ToMonoSelectStrategy >> onListClosed [

	super onListOpened.
	self selectedDataTextField text foreground: Color black
]

{ #category : #'accessing list' }
ToMonoSelectStrategy >> onListOpened [

	super onListOpened.
	self selectedDataTextField text foreground: Color lightGray
]

{ #category : #enumerating }
ToMonoSelectStrategy >> refreshHeaderNodeContainer [

	| node holder idx selectedData |
	node := select headerNodeContainer firstChild.
	holder := node selectHolder.

	holder position isZero ifFalse: [ " directly deselection in the selection model works.
		using the listElement selectionStrategy do not works because of the shared event distributor.
		Indeed, this method is invoked from the event handler added in ToSelectReadOnlyMode>>onInstalledIn: "
		self flag: 'use-case to fix ToListElement event handling'.
		select isFiltrable
			ifTrue: [ select mode deselectIndex: holder position ]
			ifFalse: [ select selectionModel deselectIndex: holder position ].
		select listElement dispatchEvent: ToInfiniteSelectionDirtyEvent new ].

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
	select closeWindow.
	self selectedDataTextField visibility: BlVisibility visible.
	select inputTextField text: ''.
	selectedData
		ifNil: [ self selectedDataTextField text: '' ]
		ifNotNil: [ self selectedDataTextField text: selectedData asString ]
]

{ #category : #accessing }
ToMonoSelectStrategy >> selectedDataTextField [

	^ select headerNodeContainer childWithId: #selectedDataTextField 
]
