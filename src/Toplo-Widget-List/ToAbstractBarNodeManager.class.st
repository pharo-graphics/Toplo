Class {
	#name : #ToAbstractBarNodeManager,
	#superclass : #ToAbstractNodeManager,
	#instVars : [
		'fakeDataItem'
	],
	#category : #'Toplo-Widget-List-Core'
}

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
ToAbstractBarNodeManager >> newFakeNodeContainer [ 

	^ ToFiniteListFakeNodeContainer new
]

{ #category : #'instance creation' }
ToAbstractBarNodeManager >> newFakeNodeContainerIn: aBarElement [

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
ToAbstractBarNodeManager >> newNodeContainer [ 

	^ ToFiniteListNodeContainer new
]
