Class {
	#name : #ToTreeNodeManager,
	#superclass : #ToAbstractNodeManager,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'children accessing' }
ToTreeNodeManager >> childrenFromDataItem: aDataItem [

	^ self subclassResponsibility 
]

{ #category : #'t - generic node manager' }
ToTreeNodeManager >> newHolder [

	^ ToTreeNodeHolder new
]
