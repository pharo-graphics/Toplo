Class {
	#name : #ToMenuItemNode,
	#superclass : #ToBarItemNode,
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #configuration }
ToMenuItemNode >> applyWidgetConfiguration [

	super applyWidgetConfiguration.
	self item applyWidgetConfiguration
]

{ #category : #'t - item node' }
ToMenuItemNode >> newRawSkin [ 

	^ ToMenuItemNodeSkin new
]
