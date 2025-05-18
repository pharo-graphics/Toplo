Class {
	#name : #ToClassHierachyWithMethodsTreeNodeManager,
	#superclass : #ToTreeNodeManager,
	#category : #'Toplo-Widget-Tree-examples'
}

{ #category : #initialization }
ToClassHierachyWithMethodsTreeNodeManager >> buildNode: aTreeNode [

	aTreeNode middleElement:
		(ToLabel text: aTreeNode holder dataItem asString)
]

{ #category : #'children accessing' }
ToClassHierachyWithMethodsTreeNodeManager >> childrenFromDataItem: aClassOrMethod [

	^ aClassOrMethod isClass
			ifTrue: [
				Array streamContents: [ :stream |
					stream nextPutAll: aClassOrMethod subclasses.
					stream nextPutAll:
						(aClassOrMethod methods collect: [ :each | each selector ]) sorted ] ]
			ifFalse: [ #(  ) ]
]

{ #category : #'instance creation' }
ToClassHierachyWithMethodsTreeNodeManager >> newNodeForHolder: aNodeHolder [

	^  ToTreeSubAndMethNode new
]
