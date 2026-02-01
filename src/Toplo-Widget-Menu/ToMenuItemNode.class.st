Class {
	#name : #ToMenuItemNode,
	#superclass : #ToListItemNode,
	#category : #'Toplo-Widget-Menu-ItemList'
}

{ #category : #configuration }
ToMenuItemNode >> applyConfiguration [ 

	super applyConfiguration.
	self isVExact ifFalse: [ self vFitContent ]
]

{ #category : #'t - item node' }
ToMenuItemNode >> newRawSkin [ 

	^ ToMenuItemNodeSkin new
]
