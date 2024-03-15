Class {
	#name : #ToSingleSelectHeaderNodeContainerElement,
	#superclass : #ToSelectHeaderNodeContainerElement,
	#instVars : [
		'headerNode',
		'refreshInputTextTask'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #accessing }
ToSingleSelectHeaderNodeContainerElement >> defaultHeaderNodeBuilder [

	^ [ :aSelectNode :aNodeHolder | ]
]

{ #category : #accessing }
ToSingleSelectHeaderNodeContainerElement >> defaultHeaderNodeClass [ 

	^  ToSingleSelectHeaderNode
]

{ #category : #'api - hooks' }
ToSingleSelectHeaderNodeContainerElement >> onInstalledIn: aSelect [

	super onInstalledIn: aSelect.
	self layout: BlFrameLayout new.
	self
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ].
	headerNode := self newHeaderNode.
	self headerNodeBuilder value: headerNode value: headerNode selectHolder.
	self addChild: headerNode.
	headerNode onInstalledIn: select.
	self initializeFakeNode
]

{ #category : #'api - hooks' }
ToSingleSelectHeaderNodeContainerElement >> onUninstalledIn: aSelect [

	headerNode onUninstalledIn: aSelect.
	headerNode removeFromParent.
	refreshInputTextTask ifNotNil: [ select dequeueTask: refreshInputTextTask ].
	headerNode := nil.
	fakeNode onUninstalledIn: select.
	fakeNode removeFromParent.
	fakeNode := nil.
	super onUninstalledIn: aSelect.


]

{ #category : #accessing }
ToSingleSelectHeaderNodeContainerElement >> refresh [

	| node holder idx selectedData |
	node := self firstChild.
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

{ #category : #accessing }
ToSingleSelectHeaderNodeContainerElement >> refreshInputTextElementWithSelectedData: aData [

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
ToSingleSelectHeaderNodeContainerElement >> textInputElement [

	^ headerNode textInputElement
]
