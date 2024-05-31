Class {
	#name : #ToMultiSelectBarNodeManager,
	#superclass : #ToBarNodeManager,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #initialization }
ToMultiSelectBarNodeManager >> defaultNodeBuilder [

	^ [ :node :holder :indexInList |
	  | d |
	  d := indexInList isZero
		       ifTrue: [ self fakeDataItem ]
		       ifFalse: [ holder dataAccessor at: indexInList ].
	  node middleElement: (ToLabel text: d asString).
	  node autoDistribute: holder listElement nodeAutoDistribution ]
]

{ #category : #initialization }
ToMultiSelectBarNodeManager >> defaultNodeFactory [

	^ [ :holder | ToMultiSelectBarNode new ]
]

{ #category : #initialization }
ToMultiSelectBarNodeManager >> defaultNodeHolderClass [ 

	^ ToMultiSelectBarNodeHolder
]
