Class {
	#name : #ToItemListConfiguration,
	#superclass : #ToListConfiguration,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #'node configuration' }
ToItemListConfiguration >> configureItem: anItem [

	anItem isHExact ifTrue: [ ^ self ].
	anItem listHolderDo: [ :h |
			h listElement isHorizontal
				ifTrue: [ anItem hFitContent ]
				ifFalse: [ anItem hMatchParent ] ]
]

{ #category : #'node configuration' }
ToItemListConfiguration >> configureNode: aNode [

	super configureNode: aNode.
	aNode item ifNil: [ ^ self ].
	self configureItem: aNode item
]
