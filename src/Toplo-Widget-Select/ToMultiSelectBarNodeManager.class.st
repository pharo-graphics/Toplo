Class {
	#name : #ToMultiSelectBarNodeManager,
	#superclass : #ToBarNodeManager,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #initialization }
ToMultiSelectBarNodeManager >> defaultNodeBuilder [

	^ [ :node :holder :dataItem |
	  node middleElement: (ToLabel text: dataItem asString).
	  node autoDistribute: holder listElement nodeAutoDistribution ]
]

{ #category : #initialization }
ToMultiSelectBarNodeManager >> defaultNodeFactory [

	^ [ :holder | ToMultiSelectBarNode new ]
]
