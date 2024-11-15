Class {
	#name : #ToCompositeTagModel,
	#superclass : #ToAbstractTagModel,
	#instVars : [
		'content',
		'items'
	],
	#category : #'Toplo-Widget-Tag-Bar'
}

{ #category : #'node building' }
ToCompositeTagModel >> buildNode: aNode fromManager: aNodeManager [

	aNodeManager buildNode: aNode forCompositeTagModel: self
]

{ #category : #accessing }
ToCompositeTagModel >> content [

	^ content
]

{ #category : #accessing }
ToCompositeTagModel >> content: anObject [

	content := anObject
]

{ #category : #testing }
ToCompositeTagModel >> isComposite [

	^ true
]

{ #category : #accessing }
ToCompositeTagModel >> items [

	^ items
]

{ #category : #accessing }
ToCompositeTagModel >> items: aCollection [

	items := aCollection asArray
]

{ #category : #accessing }
ToCompositeTagModel >> nodesCount [ 
	
	^ items size
]
