Class {
	#name : #ToSelectReadOnlyMode,
	#superclass : #ToSelectMode,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #adding }
ToSelectReadOnlyMode >> addDataNode: aNode [

	select nodeContainer addChild: aNode before: select fakeNode
]

{ #category : #'accessing selection' }
ToSelectReadOnlyMode >> deselectIndex: anIndex [

	select listElement selectionStrategy deselectIndex: anIndex.
]

{ #category : #'accessing selection' }
ToSelectReadOnlyMode >> selectIndex: anIndex [

	select listElement selectionStrategy selectIndex: anIndex
]

{ #category : #'accessing selection' }
ToSelectReadOnlyMode >> selectIndexes: aCollection [

	select listElement selectionStrategy selectIndexes: aCollection
]
