Class {
	#name : #ToSingleSelectionElementBarContainerElement,
	#superclass : #ToElementBarNodeContainerElement,
	#instVars : [
		'node'
	],
	#category : #'Toplo-Widget-ElementBar'
}

{ #category : #adding }
ToSingleSelectionElementBarContainerElement >> addFakeNode [

	self addChild: fakeNode
]

{ #category : #initialization }
ToSingleSelectionElementBarContainerElement >> defaultNodeBuilder [

	^ [ :aSelectNode :aNodeHolder | ]
]

{ #category : #testing }
ToSingleSelectionElementBarContainerElement >> isMultipleSelection [ 

	^ false
]

{ #category : #'api - hooks' }
ToSingleSelectionElementBarContainerElement >> onInstalledIn: anElementBar [

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
ToSingleSelectionElementBarContainerElement >> onUninstalledIn: anElementBar [

	node onUninstalledIn: anElementBar.
	node removeFromParent.
	node := nil.
	fakeNode onUninstalledIn: anElementBar.
	fakeNode removeFromParent.
	fakeNode := nil.
	super onUninstalledIn: anElementBar.


]
