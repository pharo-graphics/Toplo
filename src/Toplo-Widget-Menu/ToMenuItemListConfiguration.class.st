Class {
	#name : #ToMenuItemListConfiguration,
	#superclass : #ToListConfiguration,
	#category : #'Toplo-Widget-Menu-ItemList'
}

{ #category : #'node configuration' }
ToMenuItemListConfiguration >> configureNode: aNode [

	super configureNode: aNode.
	aNode isVExact ifFalse: [ aNode vFitContent ]
]
