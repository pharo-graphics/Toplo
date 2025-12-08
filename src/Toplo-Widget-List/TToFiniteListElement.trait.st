"
My fakeData item is an item that is used to define the size when the list has no element.
This avoids flickering or changing size when inappropriate.
"
Trait {
	#name : #TToFiniteListElement,
	#instVars : [
		'fakeDataItem'
	],
	#category : #'Toplo-Widget-List-Core-FiniteListElement'
}

{ #category : #'t - finite list element - fake container' }
TToFiniteListElement >> addFakeNodeContainer: aNodeContainer [

	self addChild: aNodeContainer at: 1
]

{ #category : #'t - finite list element - fake container' }
TToFiniteListElement >> defaultFakeDataItem [

	^ nil
]

{ #category : #'t - finite list element' }
TToFiniteListElement >> defaultInnerElementClass [

	^ ToInnerFiniteListElement 
]

{ #category : #'t - finite list element - fake container' }
TToFiniteListElement >> fakeDataItem [

	^ fakeDataItem
]

{ #category : #'t - finite list element - fake container' }
TToFiniteListElement >> fakeDataItem: anObject [

	fakeDataItem := anObject
]

{ #category : #'t - finite list element - fake container' }
TToFiniteListElement >> fakeNodeContainer [

	^ (self hasChildren and: [ self firstChild isFake ])
		  ifTrue: [ self firstChild ]
		  ifFalse: [ ]
]

{ #category : #'t - finite list element' }
TToFiniteListElement >> initializeAsFiniteListElement [

	fakeDataItem := self defaultFakeDataItem.
	self installFakeNodeContainer
]

{ #category : #'t - finite list element - fake container' }
TToFiniteListElement >> installFakeNodeContainer [
	" the fake node is added in case of an empty data source to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	| fakeContainer holder |
	holder := self nodeManager newHolder.
	holder infiniteElement: self innerElement.
	holder dataItem: self fakeDataItem.
	holder bindAtPosition: 0.
	fakeContainer := self newFakeNodeContainer.
	fakeContainer holder: holder.
	fakeContainer id: #fakeNodeContainer.
	holder setupNodeContainerWith: fakeContainer.
	" add the fake node (to keep a constant minimum size ).
	Pay attention to add the fake node ** before ** the fake node building "
	self addFakeNodeContainer: fakeContainer.
	self nodeManager buildNode: fakeContainer node.
	self requestConfiguration
]

{ #category : #'t - finite list element - fake container' }
TToFiniteListElement >> newFakeNodeContainer [ 

	^ ToFiniteListFakeNodeContainer new
]

{ #category : #'t - finite list element - fake container' }
TToFiniteListElement >> reinstallFakeNodeContainer [

	self uninstallFakeNodeContainer.
	self installFakeNodeContainer
]

{ #category : #'t - finite list element - fake container' }
TToFiniteListElement >> removeFakeNodeContainer [

	self fakeNodeContainer ifNil: [ Error signal: 'Fake node container not present' ].
	self fakeNodeContainer removeFromParent
]

{ #category : #'t - finite list element - fake container' }
TToFiniteListElement >> sample [

	^ self fakeDataItem
]

{ #category : #'t - finite list element - fake container' }
TToFiniteListElement >> sample: aDataItem [

	self fakeDataItem: aDataItem.
	self reinstallFakeNodeContainer.
	self requestLayout
	
]

{ #category : #'t - finite list element' }
TToFiniteListElement >> trackElement [

	^ self innerElement trackElement
]

{ #category : #'t - finite list element - fake container' }
TToFiniteListElement >> uninstallFakeNodeContainer [
	" the fake node is added in case of an empty data source to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	" remove the fake node (to keep a constant minimum size ) "
	self removeFakeNodeContainer
]
