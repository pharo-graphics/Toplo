Class {
	#name : #ToAccordionListNodeManager,
	#superclass : #ToListNodeManager,
	#instVars : [
		'itemBuilder',
		'itemFactory'
	],
	#category : #'Toplo-Widget-Accordion-List'
}

{ #category : #initialization }
ToAccordionListNodeManager >> buildNode: aNode [

	| item |
	aNode removeChildren.
	item := self newItemForNode: aNode.
	itemBuilder cull: item cull: aNode holder dataItem cull: aNode holder.
	(aNode holder listElement selectionModel containsIndex:
		 aNode holder position) ifTrue: [ item checked: true ].
	aNode item: item 
]

{ #category : #initialization }
ToAccordionListNodeManager >> defaultItemBuilder [

	^ [ :node :accordionItem :holder |  ]
]

{ #category : #initialization }
ToAccordionListNodeManager >> defaultItemFactory [

	^ [ :node | ToAccordionItemElement new ]
]

{ #category : #initialization }
ToAccordionListNodeManager >> defaultNodeFactory [

	^ [ :holder |
		  | node |
		  node := ToAccordionListNode new.
		  node hMatchParent.
		  node vFitContent.
		  node ]
]

{ #category : #initialization }
ToAccordionListNodeManager >> defaultNodeHolderFactory [ 

	^ [ ToAccordionListNodeHolder new ]
]

{ #category : #initialization }
ToAccordionListNodeManager >> initialize [ 

	super initialize.
	itemFactory := self defaultItemFactory.
	itemBuilder := self defaultItemBuilder
]

{ #category : #initialization }
ToAccordionListNodeManager >> itemBuilder: aValuable [
	" aValuable has 3 arguments: the accordionElement (the item), the data and the holder "

	itemBuilder := aValuable
]

{ #category : #initialization }
ToAccordionListNodeManager >> itemFactory: aValuable [
	" aValuable has the node as argument"

	itemFactory := aValuable
]

{ #category : #'instance creation' }
ToAccordionListNodeManager >> newItemForNode: aNode [

	^ itemFactory value: aNode
]
