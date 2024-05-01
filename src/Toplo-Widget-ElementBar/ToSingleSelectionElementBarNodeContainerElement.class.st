Class {
	#name : #ToSingleSelectionElementBarNodeContainerElement,
	#superclass : #ToElementBarNodeContainerElement,
	#instVars : [
		'refreshInputTextTask',
		'node'
	],
	#category : #'Toplo-Widget-ElementBar'
}

{ #category : #initialization }
ToSingleSelectionElementBarNodeContainerElement >> defaultNodeBuilder [

	^ [ :aSelectNode :aNodeHolder | ]
]

{ #category : #initialization }
ToSingleSelectionElementBarNodeContainerElement >> defaultNodeClass [ 

	^  ToSingleSelectNode
]

{ #category : #'api - hooks' }
ToSingleSelectionElementBarNodeContainerElement >> onInstalledIn: anElementBar [

	super onInstalledIn: anElementBar.
	self layout: BlFrameLayout new.
	self
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ].
	node := self newNode.
	self nodeBuilder value: node value: node barHolder.
	self addChild: node.
	node onInstalledIn: anElementBar.
	self initializeFakeNode
]

{ #category : #'api - hooks' }
ToSingleSelectionElementBarNodeContainerElement >> onUninstalledIn: anElementBar [

	node onUninstalledIn: anElementBar.
	node removeFromParent.
	refreshInputTextTask ifNotNil: [ anElementBar dequeueTask: refreshInputTextTask ].
	node := nil.
	fakeNode onUninstalledIn: anElementBar.
	fakeNode removeFromParent.
	fakeNode := nil.
	super onUninstalledIn: anElementBar.


]

{ #category : #accessing }
ToSingleSelectionElementBarNodeContainerElement >> refresh [

	| nodeHolder idx selectedData |
	nodeHolder := node barHolder.
	elementBar selectionModel isEmpty
		ifTrue: [
			idx := 0.
			selectedData := nil ]
		ifFalse: [
			idx := elementBar selectionModel firstIndex.
			selectedData := idx <= elementBar dataAccessor size
				                ifTrue: [ elementBar dataAccessor at: idx ]
				                ifFalse: [  ] ].
	nodeHolder
		position: idx;
		data: selectedData.

	self refreshInputTextElementWithSelectedData: selectedData
]

{ #category : #accessing }
ToSingleSelectionElementBarNodeContainerElement >> refreshInputTextElementWithSelectedData: aData [

	elementBar ifNil: [ ^ self ].

	refreshInputTextTask ifNil: [
		refreshInputTextTask := BlTaskAction new action: [
			                        refreshInputTextTask := nil.
			                        self inputTextField text: '' ].
		elementBar enqueueTask: refreshInputTextTask ].
	self selectedDataTextField text:
		(aData ifNil: [ '' ] ifNotNil: [ :d | d asString ])
]

{ #category : #accessing }
ToSingleSelectionElementBarNodeContainerElement >> textInputElement [

	^ node textInputElement
]
