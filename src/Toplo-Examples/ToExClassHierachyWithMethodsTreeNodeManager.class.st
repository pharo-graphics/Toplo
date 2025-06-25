Class {
	#name : #ToExClassHierachyWithMethodsTreeNodeManager,
	#superclass : #ToTreeNodeManager,
	#category : #'Toplo-Examples-TopLevel-Trees'
}

{ #category : #'children accessing' }
ToExClassHierachyWithMethodsTreeNodeManager >> childrenFromDataItem: aClassOrMethod [

	^ aClassOrMethod isClass
			ifTrue: [
				Array streamContents: [ :stream |
					stream nextPutAll: aClassOrMethod subclasses.
					stream nextPutAll:
						(aClassOrMethod methods collect: [ :each | each selector ]) sorted ] ]
			ifFalse: [ #(  ) ]
]

{ #category : #'instance creation' }
ToExClassHierachyWithMethodsTreeNodeManager >> newNodeForHolder: aNodeHolder [

	^  ToExTreeSubAndMethNode new
]
