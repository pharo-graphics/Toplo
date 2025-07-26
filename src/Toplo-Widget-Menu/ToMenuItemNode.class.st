Class {
	#name : #ToMenuItemNode,
	#superclass : #ToBarItemNode,
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #configuration }
ToMenuItemNode >> applyDownwardConfiguration [

	super applyDownwardConfiguration.
	self item applyDownwardConfiguration
]

{ #category : #'t - item node' }
ToMenuItemNode >> newRawSkin [ 

	^ ToMenuItemNodeSkin new
]
