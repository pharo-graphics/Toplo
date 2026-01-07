Class {
	#name : #ToExClassHierachyWithMethodsTreeNodeManager,
	#superclass : #ToTreeNodeManager,
	#category : #'Toplo-Examples-TopLevel-Trees'
}

{ #category : #initialization }
ToExClassHierachyWithMethodsTreeNodeManager >> buildNode: aNode [ 

	aNode addChild: (ToLabel text: aNode holder dataItem asString)
]

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

{ #category : #initialization }
ToExClassHierachyWithMethodsTreeNodeManager >> defaultNodeFactory [ 

	^ [ :holder | ToExTreeSubAndMethNode new ]
]
