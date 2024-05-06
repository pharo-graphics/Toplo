Class {
	#name : #ToElementBarContainerElement,
	#superclass : #ToElement,
	#traits : 'TToOrientable',
	#classTraits : 'TToOrientable classTrait',
	#instVars : [
		'fakeNode',
		'fakeDataItem',
		'elementBar',
		'innerNodeContainer'
	],
	#category : #'Toplo-Widget-ElementBar'
}

{ #category : #adding }
ToElementBarContainerElement >> addFakeNode [

	innerNodeContainer addChild: fakeNode
]

{ #category : #initialization }
ToElementBarContainerElement >> defaultLayout [

	^ BlLinearLayout new
]

{ #category : #initialization }
ToElementBarContainerElement >> defaultNodeClass [

	^ ToElementBarNode
]

{ #category : #accessing }
ToElementBarContainerElement >> elementBar [

	^ elementBar
]

{ #category : #accessing }
ToElementBarContainerElement >> fakeDataItem: aData [

	fakeDataItem := aData.
	self installFakeNode 
]

{ #category : #initialization }
ToElementBarContainerElement >> installFakeNode [
	" the fake node is added when no data is selected to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	fakeNode ifNotNil: [ :fn |
		fn onUninstalledIn: self.
		fn removeFromParent ].

	fakeNode := self newNode.
	fakeNode id: #fakeNode.
	fakeNode holder dataItem: fakeDataItem.
	self nodeBuilder value: fakeNode value: fakeNode holder.
	self isHorizontal
		ifTrue: [
			fakeNode width: 0.
			fakeNode constraintsDo: [ :c |
				c vertical matchParent.
				c flow vertical alignCenter.
				c linear vertical alignCenter ] ]
		ifFalse: [
			fakeNode height: 0.
			fakeNode constraintsDo: [ :c |
				c horizontal matchParent.
				c flow horizontal alignCenter.
				c linear horizontal alignCenter ] ].

	fakeNode margin: BlInsets empty.

	" add the fake node (to keep a constant minimum height )"
	self addFakeNode
]

{ #category : #'t - orientable - accessing' }
ToElementBarContainerElement >> layoutStrategy [

	^ self layout

	
]

{ #category : #initialization }
ToElementBarContainerElement >> newNode [

	| node nodeHolder |
	node := self nodeClass new.
	nodeHolder := self newNodeHolder.
	node holder: nodeHolder.
	nodeHolder
		node: node;
		position: 0;
		elementBar: elementBar;
		dataItem: nil.
	node onInstalledIn: self.
		
	^ node
]

{ #category : #initialization }
ToElementBarContainerElement >> newNodeHolder [

	^ self nodeHolderClass new elementBar: elementBar; yourself
]

{ #category : #accessing }
ToElementBarContainerElement >> nodeBuilder [
	
	" return a valuable that is used to build a bar node element from a data. 
	aValuable take the bar node element to build as first argument 
	and its holder as second argument"

	^ [ :aBarNode :aNodeHolder |
	  aBarNode middleContainer addChild:
		  (ToLabel text: aNodeHolder dataItem asString) ]
]

{ #category : #accessing }
ToElementBarContainerElement >> nodeClass [ 

	^ self defaultNodeClass
]

{ #category : #initialization }
ToElementBarContainerElement >> nodeHolderClass [ 

	^ ToElementBarNodeHolder
]

{ #category : #'api - hooks' }
ToElementBarContainerElement >> onInstalledIn: anElementBar [

	elementBar := anElementBar.
	self isHorizontal
		ifTrue: [
			self
				vFitContent;
				hMatchParent;
				constraintsDo: [ :c | c linear vertical alignCenter ] ]
		ifFalse: [
			self
				hFitContent;
				vMatchParent;
				constraintsDo: [ :c | c linear horizontal alignCenter ] ]
]

{ #category : #'api - hooks' }
ToElementBarContainerElement >> onUninstalledIn: anElementBar [

	elementBar := nil
]

{ #category : #accessing }
ToElementBarContainerElement >> refresh [

	self subclassResponsibility 
]

{ #category : #accessing }
ToElementBarContainerElement >> selectedDataTextField [

	^ self textInputElement selectedDataTextField
]
