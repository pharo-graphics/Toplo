Class {
	#name : #ToSingleSelectionElementBarNodeContainerElement,
	#superclass : #ToElementBarNodeContainerElement,
	#instVars : [
		'node'
	],
	#category : #'Toplo-Widget-ElementBar'
}

{ #category : #adding }
ToSingleSelectionElementBarNodeContainerElement >> addFakeNode [

	self addChild: fakeNode
]

{ #category : #initialization }
ToSingleSelectionElementBarNodeContainerElement >> defaultNodeBuilder [

	^ [ :aSelectNode :aNodeHolder | ]
]

{ #category : #testing }
ToSingleSelectionElementBarNodeContainerElement >> isMultipleSelection [ 

	^ false
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
	self nodeBuilder value: node value: node holder.
	self addChild: node.
	self installFakeNode
]

{ #category : #'api - hooks' }
ToSingleSelectionElementBarNodeContainerElement >> onUninstalledIn: anElementBar [

	node onUninstalledIn: anElementBar.
	node removeFromParent.
	node := nil.
	fakeNode onUninstalledIn: anElementBar.
	fakeNode removeFromParent.
	fakeNode := nil.
	super onUninstalledIn: anElementBar.


]

{ #category : #accessing }
ToSingleSelectionElementBarNodeContainerElement >> refresh [

	| nodeHolder idx selectedData |
	nodeHolder := node holder.
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
		dataItem: selectedData
]
