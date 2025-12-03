Class {
	#name : #ToAbstractFiniteNodeManager,
	#superclass : #ToAbstractNodeManager,
	#instVars : [
		'fakeDataItem'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToAbstractFiniteNodeManager >> defaultFakeDataItem [

	^ nil
]

{ #category : #accessing }
ToAbstractFiniteNodeManager >> fakeDataItem [

	^ fakeDataItem
]

{ #category : #accessing }
ToAbstractFiniteNodeManager >> fakeDataItem: anObject [

	fakeDataItem := anObject
]

{ #category : #initialization }
ToAbstractFiniteNodeManager >> initialize [ 

	super initialize.
	fakeDataItem := self defaultFakeDataItem 
]

{ #category : #'instance creation' }
ToAbstractFiniteNodeManager >> newFakeNodeContainer [ 

	^ ToFiniteListFakeNodeContainer new
]

{ #category : #'instance creation' }
ToAbstractFiniteNodeManager >> newFakeNodeContainerIn: aBarElement [

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

{ #category : #'instance creation' }
ToAbstractFiniteNodeManager >> newNodeContainer [ 

	^ ToFiniteListNodeContainer new
]
