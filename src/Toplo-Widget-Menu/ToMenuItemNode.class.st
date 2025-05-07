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
