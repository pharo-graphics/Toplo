Class {
	#name : #ToCompositeTag,
	#superclass : #ToAbstractTag,
	#instVars : [
		'content',
		'items'
	],
	#category : #'Toplo-Widget-Tag-Tag'
}

{ #category : #'node building' }
ToCompositeTag >> buildNode: aNode fromManager: aNodeManager [

	aNodeManager buildNode: aNode forCompositeTagModel: self
]

{ #category : #accessing }
ToCompositeTag >> content [

	^ content
]

{ #category : #accessing }
ToCompositeTag >> content: anObject [

	content := anObject
]

{ #category : #testing }
ToCompositeTag >> isComposite [

	^ true
]

{ #category : #accessing }
ToCompositeTag >> items [

	^ items
]

{ #category : #accessing }
ToCompositeTag >> items: aCollection [

	items := aCollection asArray
]

{ #category : #accessing }
ToCompositeTag >> nodesCount [ 
	
	^ items size
]
