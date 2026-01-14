Class {
	#name : #ToMenuItemListConfiguration,
	#superclass : #ToItemListConfiguration,
	#category : #'Toplo-Widget-Menu-ItemList'
}

{ #category : #'node configuration' }
ToMenuItemListConfiguration >> configureItem: anItem [

	super configureItem: anItem.
	anItem requestNewSkin
]

{ #category : #'node configuration' }
ToMenuItemListConfiguration >> configureNode: aNode [

	super configureNode: aNode.
	aNode isVExact ifFalse: [ aNode vFitContent ]
]
