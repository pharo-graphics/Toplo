Class {
	#name : #ToSingleSelectStrategy,
	#superclass : #ToSelectStrategy,
	#instVars : [
		'headerNode'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #initialization }
ToSingleSelectStrategy >> buildHeaderNodeContainer: anElement [

	anElement
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ].
	headerNode := self newHeaderNode.
	self headerNodeBuilder value: headerNode value: headerNode selectHolder.
	anElement addChild: headerNode.
	headerNode onInstalledIn: select
]

{ #category : #initialization }
ToSingleSelectStrategy >> defaultHeaderNodeBuilder [

	^ [ :aSelectNode :aNodeHolder |
	  self textInputElement ifNotNil: [ :ti |
		  ti onSingleSelectDataChanged ] ]
]

{ #category : #initialization }
ToSingleSelectStrategy >> defaultHeaderNodeClass [ 

	^ select mode defaultMonoSelectHeaderNodeClass
]

{ #category : #'instance creation' }
ToSingleSelectStrategy >> headerNodeContainerLayout [

	^ BlFrameLayout new
]

{ #category : #'api - hooks' }
ToSingleSelectStrategy >> onUninstalledIn: aSelect [

	headerNode onUninstalledIn: aSelect.
	headerNode removeFromParent.
	headerNode := nil.
	super onUninstalledIn: aSelect

]

{ #category : #private }
ToSingleSelectStrategy >> refreshHeaderNodeContainer [

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
	self textInputElement onSingleSelectDataChanged
]

{ #category : #accessing }
ToSingleSelectStrategy >> textInputElement [

	^ headerNode textInputElement
]
