Class {
	#name : #ToMultiSelectCompositeItem,
	#superclass : #ToAbstractMultiSelectItem,
	#instVars : [
		'indexes',
		'content',
		'items'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'node building' }
ToMultiSelectCompositeItem >> buildNode: aNode inHolder: aNodeHolder withManager: aNodeManager [

	aNodeManager compositeNodeBuilder
		value: aNode
		value: self
		value: aNodeHolder
]

{ #category : #accessing }
ToMultiSelectCompositeItem >> content [

	^ content
]

{ #category : #accessing }
ToMultiSelectCompositeItem >> content: anObject [

	content := anObject
]

{ #category : #accessing }
ToMultiSelectCompositeItem >> dataItems [

	^ items
]

{ #category : #accessing }
ToMultiSelectCompositeItem >> dataItems: aCollection [

	items := aCollection asArray
]

{ #category : #accessing }
ToMultiSelectCompositeItem >> index [

	^ -1
]

{ #category : #accessing }
ToMultiSelectCompositeItem >> indexes [

	^ indexes
]

{ #category : #accessing }
ToMultiSelectCompositeItem >> indexes: aCollection [

	indexes := aCollection asArray
]

{ #category : #testing }
ToMultiSelectCompositeItem >> isComposite [

	^ true
]

{ #category : #accessing }
ToMultiSelectCompositeItem >> items [

	^ items
]

{ #category : #accessing }
ToMultiSelectCompositeItem >> items: aCollection [

	items := aCollection asArray
]

{ #category : #accessing }
ToMultiSelectCompositeItem >> nodesCount [ 
	
	^ items size
]
