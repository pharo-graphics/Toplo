Class {
	#name : #ToMultiSelectBarNodeManager,
	#superclass : #ToBarNodeManager,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #initialization }
ToMultiSelectBarNodeManager >> defaultNodeBuilder [

	^ [ :node :holder :dataItem |
	  | d index t |
	  dataItem nodesCount = 1
		  ifTrue: [
			  index := dataItem index.
			  d := index isZero
				       ifTrue: [ self fakeDataItem ]
				       ifFalse: [ holder dataAccessor at: index ].
			  t := d asString ]
		  ifFalse: [ t := dataItem content ].

	  node middleElement: (ToLabel text: t).
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
