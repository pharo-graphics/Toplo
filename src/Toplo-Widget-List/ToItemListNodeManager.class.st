Class {
	#name : #ToItemListNodeManager,
	#superclass : #ToBasicListNodeManager,
	#instVars : [
		'itemConfigurator'
	],
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #initialization }
ToItemListNodeManager >> buildNode: aNode [

	| holder |
	holder := aNode holder.
	aNode item: holder dataItem
]

{ #category : #'node configuration' }
ToItemListNodeManager >> configureItem: anItem [

	itemConfigurator value: anItem
]

{ #category : #initialization }
ToItemListNodeManager >> defaultItemConfigurator [

	^ [ :item | ]
]

{ #category : #initialization }
ToItemListNodeManager >> defaultNodeContainerFactory [

	^ [ ToItemNodeContainer new ]
]

{ #category : #initialization }
ToItemListNodeManager >> defaultNodeFactory [ 

	^ [ :holder | ToListItemNode new ]
]

{ #category : #initialization }
ToItemListNodeManager >> defaultNodeHolderFactory [ 

	^ [ ToItemNodeHolder new ]
]

{ #category : #initialization }
ToItemListNodeManager >> initialize [ 

	super initialize.
	itemConfigurator := self defaultItemConfigurator 
]

{ #category : #accessing }
ToItemListNodeManager >> itemConfigurator: aValuable [

	itemConfigurator := aValuable 
]

{ #category : #initialization }
ToItemListNodeManager >> unbuildNode: aNode [

	aNode item removeFromParent
]
