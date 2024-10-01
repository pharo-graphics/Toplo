Class {
	#name : #ToBarCompositeItem,
	#superclass : #ToAbstractBarItem,
	#instVars : [
		'indexes',
		'content',
		'items'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'node building' }
ToBarCompositeItem >> buildNode: aNode inHolder: aNodeHolder withManager: aNodeManager [

	aNodeManager compositeNodeBuilder
		value: aNode
		value: self
		value: aNodeHolder
]

{ #category : #accessing }
ToBarCompositeItem >> content [

	^ content
]

{ #category : #accessing }
ToBarCompositeItem >> content: anObject [

	content := anObject
]

{ #category : #accessing }
ToBarCompositeItem >> dataItems [

	^ items
]

{ #category : #accessing }
ToBarCompositeItem >> dataItems: aCollection [

	items := aCollection asArray
]

{ #category : #accessing }
ToBarCompositeItem >> index [

	^ -1
]

{ #category : #accessing }
ToBarCompositeItem >> indexes [

	^ indexes
]

{ #category : #accessing }
ToBarCompositeItem >> indexes: aCollection [

	indexes := aCollection asArray
]

{ #category : #testing }
ToBarCompositeItem >> isComposite [

	^ true
]

{ #category : #accessing }
ToBarCompositeItem >> items [

	^ items
]

{ #category : #accessing }
ToBarCompositeItem >> items: aCollection [

	items := aCollection asArray
]

{ #category : #accessing }
ToBarCompositeItem >> nodesCount [ 
	
	^ items size
]
