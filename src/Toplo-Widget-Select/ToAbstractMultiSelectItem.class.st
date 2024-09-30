Class {
	#name : #ToAbstractMultiSelectItem,
	#superclass : #Object,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'node building' }
ToAbstractMultiSelectItem >> buildNode: aNode inHolder: aNodeHolder withManager: aNodeManager [

	self subclassResponsibility 
]

{ #category : #accessing }
ToAbstractMultiSelectItem >> indexes [

	^ self subclassResponsibility 
]

{ #category : #testing }
ToAbstractMultiSelectItem >> isComposite [

	^ false
]

{ #category : #accessing }
ToAbstractMultiSelectItem >> items [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToAbstractMultiSelectItem >> nodesCount [

	^ self subclassResponsibility
]
