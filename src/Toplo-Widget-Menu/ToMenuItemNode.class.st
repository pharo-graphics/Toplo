Class {
	#name : #ToMenuItemNode,
	#superclass : #ToBarItemNode,
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #configuration }
ToMenuItemNode >> applyUpwardConfiguration [

	super applyUpwardConfiguration.
	self item applyUpwardConfiguration
]

{ #category : #'t - item node' }
ToMenuItemNode >> newRawSkin [ 

	^ ToMenuItemNodeSkin new
]
