Class {
	#name : #ToAbstractBarNodeManager,
	#superclass : #ToAbstractNodeManager,
	#instVars : [
		'fakeDataItem'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToAbstractBarNodeManager >> constraintFakeNode: aNode [

	| bar |
	bar := aNode holder listElement.
	self constraintNode: aNode.
	bar isHorizontal
		ifTrue: [ aNode constraintsDo: [ :c | c horizontal exact: 0 ] ]
		ifFalse: [ aNode constraintsDo: [ :c | c vertical exact: 0 ] ]
]

{ #category : #initialization }
ToAbstractBarNodeManager >> constraintNode: aNode [

	| bar |
	bar := aNode holder listElement.
	bar isWrapping
		ifFalse: [
			bar isVertical
				ifTrue: [
					bar isHMatchParent
						ifTrue: [ aNode hMatchParent ]
						ifFalse: [ aNode hFitContent ].
					bar autoDistribute
						ifTrue: [ aNode vMatchParent ]
						ifFalse: [ aNode vFitContent ] ]
				ifFalse: [
					bar isVMatchParent
						ifTrue: [ aNode vMatchParent ]
						ifFalse: [ aNode vFitContent ].
					bar autoDistribute
						ifTrue: [ aNode hMatchParent ]
						ifFalse: [ aNode hFitContent ] ] ]
		ifTrue: [ aNode fitContent ].

	aNode constraintsDo: [ :c |
		c linear vertical alignCenter.
		c flow vertical alignCenter ].

	bar isWrapping ifTrue: [ ^ self ].
	bar isScrolling ifTrue: [ ^ self ].
	bar autoDistribute ifFalse: [ ^ self ].

	bar isHorizontal
		ifTrue: [ aNode hMatchParent ]
		ifFalse: [ aNode vMatchParent ]
]

{ #category : #initialization }
ToAbstractBarNodeManager >> defaultFakeDataItem [

	^ nil
]

{ #category : #accessing }
ToAbstractBarNodeManager >> fakeDataItem [

	^ fakeDataItem
]

{ #category : #accessing }
ToAbstractBarNodeManager >> fakeDataItem: anObject [

	fakeDataItem := anObject
]

{ #category : #initialization }
ToAbstractBarNodeManager >> initialize [ 

	super initialize.
	fakeDataItem := self defaultFakeDataItem 
]

{ #category : #'instance creation' }
ToAbstractBarNodeManager >> newFakeNodeIn: anInnerBarElement [

	| holder fakeNode |
	holder := self newHolder.
	holder infiniteElement: anInnerBarElement.
	holder dataItem: fakeDataItem.
	holder bindAtPosition: 0.
	fakeNode := self newNodeForHolder: holder.
	fakeNode id: #fakeNode.
	holder setupNodeWith: fakeNode.
	^ fakeNode
]
