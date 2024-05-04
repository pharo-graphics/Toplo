Class {
	#name : #ToSingleSelectContainerElement,
	#superclass : #ToElementBarContainerElement,
	#instVars : [
		'node'
	],
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #adding }
ToSingleSelectContainerElement >> addFakeNode [

	self addChild: fakeNode
]

{ #category : #initialization }
ToSingleSelectContainerElement >> defaultNodeClass [ 

	^ ToSingleSelectNode
]

{ #category : #accessing }
ToSingleSelectContainerElement >> filterString [ 

	^ self textInputElement filterString
]

{ #category : #accessing }
ToSingleSelectContainerElement >> inputTextField [

	^ self textInputElement inputTextField
]

{ #category : #testing }
ToSingleSelectContainerElement >> isSingleNode [

	^ true
]

{ #category : #accessing }
ToSingleSelectContainerElement >> nodeBuilder [
	" return a valuable that is used to build a bar node element from a data. 
	aValuable take the bar node element to build as first argument 
	and its holder as second argument"

	^ [ :aSelectNode :aNodeHolder |  ]
]

{ #category : #'api - hooks' }
ToSingleSelectContainerElement >> onInstalledIn: anElementBar [

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
ToSingleSelectContainerElement >> onUninstalledIn: anElementBar [

	node onUninstalledIn: anElementBar.
	node removeFromParent.
	node := nil.
	fakeNode onUninstalledIn: anElementBar.
	fakeNode removeFromParent.
	fakeNode := nil.
	super onUninstalledIn: anElementBar.


]

{ #category : #accessing }
ToSingleSelectContainerElement >> refresh [

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
		dataItem: selectedData.
	self refreshInputTextElementWithSelectedData
]

{ #category : #accessing }
ToSingleSelectContainerElement >> refreshInputTextElementWithSelectedData [

	self inputTextField text: ''.
	self selectedDataTextField text:
		(node holder dataItem ifNil: [ '' ] ifNotNil: [ :d | d asString ])
]

{ #category : #accessing }
ToSingleSelectContainerElement >> textInputElement [

	^ node textInputElement
]
