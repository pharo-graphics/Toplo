Class {
	#name : #ToMenuItemNode,
	#superclass : #ToListItemNode,
	#category : #'Toplo-Widget-Menu-ItemList'
}

{ #category : #configuration }
ToMenuItemNode >> applyConfiguration [

	super applyConfiguration.
	self holder listElement isHorizontal
		ifTrue: [ self hFitContent ]
		ifFalse: [ self hMatchParent ].
	self vFitContent.
	self item applyConfiguration
]

{ #category : #'t - item node' }
ToMenuItemNode >> newRawSkin [ 

	^ ToMenuItemNodeSkin new
]
