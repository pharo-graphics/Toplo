Class {
	#name : #ToAbstractMultiSelectDataItem,
	#superclass : #Object,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'node building' }
ToAbstractMultiSelectDataItem >> buildNode: aNode inHolder: aNodeHolder withManager: aNodeManager [

	self subclassResponsibility 
]

{ #category : #accessing }
ToAbstractMultiSelectDataItem >> indexes [

	^ self subclassResponsibility 
]

{ #category : #testing }
ToAbstractMultiSelectDataItem >> isComposite [

	^ false
]

{ #category : #accessing }
ToAbstractMultiSelectDataItem >> items [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToAbstractMultiSelectDataItem >> nodesCount [

	^ self subclassResponsibility
]
