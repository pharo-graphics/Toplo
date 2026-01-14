Class {
	#name : #ToItemListConfiguration,
	#superclass : #ToListConfiguration,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #'node configuration' }
ToItemListConfiguration >> configureItem: anItem [


]

{ #category : #'node configuration' }
ToItemListConfiguration >> configureNode: aNode [

	super configureNode: aNode.
	aNode item ifNil: [ ^ self ].
	self configureItem: aNode item
]
