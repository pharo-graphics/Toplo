Class {
	#name : #ToSingleSelectHeaderNodeContainerElement,
	#superclass : #ToSelectHeaderNodeContainerElement,
	#instVars : [
		'headerNode',
		'refreshInputTextTask'
	],
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #initialization }
ToSingleSelectHeaderNodeContainerElement >> defaultHeaderNodeBuilder [

	^ [ :aSelectNode :aNodeHolder | ]
]

{ #category : #initialization }
ToSingleSelectHeaderNodeContainerElement >> defaultHeaderNodeClass [ 

	^  ToSingleSelectHeaderNode
]

{ #category : #'api - hooks' }
ToSingleSelectHeaderNodeContainerElement >> onInstalledIn: aHolder [

	super onInstalledIn: aHolder.
	self layout: BlFrameLayout new.
	self
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ].
	headerNode := self newHeaderNode.
	self headerNodeBuilder value: headerNode value: headerNode headerNodeHolder.
	self addChild: headerNode.
	headerNode onInstalledIn: aHolder.
	self initializeFakeNode
]

{ #category : #'api - hooks' }
ToSingleSelectHeaderNodeContainerElement >> onUninstalledIn: aHolder [

	headerNode onUninstalledIn: aHolder.
	headerNode removeFromParent.
	refreshInputTextTask ifNotNil: [ aHolder dequeueTask: refreshInputTextTask ].
	headerNode := nil.
	fakeNode onUninstalledIn: aHolder.
	fakeNode removeFromParent.
	fakeNode := nil.
	super onUninstalledIn: aHolder.


]

{ #category : #accessing }
ToSingleSelectHeaderNodeContainerElement >> refresh [

	| node nodeHolder idx selectedData |
	node := self firstChild.
	nodeHolder := node headerNodeHolder.
	holder selectionModel isEmpty
		ifTrue: [
			idx := 0.
			selectedData := nil ]
		ifFalse: [
			idx := holder selectionModel firstIndex.
			selectedData := idx <= holder dataAccessor size ifTrue: [holder dataAccessor at: idx ] ifFalse: [] ].

	nodeHolder
		position: idx;
		data: selectedData.

	self refreshInputTextElementWithSelectedData: selectedData
]

{ #category : #accessing }
ToSingleSelectHeaderNodeContainerElement >> refreshInputTextElementWithSelectedData: aData [

	holder ifNil: [ ^ self ].

	refreshInputTextTask ifNil: [
		refreshInputTextTask := BlTaskAction new action: [
			                        refreshInputTextTask := nil.
			                        self inputTextField text: '' ].
		holder enqueueTask: refreshInputTextTask ].
	self selectedDataTextField text:
		(aData ifNil: [ '' ] ifNotNil: [ :d | d asString ])
]

{ #category : #accessing }
ToSingleSelectHeaderNodeContainerElement >> textInputElement [

	^ headerNode textInputElement
]
