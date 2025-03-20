Class {
	#name : #ToAbstractTag,
	#superclass : #Object,
	#category : #'Toplo-Widget-Tag-Tag'
}

{ #category : #'node building' }
ToAbstractTag >> buildNode: aNode fromManager: aNodeManager [

	self subclassResponsibility 
]

{ #category : #testing }
ToAbstractTag >> isComposite [

	^ false
]

{ #category : #accessing }
ToAbstractTag >> items [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToAbstractTag >> nodesCount [

	^ self subclassResponsibility
]
