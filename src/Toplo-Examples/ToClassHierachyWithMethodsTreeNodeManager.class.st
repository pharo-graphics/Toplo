Class {
	#name : #ToClassHierachyWithMethodsTreeNodeManager,
	#superclass : #ToTreeNodeManager,
	#category : #'Toplo-Examples-TopLevel-Tree'
}

{ #category : #initialization }
ToClassHierachyWithMethodsTreeNodeManager >> buildNode: aTreeNode [

	| content |
	content := ToElement new.
	content vFitContent.
	content id: #content.
	content addChild:
		(ToLabel text: aTreeNode holder treeDataItem asString).
	aTreeNode addChild: content
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
