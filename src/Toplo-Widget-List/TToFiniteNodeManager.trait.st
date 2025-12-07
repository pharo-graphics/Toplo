"
I'm node manager for finite lists.
My fakeData item is an item that is used to define the size when the list has no element.
This avoids flickering or changing size when inappropriate.
"
Trait {
	#name : #TToFiniteNodeManager,
	#instVars : [
		'fakeDataItem'
	],
	#category : #'Toplo-Widget-List-Core-FiniteListElement'
}

{ #category : #'t - finite node manager - initialization' }
TToFiniteNodeManager >> defaultFakeDataItem [

	^ nil
]

{ #category : #'t - finite node manager - accessing' }
TToFiniteNodeManager >> fakeDataItem [

	^ fakeDataItem
]

{ #category : #'t - finite node manager - accessing' }
TToFiniteNodeManager >> fakeDataItem: anObject [

	fakeDataItem := anObject
]

{ #category : #'t - finite node manager - initialization' }
TToFiniteNodeManager >> initializeAsFiniteNodeManager [

	fakeDataItem := self defaultFakeDataItem 
]

{ #category : #'t - finite node manager - initialization' }
TToFiniteNodeManager >> newFakeNodeContainer [ 

	^ ToFiniteListFakeNodeContainer new
]

{ #category : #'t - finite node manager - initialization' }
TToFiniteNodeManager >> newFakeNodeContainerIn: aBarElement [

	| holder fakeContainer |
	holder := self newHolder.
	holder infiniteElement: aBarElement innerElement.
	holder dataItem: fakeDataItem.
	holder bindAtPosition: 0.
	fakeContainer := self newFakeNodeContainer.
	fakeContainer holder: holder.
	fakeContainer id: #fakeNodeContainer.
	holder setupNodeContainerWith: fakeContainer.
	^ fakeContainer
]

{ #category : #'t - finite node manager - initialization' }
TToFiniteNodeManager >> newNodeContainer [ 

	^ ToFiniteListNodeContainer new
]
