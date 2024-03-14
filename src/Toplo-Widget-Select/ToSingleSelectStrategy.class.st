Class {
	#name : #ToSingleSelectStrategy,
	#superclass : #ToSelectStrategy,
	#instVars : [
		'refreshInputTextTask'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #initialization }
ToSingleSelectStrategy >> buildHeaderNodeContainer: anElement [

	anElement
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ].
	headerNode := select headerNodeContainer newHeaderNode.
	self headerNodeBuilder value: headerNode value: headerNode selectHolder.
	anElement addChild: headerNode.
	headerNode onInstalledIn: select
]

{ #category : #accessing }
ToSingleSelectStrategy >> headerNodeContainerClass [

	^ ToSingleSelectHeaderNodeContainerElement
]

{ #category : #private }
ToSingleSelectStrategy >> headerNodeContainerLayout [

	^ BlFrameLayout new
]

{ #category : #'api - hooks' }
ToSingleSelectStrategy >> onInstalledIn: aSelect [

	aSelect listElement selectionMode:
		(ToListSingleSelectionMode new operator:
			 (ToPrimarySelectionModelOperator new selectionModel: aSelect listElement selectionModel)).
	super onInstalledIn: aSelect
]

{ #category : #'api - hooks' }
ToSingleSelectStrategy >> onUninstalledIn: aSelect [

	"headerNode onUninstalledIn: aSelect.
	headerNode removeFromParent."
	refreshInputTextTask ifNotNil: [ select dequeueTask: refreshInputTextTask ].
	super onUninstalledIn: aSelect.
	"headerNode := nil."


]

{ #category : #private }
ToSingleSelectStrategy >> refreshHeaderNodeContainer [

	| node holder idx selectedData |
	node := select headerNodeContainer firstChild.
	holder := node selectHolder.
	select selectionModel isEmpty
		ifTrue: [
			idx := 0.
			selectedData := nil ]
		ifFalse: [
			idx := select selectionModel firstIndex.
			selectedData := idx <= select dataAccessor size ifTrue: [select dataAccessor at: idx ] ifFalse: [] ].

	holder
		position: idx;
		data: selectedData.

	self refreshInputTextElementWithSelectedData: selectedData
]

{ #category : #private }
ToSingleSelectStrategy >> refreshInputTextElementWithSelectedData: aData [

	select ifNil: [ ^ self ].

	refreshInputTextTask ifNil: [
		refreshInputTextTask := BlTaskAction new action: [
			                        refreshInputTextTask := nil.
			                        self inputTextField text: '' ].
		select enqueueTask: refreshInputTextTask ].
	self selectedDataTextField text:
		(aData ifNil: [ '' ] ifNotNil: [ :d | d asString ])
]

{ #category : #accessing }
ToSingleSelectStrategy >> textInputElement [

	^ select headerNodeContainer textInputElement
]
