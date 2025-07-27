Class {
	#name : #ToMenuItemNode,
	#superclass : #ToBarItemNode,
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #configuration }
ToMenuItemNode >> applyConfiguration [

	super applyConfiguration.
	self item applyConfiguration
]

{ #category : #'t - item node' }
ToMenuItemNode >> newRawSkin [ 

	^ ToMenuItemNodeSkin new
]
