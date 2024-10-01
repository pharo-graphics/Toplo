Class {
	#name : #ToAbstractBarItem,
	#superclass : #Object,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'node building' }
ToAbstractBarItem >> buildNode: aNode inHolder: aNodeHolder withManager: aNodeManager [

	self subclassResponsibility 
]

{ #category : #accessing }
ToAbstractBarItem >> indexes [

	^ self subclassResponsibility 
]

{ #category : #testing }
ToAbstractBarItem >> isComposite [

	^ false
]

{ #category : #accessing }
ToAbstractBarItem >> items [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToAbstractBarItem >> nodesCount [

	^ self subclassResponsibility
]
