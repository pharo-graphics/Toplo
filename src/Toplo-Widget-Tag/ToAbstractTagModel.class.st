Class {
	#name : #ToAbstractTagModel,
	#superclass : #Object,
	#category : #'Toplo-Widget-Tag-Bar'
}

{ #category : #'node building' }
ToAbstractTagModel >> buildNode: aNode withManager: aNodeManager [

	self subclassResponsibility 
]

{ #category : #testing }
ToAbstractTagModel >> isComposite [

	^ false
]

{ #category : #accessing }
ToAbstractTagModel >> items [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToAbstractTagModel >> nodesCount [

	^ self subclassResponsibility
]
